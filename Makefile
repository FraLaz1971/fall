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
pi.f fun100.f fun101.f fun102.f readfun.f butterfly.f chaos.f euclid.f r2b.f taysin.f \
form001.f entry.f expand.f tempfc.f
OBJS = $(SRCS:.f=$(OEXT))
TARGETS = $(OBJS:$(OEXT)=$(EEXT)) entry002 tracker external readblkdata$(EEXT) dumpblkdata$(EEXT) exf95001$(EEXT) welcome$(EEXT) \
complex001$(EEXT) use_cube_root$(EEXT) demo_roots$(EEXT) calc_cmplx$(EEXT) quad_roots$(EEXT) quad_roots_case$(EEXT)
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

exf95001$(EEXT): exf95001.f95
	$(F95) $< -o $@

complex001$(EEXT): complex001.f95
	$(F95) $< -o $@

demo_roots$(EEXT): demo_roots.f95
	$(F95) $< -o $@

calc_cmplx$(EEXT): calc_cmplx.f95
	$(F95) $< -o $@

quad_roots$(EEXT): quad_roots.f95
	$(F95) $< -o $@

quad_roots_case$(EEXT): quad_roots_case.f95
	$(F95) $< -o $@

use_cube_root$(EEXT): use_cube_root.f95
	$(F95) $< -o $@

welcome$(EEXT): welcome.f95
	$(F95) $< -o $@

blockdatas$(OEXT): blockdatas.f
	$(FC) -c $(FFLAGS) $<

dumpblkdata$(OEXT): dumpblkdata.f
	$(FC) -c $(FFLAGS) $<

dumpblkdata$(EEXT): dumpblkdata$(OEXT) blockdata$(OEXT)
	$(FD) -o $@ $^ $(LIBS) $(FDFLAGS)

readblkdata$(OEXT): readblkdata.f
	$(FC) -c $(FFLAGS) $<

readblkdata$(EEXT): readblkdata$(OEXT) blockdata$(OEXT)
	$(FD) -o $@ $^ $(LIBS) $(FDFLAGS)


clean:
	$(RM) $(OBJS) $(TARGETS) entry002 tracker external readblkdata$(EEXT) dumpblkdata$(EEXT) welcome$(EEXT)  \
complex001$(EEXT) use_cube_root$(EEXT) demo_roots$(EEXT) calc_cmplx$(EEXT) quad_roots$(EEXT) quad_roots_case.$(EEXT) fort.*

