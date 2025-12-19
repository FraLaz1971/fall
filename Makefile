FC=f77 -g
FD=f77
OEXT=.o
EEXT=
RM=rm -rf
ROOT=
FFLAGS=
ROOT=
#FDFLAGS= -L$(ROOT)/usr/lib -L$(PGPLOT_DIR) -Wl,-rpath=$(PGPLOT_DIR)
#LIBS=-lpgplot -lpng -lz
FDFLAGS=
LIBS=
SRCS=common.f limits.f iostat.f endfile.f endf2unf.f readunf1.f append.f files.f sort.f in2files.f
OBJS = $(SRCS:.f=$(OEXT))
TARGETS = $(OBJS:$(OEXT)=$(EEXT))
.PHONY: all clean

all: $(OBJS) $(TARGETS)

.f.o:
	$(FC) -c $(FFLAGS) -o $@ $<

.o:
	$(FD) -o $@ $^ $(LIBS) $(FDFLAGS)

clean:
	$(RM) $(OBJS) $(TARGETS) fort.*

