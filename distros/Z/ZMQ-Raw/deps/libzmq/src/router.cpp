/*
    Copyright (c) 2007-2016 Contributors as noted in the AUTHORS file

    This file is part of libzmq, the ZeroMQ core engine in C++.

    libzmq is free software; you can redistribute it and/or modify it under
    the terms of the GNU Lesser General Public License (LGPL) as published
    by the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    As a special exception, the Contributors give you permission to link
    this library with independent modules to produce an executable,
    regardless of the license terms of these independent modules, and to
    copy and distribute the resulting executable under terms of your choice,
    provided that you also meet, for each linked independent module, the
    terms and conditions of the license of that module. An independent
    module is a module which is not derived from or based on this library.
    If you modify this library, you must extend this exception to your
    version of the library.

    libzmq is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
    License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "precompiled.hpp"
#include "macros.hpp"
#include "router.hpp"
#include "pipe.hpp"
#include "wire.hpp"
#include "random.hpp"
#include "likely.hpp"
#include "err.hpp"

zmq::router_t::router_t (class ctx_t *parent_, uint32_t tid_, int sid_) :
    socket_base_t (parent_, tid_, sid_),
    _prefetched (false),
    _routing_id_sent (false),
    _current_in (NULL),
    _terminate_current_in (false),
    _more_in (false),
    _current_out (NULL),
    _more_out (false),
    _next_integral_routing_id (generate_random ()),
    _mandatory (false),
    //  raw_socket functionality in ROUTER is deprecated
    _raw_socket (false),
    _probe_router (false),
    _handover (false)
{
    options.type = ZMQ_ROUTER;
    options.recv_routing_id = true;
    options.raw_socket = false;

    _prefetched_id.init ();
    _prefetched_msg.init ();
}

zmq::router_t::~router_t ()
{
    zmq_assert (_anonymous_pipes.empty ());
    ;
    zmq_assert (_out_pipes.empty ());
    _prefetched_id.close ();
    _prefetched_msg.close ();
}

void zmq::router_t::xattach_pipe (pipe_t *pipe_, bool subscribe_to_all_)
{
    LIBZMQ_UNUSED (subscribe_to_all_);

    zmq_assert (pipe_);

    if (_probe_router) {
        msg_t probe_msg;
        int rc = probe_msg.init ();
        errno_assert (rc == 0);

        rc = pipe_->write (&probe_msg);
        // zmq_assert (rc) is not applicable here, since it is not a bug.
        pipe_->flush ();

        rc = probe_msg.close ();
        errno_assert (rc == 0);
    }

    bool routing_id_ok = identify_peer (pipe_);
    if (routing_id_ok)
        _fq.attach (pipe_);
    else
        _anonymous_pipes.insert (pipe_);
}

int zmq::router_t::xsetsockopt (int option_,
                                const void *optval_,
                                size_t optvallen_)
{
    bool is_int = (optvallen_ == sizeof (int));
    int value = 0;
    if (is_int)
        memcpy (&value, optval_, sizeof (int));

    switch (option_) {
        case ZMQ_CONNECT_ROUTING_ID:
            // TODO why isn't it possible to set an empty connect_routing_id
            //   (which is the default value)
            if (optval_ && optvallen_) {
                connect_routing_id.assign ((char *) optval_, optvallen_);
                return 0;
            }
            break;

        case ZMQ_ROUTER_RAW:
            if (is_int && value >= 0) {
                _raw_socket = (value != 0);
                if (_raw_socket) {
                    options.recv_routing_id = false;
                    options.raw_socket = true;
                }
                return 0;
            }
            break;

        case ZMQ_ROUTER_MANDATORY:
            if (is_int && value >= 0) {
                _mandatory = (value != 0);
                return 0;
            }
            break;

        case ZMQ_PROBE_ROUTER:
            if (is_int && value >= 0) {
                _probe_router = (value != 0);
                return 0;
            }
            break;

        case ZMQ_ROUTER_HANDOVER:
            if (is_int && value >= 0) {
                _handover = (value != 0);
                return 0;
            }
            break;

        default:
            break;
    }
    errno = EINVAL;
    return -1;
}


void zmq::router_t::xpipe_terminated (pipe_t *pipe_)
{
    std::set<pipe_t *>::iterator it = _anonymous_pipes.find (pipe_);
    if (it != _anonymous_pipes.end ())
        _anonymous_pipes.erase (it);
    else {
        outpipes_t::iterator iter = _out_pipes.find (pipe_->get_routing_id ());
        zmq_assert (iter != _out_pipes.end ());
        _out_pipes.erase (iter);
        _fq.pipe_terminated (pipe_);
        pipe_->rollback ();
        if (pipe_ == _current_out)
            _current_out = NULL;
    }
}

void zmq::router_t::xread_activated (pipe_t *pipe_)
{
    std::set<pipe_t *>::iterator it = _anonymous_pipes.find (pipe_);
    if (it == _anonymous_pipes.end ())
        _fq.activated (pipe_);
    else {
        bool routing_id_ok = identify_peer (pipe_);
        if (routing_id_ok) {
            _anonymous_pipes.erase (it);
            _fq.attach (pipe_);
        }
    }
}

void zmq::router_t::xwrite_activated (pipe_t *pipe_)
{
    outpipes_t::iterator it;
    for (it = _out_pipes.begin (); it != _out_pipes.end (); ++it)
        if (it->second.pipe == pipe_)
            break;

    zmq_assert (it != _out_pipes.end ());
    zmq_assert (!it->second.active);
    it->second.active = true;
}

int zmq::router_t::xsend (msg_t *msg_)
{
    //  If this is the first part of the message it's the ID of the
    //  peer to send the message to.
    if (!_more_out) {
        zmq_assert (!_current_out);

        //  If we have malformed message (prefix with no subsequent message)
        //  then just silently ignore it.
        //  TODO: The connections should be killed instead.
        if (msg_->flags () & msg_t::more) {
            _more_out = true;

            //  Find the pipe associated with the routing id stored in the prefix.
            //  If there's no such pipe just silently ignore the message, unless
            //  router_mandatory is set.
            blob_t routing_id (static_cast<unsigned char *> (msg_->data ()),
                               msg_->size (), zmq::reference_tag_t ());
            outpipes_t::iterator it = _out_pipes.find (routing_id);

            if (it != _out_pipes.end ()) {
                _current_out = it->second.pipe;

                // Check whether pipe is closed or not
                if (!_current_out->check_write ()) {
                    // Check whether pipe is full or not
                    bool pipe_full = !_current_out->check_hwm ();
                    it->second.active = false;
                    _current_out = NULL;

                    if (_mandatory) {
                        _more_out = false;
                        if (pipe_full)
                            errno = EAGAIN;
                        else
                            errno = EHOSTUNREACH;
                        return -1;
                    }
                }
            } else if (_mandatory) {
                _more_out = false;
                errno = EHOSTUNREACH;
                return -1;
            }
        }

        int rc = msg_->close ();
        errno_assert (rc == 0);
        rc = msg_->init ();
        errno_assert (rc == 0);
        return 0;
    }

    //  Ignore the MORE flag for raw-sock or assert?
    if (options.raw_socket)
        msg_->reset_flags (msg_t::more);

    //  Check whether this is the last part of the message.
    _more_out = (msg_->flags () & msg_t::more) != 0;

    //  Push the message into the pipe. If there's no out pipe, just drop it.
    if (_current_out) {
        // Close the remote connection if user has asked to do so
        // by sending zero length message.
        // Pending messages in the pipe will be dropped (on receiving term- ack)
        if (_raw_socket && msg_->size () == 0) {
            _current_out->terminate (false);
            int rc = msg_->close ();
            errno_assert (rc == 0);
            rc = msg_->init ();
            errno_assert (rc == 0);
            _current_out = NULL;
            return 0;
        }

        bool ok = _current_out->write (msg_);
        if (unlikely (!ok)) {
            // Message failed to send - we must close it ourselves.
            int rc = msg_->close ();
            errno_assert (rc == 0);
            // HWM was checked before, so the pipe must be gone. Roll back
            // messages that were piped, for example REP labels.
            _current_out->rollback ();
            _current_out = NULL;
        } else {
            if (!_more_out) {
                _current_out->flush ();
                _current_out = NULL;
            }
        }
    } else {
        int rc = msg_->close ();
        errno_assert (rc == 0);
    }

    //  Detach the message from the data buffer.
    int rc = msg_->init ();
    errno_assert (rc == 0);

    return 0;
}

int zmq::router_t::xrecv (msg_t *msg_)
{
    if (_prefetched) {
        if (!_routing_id_sent) {
            int rc = msg_->move (_prefetched_id);
            errno_assert (rc == 0);
            _routing_id_sent = true;
        } else {
            int rc = msg_->move (_prefetched_msg);
            errno_assert (rc == 0);
            _prefetched = false;
        }
        _more_in = (msg_->flags () & msg_t::more) != 0;

        if (!_more_in) {
            if (_terminate_current_in) {
                _current_in->terminate (true);
                _terminate_current_in = false;
            }
            _current_in = NULL;
        }
        return 0;
    }

    pipe_t *pipe = NULL;
    int rc = _fq.recvpipe (msg_, &pipe);

    //  It's possible that we receive peer's routing id. That happens
    //  after reconnection. The current implementation assumes that
    //  the peer always uses the same routing id.
    while (rc == 0 && msg_->is_routing_id ())
        rc = _fq.recvpipe (msg_, &pipe);

    if (rc != 0)
        return -1;

    zmq_assert (pipe != NULL);

    //  If we are in the middle of reading a message, just return the next part.
    if (_more_in) {
        _more_in = (msg_->flags () & msg_t::more) != 0;

        if (!_more_in) {
            if (_terminate_current_in) {
                _current_in->terminate (true);
                _terminate_current_in = false;
            }
            _current_in = NULL;
        }
    } else {
        //  We are at the beginning of a message.
        //  Keep the message part we have in the prefetch buffer
        //  and return the ID of the peer instead.
        rc = _prefetched_msg.move (*msg_);
        errno_assert (rc == 0);
        _prefetched = true;
        _current_in = pipe;

        const blob_t &routing_id = pipe->get_routing_id ();
        rc = msg_->init_size (routing_id.size ());
        errno_assert (rc == 0);
        memcpy (msg_->data (), routing_id.data (), routing_id.size ());
        msg_->set_flags (msg_t::more);
        if (_prefetched_msg.metadata ())
            msg_->set_metadata (_prefetched_msg.metadata ());
        _routing_id_sent = true;
    }

    return 0;
}

int zmq::router_t::rollback ()
{
    if (_current_out) {
        _current_out->rollback ();
        _current_out = NULL;
        _more_out = false;
    }
    return 0;
}

bool zmq::router_t::xhas_in ()
{
    //  If we are in the middle of reading the messages, there are
    //  definitely more parts available.
    if (_more_in)
        return true;

    //  We may already have a message pre-fetched.
    if (_prefetched)
        return true;

    //  Try to read the next message.
    //  The message, if read, is kept in the pre-fetch buffer.
    pipe_t *pipe = NULL;
    int rc = _fq.recvpipe (&_prefetched_msg, &pipe);

    //  It's possible that we receive peer's routing id. That happens
    //  after reconnection. The current implementation assumes that
    //  the peer always uses the same routing id.
    //  TODO: handle the situation when the peer changes its routing id.
    while (rc == 0 && _prefetched_msg.is_routing_id ())
        rc = _fq.recvpipe (&_prefetched_msg, &pipe);

    if (rc != 0)
        return false;

    zmq_assert (pipe != NULL);

    const blob_t &routing_id = pipe->get_routing_id ();
    rc = _prefetched_id.init_size (routing_id.size ());
    errno_assert (rc == 0);
    memcpy (_prefetched_id.data (), routing_id.data (), routing_id.size ());
    _prefetched_id.set_flags (msg_t::more);

    _prefetched = true;
    _routing_id_sent = false;
    _current_in = pipe;

    return true;
}

bool zmq::router_t::xhas_out ()
{
    //  In theory, ROUTER socket is always ready for writing (except when
    //  MANDATORY is set). Whether actual attempt to write succeeds depends
    //  on whitch pipe the message is going to be routed to.

    if (!_mandatory)
        return true;

    bool has_out = false;
    outpipes_t::iterator it;
    for (it = _out_pipes.begin (); it != _out_pipes.end (); ++it)
        has_out |= it->second.pipe->check_hwm ();

    return has_out;
}

const zmq::blob_t &zmq::router_t::get_credential () const
{
    return _fq.get_credential ();
}

int zmq::router_t::get_peer_state (const void *routing_id_,
                                   size_t routing_id_size_) const
{
    int res = 0;

    blob_t routing_id_blob ((unsigned char *) routing_id_, routing_id_size_);
    outpipes_t::const_iterator it = _out_pipes.find (routing_id_blob);
    if (it == _out_pipes.end ()) {
        errno = EHOSTUNREACH;
        return -1;
    }

    const out_pipe_t &outpipe = it->second;
    if (outpipe.pipe->check_hwm ())
        res |= ZMQ_POLLOUT;

    /** \todo does it make any sense to check the inpipe as well? */

    return res;
}

bool zmq::router_t::identify_peer (pipe_t *pipe_)
{
    msg_t msg;
    bool ok;
    blob_t routing_id;

    if (connect_routing_id.length ()) {
        routing_id.set ((unsigned char *) connect_routing_id.c_str (),
                        connect_routing_id.length ());
        connect_routing_id.clear ();
        outpipes_t::iterator it = _out_pipes.find (routing_id);
        if (it != _out_pipes.end ())
            zmq_assert (false); //  Not allowed to duplicate an existing rid
    } else if (
      options
        .raw_socket) { //  Always assign an integral routing id for raw-socket
        unsigned char buf[5];
        buf[0] = 0;
        put_uint32 (buf + 1, _next_integral_routing_id++);
        routing_id.set (buf, sizeof buf);
    } else if (!options.raw_socket) {
        //  Pick up handshake cases and also case where next integral routing id is set
        msg.init ();
        ok = pipe_->read (&msg);
        if (!ok)
            return false;

        if (msg.size () == 0) {
            //  Fall back on the auto-generation
            unsigned char buf[5];
            buf[0] = 0;
            put_uint32 (buf + 1, _next_integral_routing_id++);
            routing_id.set (buf, sizeof buf);
            msg.close ();
        } else {
            routing_id.set (static_cast<unsigned char *> (msg.data ()),
                            msg.size ());
            outpipes_t::iterator it = _out_pipes.find (routing_id);
            msg.close ();

            if (it != _out_pipes.end ()) {
                if (!_handover)
                    //  Ignore peers with duplicate ID
                    return false;

                //  We will allow the new connection to take over this
                //  routing id. Temporarily assign a new routing id to the
                //  existing pipe so we can terminate it asynchronously.
                unsigned char buf[5];
                buf[0] = 0;
                put_uint32 (buf + 1, _next_integral_routing_id++);
                blob_t new_routing_id (buf, sizeof buf);

                it->second.pipe->set_router_socket_routing_id (new_routing_id);
                out_pipe_t existing_outpipe = {it->second.pipe,
                                               it->second.active};

                ok = _out_pipes
                       .ZMQ_MAP_INSERT_OR_EMPLACE (ZMQ_MOVE (new_routing_id),
                                                   existing_outpipe)
                       .second;
                zmq_assert (ok);

                //  Remove the existing routing id entry to allow the new
                //  connection to take the routing id.
                _out_pipes.erase (it);

                if (existing_outpipe.pipe == _current_in)
                    _terminate_current_in = true;
                else
                    existing_outpipe.pipe->terminate (true);
            }
        }
    }

    pipe_->set_router_socket_routing_id (routing_id);
    //  Add the record into output pipes lookup table
    out_pipe_t outpipe = {pipe_, true};
    ok = _out_pipes.ZMQ_MAP_INSERT_OR_EMPLACE (ZMQ_MOVE (routing_id), outpipe)
           .second;
    zmq_assert (ok);

    return true;
}
