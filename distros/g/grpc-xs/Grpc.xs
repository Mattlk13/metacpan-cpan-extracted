#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include "util.h"
#include "ext/call.h"
#include "ext/call_credentials.h"
#include "ext/channel.h"
#include "ext/channel_credentials.h"
#include "ext/constants.h"
#include "ext/server.h"
#include "ext/server_credentials.h"
#include "ext/timeval.h"

MODULE = Grpc::XS    PACKAGE = Grpc::XS

BOOT:
  grpc_perl_init();

void
init()
  CODE:
    grpc_perl_init();

void
destroy()
  CODE:
    grpc_perl_destroy();

MODULE = Grpc::XS    PACKAGE = Grpc::XS::Call
INCLUDE: ext/call.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::CallCredentials
INCLUDE: ext/call_credentials.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::Channel
INCLUDE: ext/channel.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::ChannelCredentials
INCLUDE: ext/channel_credentials.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::Constants
INCLUDE: ext/constants.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::Server
INCLUDE: ext/server.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::ServerCredentials
INCLUDE: ext/server_credentials.xs

MODULE = Grpc::XS    PACKAGE = Grpc::XS::Timeval
INCLUDE: ext/timeval.xs
