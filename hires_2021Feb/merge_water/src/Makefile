FC	= ifort
FFLAGS = -O3 -warn all -assume byterecl -heap-arrays -nogen-interfaces

TARGETS=\
merge_mask\
set_name\
upscale_1sec\
wrte_ctl_10m\
wrte_ctl_30m\


all: $(TARGETS)

clean:
	$(RM) -rf *.o *.s core *~ *trace *.mod *.dSYM  $(TARGETS)

.SUFFIXES : .f90
.f90:
	$(FC) ${FFLAGS} $^ -o $@ 


