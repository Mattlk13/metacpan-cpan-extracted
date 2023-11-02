#ifndef GRPC_PERL_CALL_H
#define GRPC_PERL_CALL_H

#include <grpc/grpc.h>
#include <grpc/support/alloc.h>

typedef struct {
  grpc_call *wrapped;
} CallCTX;

typedef CallCTX* Grpc__XS__Call;

#endif
