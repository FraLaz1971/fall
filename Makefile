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
form001.f entry.f expand.f tempfc.f bin.f logical.f circle_area001.f timer001.f
OBJS = $(SRCS:.f=$(OEXT))
TARGETS = $(OBJS:$(OEXT)=$(EEXT)) entry002 tracker external readblkdata$(EEXT) dumpblkdata$(EEXT) exf95001$(EEXT) welcome$(EEXT) \
complex001$(EEXT) use_cube_root$(EEXT) demo_roots$(EEXT) calc_cmplx$(EEXT) quad_roots$(EEXT) quad_roots_case$(EEXT) \
exams_data$(EEXT) exams001$(EEXT) points$(EEXT) fibonacci$(EEXT) sin$(EEXT) temp$(EEXT) vectors$(EEXT) vectors2$(EEXT) \
books$(EEXT) books2$(EEXT) reals$(EEXT) reals_portable$(EEXT) fun_roots$(EEXT) endlessdo$(EEXT) cycle$(EEXT) \
select$(EEXT) quadratic002$(EEXT) fibonacci002$(EEXT) reverse$(EEXT) odds$(EEXT) angles001$(EEXT)

.PHONY: all clean

all: $(OBJS) $(TARGETS)

.f.o:
	$(FC) -c $(FFLAGS) -o $@ $<

.o:
	$(FD) -o $@ $^ $(LIBS) $(FDFLAGS)

entry002: entry002.f95
	$(F95) $< -o $@

select: select.f95
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

exams_data$(EEXT): exams_data.f95 random.o
	$(F95) $^ -o $@

exams001$(EEXT): exams001.f95
	$(F95) $< -o $@

points$(EEXT): points.f95
	$(F95) $< -o $@

fibonacci$(EEXT): fibonacci.f95
	$(F95) $< -o $@ 

fibonacci002$(EEXT): fibonacci002.f95 
	$(F95) $< -o $@ $(FDFLAGS) $(LIBS)

sin$(EEXT): sin.f95
	$(F95) $< -o $@

angles001$(EEXT): angles001.f95
	$(F95) $< -o $@

temp$(EEXT): temp.f95
	$(F95) $< -o $@

vectors$(EEXT): vectors.f95
	$(F95) $< -o $@

vectors2$(EEXT): vectors2.f95
	$(F95) $< -o $@

books$(EEXT): books.f95
	$(F95) $< -o $@

books2$(EEXT): books2.f95
	$(F95) $< -o $@

reals$(EEXT): reals.f95
	$(F95) $< -o $@

cycle$(EEXT): cycle.f95
	$(F95) $< -o $@

reverse$(EEXT): reverse.f95 random.o
	$(F95) $^ -o $@

odds$(EEXT): odds.f95 random.o
	$(F95) $^ -o $@

quadratic002$(EEXT): quadratic002.f95
	$(F95) $< -o $@ $(FDFLAGS) $(LIBS)

fun_roots$(EEXT): fun_roots.f95
	$(F95) $< -o $@ $(FDFLAGS) $(LIBS)

reals_portable$(EEXT): reals_portable.f95
	$(F95) $< -o $@

endlessdo$(EEXT): endlessdo.f95
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
complex001$(EEXT) use_cube_root$(EEXT) demo_roots$(EEXT) calc_cmplx$(EEXT) quad_roots$(EEXT) quad_roots_case.$(EEXT) \
exams_data$(EEXT) exams001$(EEXT) points$(EEXT) fibonacci$(EEXT) sin$(EEXT) temp$(EEXT) vectors$(EEXT) vectors2$(EEXT) \
books$(EEXT) books2$(EEXT) reals$(EEXT) reals_portable$(EEXT) fun_roots$(EEXT) endlessdo$(EEXT) cycle$(EEXT) \
select$(EEXT) quadratic002$(EEXT) fibonacci$(EEXT) reverse$(EEXT) odds$(EEXT) angles001$(EEXT) fort.*

