FC	= ifort
FFLAGS = -O3 -warn all -assume byterecl -heap-arrays -nogen-interfaces

TARGETS=\
set_name\
set_window\
set_window_1sec\
wrte_ctl_5deg\

all: $(TARGETS)

clean:
	$(RM) -rf *.o *.s core *~ *trace *.mod *.dSYM  $(TARGETS)

.SUFFIXES : .f90
.f90:
	$(FC) ${FFLAGS} $^ -o $@ 
