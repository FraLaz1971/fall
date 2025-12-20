FC=f77 -g
FD=f77
F95=gfortran
OEXT=.o
EEXT=
RM=rm -rf
ROOT=
FFLAGS=
ROOT=
FDFLAGS=-L$(ROOT)/usr/lib -L$(PGPLOT_DIR) -Wl,-rpath=$(PGPLOT_DIR)
LIBS=-lpgplot -lpng -lz -lX11
SRCS=common.f limits.f iostat.f endfile.f endf2unf.f readunf1.f append.f files.f sort.f in2files.f \
pi.f fun100.f fun101.f fun102.f readfun.f butterfly.f chaos.f euclid.f r2b.f blockdata.f taysin.f \
form001.f entry.f expand.f
OBJS = $(SRCS:.f=$(OEXT))
TARGETS = $(OBJS:$(OEXT)=$(EEXT)) entry002 tracker external
.PHONY: all clean

all: $(OBJS) $(TARGETS)

.f.o:
	$(FC) -c $(FFLAGS) -o $@ $<

.o:
	$(FD) -o $@ $^ $(LIBS) $(FDFLAGS)

entry002: entry002.f95
	$(F95) $< -o $@

external: external.f95
	$(F95) $< -o $@

tracker: tracker.f95
	$(F95) $< -o $@

clean:
	$(RM) $(OBJS) $(TARGETS) entry002 tracker external fort.*

