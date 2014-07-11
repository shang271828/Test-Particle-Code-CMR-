!====================================================================
subroutine rkasc(j,x,y,z,vx,vy,vz,h,xnext,ynext,znext,vxnext,vynext,vznext,x0,y0,vx0,vy0,vz0)
use parameters
implicit none

real*8 eps,h,htemp,S,pgrow,pshrink,errcon,errmax,errdesir
real*8 rscal,tiny,x0,y0,vx0,vy0,vz0
real*8 x,y,z,vx,vy,vz,xnext,ynext,znext,vxnext,vynext,vznext,xerr,yerr,zerr,vxerr,vyerr,vzerr
integer j
eps=1.0d-8
S=0.9d0
pgrow=-.2d0
pshrink=-.25d0
errcon=1.89d-4
tiny=1.0d-15
call rkerr(j,x,y,z,vx,vy,vz,h,xnext,ynext,znext,vxnext,vynext,vznext,xerr,yerr,zerr,vxerr,vyerr,vzerr&
&,x0,y0,vx0,vy0,vz0)
  if(x.gt.0.0d0)then
    rscal=sqrt(abs(x-length)**2.0d0+abs(y)**2.0d0)+tiny
    else
      rscal=sqrt(abs(x+length)**2.0d0+abs(y)**2.0d0)+tiny
  end if
  if(abs(rscal).lt.3.0d0)then
    errdesir=rscal*eps
    else
      errdesir=3.0d-8
  end if
  errmax=max(abs(xerr),abs(yerr),abs(zerr),abs(vxerr),abs(vyerr),abs(vzerr))
  errmax=errmax/errdesir
  if(errmax.gt.1.0d0)then
    htemp=S*h*(errmax**pshrink)
    h=max(abs(htemp),0.1d0*abs(h))
   else if(errmax.gt.errcon)then
     h=S*h*(errmax**pgrow)
   else
     h=5.*h
  end if
return
end
