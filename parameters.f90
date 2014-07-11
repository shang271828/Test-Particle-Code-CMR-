
!------------------------1----------------------------------------------------------------------------
module parameters
  implicit none
  real*8,parameter ::b=1.0d0                  !the ratio of the gradient of the magnetic field
  real*8,parameter ::length=0.0d0             !length between two nulls 
  real*8,parameter ::ma=3.0d-3                !Magnetic Reynolds Number
  real*8,parameter ::bz=1.0d0                 !guide field
  real*8,parameter ::q=1.0d0                  !charge
end module
!-------------------------2---------------------------------------------------------------------------
module problemsize
 implicit none
 integer,parameter:: n=6                      !dimension
 integer,parameter:: nn=42                    !n*(n+1)
 integer,parameter:: m=10000                !particle number
 integer,parameter:: tgrid=3001                !time grid
 integer,parameter:: mgrid=102                !v distri
 integer,parameter:: tend=4000            !time step
end module
!--------------------------3--------------------------------------------------------------------------
module output
  use problemsize
  implicit none
  !integer num1(tgrid),num2(tgrid),num3(tgrid),num4(tgrid),num5(tgrid),num6(tgrid),num7(tgrid),num10(tgrid)
  !real*8 ::vz1(tgrid),vz2(tgrid),vz3(tgrid),vz4(tgrid),vz5(tgrid),vz6(tgrid),vz7(tgrid),vgrid(mgrid)
  !real*8 ::lexp1(tgrid),lexp2(tgrid),lexp3(tgrid),lexp4(tgrid),lexp5(tgrid),lexp6(tgrid),lexp7(tgrid)
  integer num(7,tgrid)
  real*8 ::vz(7,tgrid),vgrid(mgrid)
  real*8 ::lexp(7,tgrid)
  real*8 :: zone(7)
end module
!--------------------------4--------------------------------------------------------------------------
module time_parameter
  use problemsize
  implicit none
  real*8 ::hold1,dt 
  real*8 ::tesc,tescape
  real*8 :: time                                  !escape time
  real*8 ::hold                                     !static step length
  real*8 :: h                                    !adaptive step length
  real*8 ::tstep                                 !time counter
  real*8 ::th=5.0d-1  
end module
!******************************************************************************************************      
