# SReview components

This page tries to explain the components that exist in SReview, and how
they work together.

## Database

At the heart of an SReview installation is the database, which contains
information on all the talks that exist, what their state is in the
review queue, as well as on all the raw recordings, what time they were
started, and how long they are (in terms of time, not in terms of
bytes).

There can be only one SReview database per instance.

## Scheduler

Theoretically speaking, SReview does not require a distributed resource
manager (DRM), but using it without one has not been tested at all. It
may magically work, but it is quite likely that it does not work.

To use SReview, the use of a DRM is therefore strongly recommended. For
FOSDEM 2017 as well as DebConf17, gridengine was used, but strictly
speaking it doesn't really matter which one you use.

Future versions of SReview may require the use of a
[DRMAA](http://www.drmaa.org)-compatible DRM, but currently that's not
yet the case.

It is recommended that the scheduler is configured so that short,
high-priority, jobs can be scheduled as well as longer-running,
low-priority jobs. When using gridengine, this can be done by creating
two queues, where the high-priority queue has a `subordinate_queues`
configuration set.

## Web interface

If human review is required, a web interface needs to be running. This is
implemented in Mojolicious. Since it stores all state in the database
and in (encrypted) cookies, it should be possible to run multiple
instances of the web interface, although this has not been tested.

## Job dispatcher

The `sreview-dispatch` script watches the database for new work, and submits
jobs in the scheduler that will handle them. It needs to run for as long as
work is being performed.

Currently it polls the database every 10 seconds, but long-term plans
are for it to use [Mojo::Pg](https://metacpan.org/pod/Mojo::Pg) and
PostgreSQL [asynchronous
notification](https://www.postgresql.org/docs/9.6/static/sql-listen.html).

## File detection

The `sreview-detect` script needs to be run from cron every so often. It
will run `ffprobe` on all files it finds (new as well as old files), and
call a sub from the configuration file with the full filename to figure
out what the start time of the file is, and in which room it was
recorded. It then stores that information, along with the filename, in
the database.

If the file already exists in the database, it will then instead update
the length (and *only* the lenght), as specified in time rather than
bytes, of the file in the database.

An obvious optimization which has not yet been implemented is to not
probe the length of a particular file if a newer file for the same room
already exists in the database.

After files are added to the database, the script will run a few SQL
`UPDATE` statements so the review process will be started for talks for
which all recordings are available.

Future plans are for `sreview-detect` to be rewritten so it (optionally)
uses the Linux `inotify` API to detect when file contents is modified.

## Per-state scripts

There are a number of per-state scripts that are called (through the
scheduler) when a talk reaches a particular state in the database. Each
of them only receives the talk ID as a command line parameter, and is
expected to search for the information that it needs in the databse.

The following scripts exist:

### sreview-skip

This script simply sets the progress to "done". It should be used when a
state is not useful for a particular instance of SReview.

It does not assume anything about the particular state that the talk is
in, and can therefore be used for pretty much any state.

### sreview-cut

This script takes the raw recordings, extracts the useful data of the
talk itself as scheduled and/or corrected by reviewers into a "main"
file, and also extracts the 20 minutes immediately before the talk into
a "pre" file as well as the 20 minutes immediately after into a "post"
file. It does so by copying data, *without* transcoding anything (i.e.,
by way of specifying the `-c copy` parameter to ffmpeg).

However, this script also performs a BS.1770-compliant audio
normalisation.

There are two older versions of this script: the one used at FOSDEM
2017, and the one used at DebConf17. The `sreview-cut` script is
generic, however, and should not need to be modified for different
conferences.

This script is designed for talks in the `cutting` state.

### notify

This script should perform whatever is required to send out a
notification to reviewers that a particular talk is now ready for
review. This may include instructing an IRC bot to say something, or
sending out an email to the speakers and/or designated reviewers.

This script is designed for talks in the `notification` state.

There is no genericized version of this script.

### sreview-previews

This script should do whatever is required to convert the output of the
`cut_talk` script to something HTML5-compatible so that it can be viewed
by reviewers.

If the output of the recording system is already HTML5-compatible (that
is, if it uses H.264 or one of the WebM codecs), then this script should
not do anything, and instead the `skip` script (see above) should be
used. Alternatively, this script may copy files from one machine to the
other so that they are available over HTTP.

While there is a fosdem version of the `previews` script, that is simply
an older version of the skip script, since FOSDEM recorded in H.264
which is already HTML5-compatible. The debconf version of this script
would transcode to low-quality VP8, however, since DebConf records in
MPEG2, which is not HTML5-compatible.

The genericized version of this script verifies whether the output of
sreview-cut is HTML5-compatible, and will transcode to low-quality VP8
if not, or just copy from one container file to the other if it is.

This script is designed to be run in the `generating_previews` state;
*not* in the `preview` state (the latter is meant as the state where the
web-based review is done).

### sreview-transcode

This script takes the output of the `sreview-cut` script, prepends opening
credits (based on an SVG template after a simple sed-like replacement of
a few key words), appends closing credits (based on either a similar SVG
template or a static PNG file), and then transcodes the whole resulting
file into high-quality output files that will be released to the general
public. Optionally, it will also add an "apology" slide just after the
opening credits; this is designed for cases where minor but
uncorrectable technical issues exist with the recordings (e.g., a
microphone buzz, or the loss of some but not all of the recorded data),
and allows to show a "We are sorry for the inconvenience" type of slide,
so that viewers know what's going on.

This script may take a long time to complete (usually several seconds
per second of recorded time), and usually does a two-pass transcode.

It is designed to be run in the `transcoding` state.

Similar to the `sreview-cut` script, there are two older versions of the
`sreview-transcode` script, too.

### upload

This script should take the output of the `sreview-transcode` script,
and publishes it by whatever method is required. It then also removes
all intermediate files that were created by the `sreview-cut` and/or
`sreview-transcode` scripts; if a change is required after a talk has
already been published, then the talk needs to be put back through the
`sreview-cut` script.

Two versions exist here too, but they are very similar.

No genericized version of this script exists, yet.

# Examples

At FOSDEM 2017, SReview was installed on the following machines:

- review.video.fosdem.org: web interface, postgresql, gridengine master,
  gridengine exec, dispatch script
- encoder0.video.fosdem.org, encoder1.video.fosdem.org, ...: gridengine
  exec, encoder nodes
- backend0.video.fosdem.org, backend1.video.fosdem.org, ...:
  `detect_files`, storage for raw recordings (access over HTTP only)
- storage0.video.fosdem.org, storage1.video.fosdem.org, ...: NFS,
  storage for `cut_talk`, `previews`, and `transcode` output.

All machines were "bare metal" machines at a cloud hoster. Data access
to the database and the raw files was LAN-based and therefore quick.

At DebConf17, SReview was installed on the following machines:

- vittoria.debian.org: web interface, postgresql, gridengine master,
  gridengine exec, dispatch script with configuration for upload and
  notification *only* (upload script would pull from noc1st0 first and
  then publish).
- noc1st0.debconf17.debconf.org: raw recordings, all intermediate files,
  nginx (for serving preview files to reviewers), gridengine master,
  `detect_files`, NFS server for raw and intermediate files, gridengine
  exec (for `cut_talks` scripts *only*).
- encoder0.debconf17.debconf.org, encoder1.debconf17.debconf.org, ...:
  gridengine exec, encoder nodes.

vittoria is a VM that runs on Debian infrastructure at GRNET (Greece).
It is available to the DebConf video team all year.

The other machines were local hardware, borrowed for the duration of
DebConf17. They were configured to be granted access to *only* the
postgresql on vittoria.

During the conference, while the talks were in the `waiting_for_files`
through `transcoding` states, no files were copied to vittoria. Only
when the transcodes had finished were they copied (by the `uploads`
script that ran on vittoria) to vittoria, and then pushed from vittoria
to the DebConf [video archive](https://video.debian.net).

It is possible to run all components of SReview on a single host; for
small conferences, doing so is recommended.
