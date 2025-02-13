#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

typedef struct timespec* Time__Spec;

#define timespec_new(class, value) &(value)
#define timespec_new_from_pair(class, secs, nsecs)
#define timespec_sec(self) (self)->tv_sec
#define timespec_nsec(self) (self)->tv_nsec
#define timespec_to_float(self) (self)->tv_sec + ((self)->tv_nsec / (double)1000000000)

MODULE = Time::Spec		PACKAGE = Time::Spec	PREFIX = timespec_

PROTOTYPES: DISABLED

Time::Spec timespec_new(class, struct timespec value)

Time::Spec timespec_new_from_pair(class, UV secs, UV nsecs)
CODE:
	struct timespec retval = (struct timespec){ .tv_sec = secs, .tv_nsec = nsecs };
	RETVAL = &retval;
OUTPUT:
	RETVAL

UV timespec_sec(Time::Spec self)

UV timespec_nsec(Time::Spec self)

NV timespec_to_float(Time::Spec self)

void timespec_to_pair(Time::Spec self)
PPCODE:
	mXPUSHi(self->tv_sec);
	mXPUSHi(self->tv_nsec);
