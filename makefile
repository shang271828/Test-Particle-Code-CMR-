# This is an commentary line in a makefile
# Start of the makefile
execname: main.o parameters.o G-S.o AdaptiveStep.o rk4.o
    ifort -o execname main.o parameters.o G-S.o AdaptiveStep.o rk4.o
global.mod: global.o global.f90
    ifort -c global.f90
global.o: global.f90
    ifort -c global.f90
main.o: global.mod main.f90
    ifort -c main.f90
function1.o: global.mod function1.f90
    ifort -c function1.f90
subroutine1.o: subroutine1.f90
    ifort -c subroutine1.f90
clean:
    rm global.mod global.o main.o function1.o subroutine1.o execname
# End of the makefile

main.f90 parameters.f90 G-S.f90 AdaptiveStep.f90 rk4.f90

