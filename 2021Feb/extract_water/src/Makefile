FC	= ifort
FFLAGS = -O3 -warn all -assume byterecl -heap-arrays -nogen-interfaces

TARGETS=\
add_lake\
check_relation\
check_type\
marge_tmpfile\
set_bounds\
set_name\
set_window\
wrte_ctl_5deg\

all: $(TARGETS)

clean:
	$(RM) -rf *.o *.s core *~ *trace *.mod *.dSYM  $(TARGETS)

.SUFFIXES : .f90
.f90:
	$(FC) ${FFLAGS} $^ -o $@ 
