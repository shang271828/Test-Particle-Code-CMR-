
subroutine rkerr(j,x,y,z,vx,vy,vz,h,xnext,ynext,znext,vxnext,vynext,vznext,xerr,yerr,zerr,vxerr,vyerr,vzerr&
&,x0,y0,vx0,vy0,vz0)
use parameters
implicit none
!Cash-Karp Parameters
real*8,parameter:: a2=0.2d0,a3=0.3d0,a4=0.6d0,a5=1.0d0,a6=0.875d0,b21=0.2d0,b31=3.0d0/40.0d0,b32=9.0d0/40.0d0
real*8,parameter:: b41=3.0d0/10.0d0,b42=-0.9d0,b43=1.2d0,b51=-11.0d0/54.0d0,b52=2.5d0,b53=-70.0d0/27.0d0,b54=35.0d0/27.0d0
real*8,parameter:: b61=1631.0d0/55296.0d0,b62=175.0d0/512.0d0,b63=575.0d0/13824.0d0,b64=44275.0d0/110592.0d0,b65=253.0d0/4096.0d0
real*8,parameter::c1=37.0d0/378.0d0,c3=250.0d0/621.0d0,c4=125.0d0/594.0d0,c6=512.0d0/1771.0d0
real*8,parameter::dc1=c1-2825.0d0/27648.0d0,dc3=c3-18575.0d0/48384.0d0,dc4=c4-13525.0d0/55296.0d0&
&,dc5=-277.0d0/14336.0d0,dc6=c6-0.25d0
real*8 x0,y0,vx0,vy0,vz0
!6-dimension phase space 
real*8 x,y,z,vx,vy,vz,ax,ay,az
real*8 xtemp,ytemp,vxtemp1,vytemp1,vztemp1,vxtemp2,vytemp2,vztemp2,vxtemp3,vytemp3,vztemp3
real*8 vxtemp4,vytemp4,vztemp4,vxtemp5,vytemp5,vztemp5
real*8 xnext,ynext,znext,vxnext,vynext,vznext
real*8 kvx2,kvy2,kvz2,kvx3,kvy3,kvz3,kvx4,kvy4,kvz4,kvx5,kvy5,kvz5,kvx6,kvy6,kvz6
real*8 xerr,yerr,zerr,vxerr,vyerr,vzerr
real*8 h
integer j
  !step 1
  if (j==100)then
  call derivs(x,y,vx,vy,vz,ax,ay,az)   
  else 
    call fcn(x,y,vx,vy,vz,ax,ay,az,x0,y0,vx0,vy0,vz0)
  end if
  !step 2
  xtemp=x+b21*h*vx                  
  ytemp=y+b21*h*vy
  vxtemp1=vx+b21*h*ax
  vytemp1=vy+b21*h*ay
  vztemp1=vz+b21*h*az
  if(j==100)then
  call derivs(xtemp,ytemp,vxtemp1,vytemp1,vztemp1,kvx2,kvy2,kvz2)
  else
    call fcn(xtemp,ytemp,vxtemp1,vytemp1,vztemp1,kvx2,kvy2,kvz2,x0,y0,vx0,vy0,vz0)
  end if
  !step 3
  xtemp=x+h*(b31*vx+b32*vxtemp1)
  ytemp=y+h*(b31*vy+b32*vytemp1)
  vxtemp2=vx+h*(b31*ax+b32*kvx2)
  vytemp2=vy+h*(b31*ay+b32*kvy2)
  vztemp2=vz+h*(b31*az+b32*kvz2)
  if(j==100)then
  call derivs(xtemp,ytemp,vxtemp2,vytemp2,vztemp2,kvx3,kvy3,kvz3)
  else
    call fcn(xtemp,ytemp,vxtemp2,vytemp2,vztemp2,kvx3,kvy3,kvz3,x0,y0,vx0,vy0,vz0)
  end if
  
  !step 4 
  xtemp=x+h*(b41*vx+b42*vxtemp1+b43*vxtemp2)
  ytemp=y+h*(b41*vy+b42*vytemp1+b43*vytemp2)
  vxtemp3=vx+h*(b41*ax+b42*kvx2+b43*kvx3)
  vytemp3=vy+h*(b41*ay+b42*kvy2+b43*kvy3)
  vztemp3=vz+h*(b41*az+b42*kvz2+b43*kvz3)
  if(j==100)then
  call derivs(xtemp,ytemp,vxtemp3,vytemp3,vztemp3,kvx4,kvy4,kvz4)
  else
    call fcn(xtemp,ytemp,vxtemp3,vytemp3,vztemp3,kvx4,kvy4,kvz4,x0,y0,vx0,vy0,vz0)
  end if
  !step 5
  xtemp=x+h*(b51*vx+b52*vxtemp1+b53*vxtemp2+b54*vxtemp3)
  ytemp=y+h*(b51*vy+b52*vytemp1+b53*vytemp2+b54*vytemp3)
  vxtemp4=vx+h*(b51*ax+b52*kvx2+b53*kvx3+b54*kvx4)
  vytemp4=vy+h*(b51*ay+b52*kvy2+b53*kvy3+b54*kvy4)
  vztemp4=vz+h*(b51*az+b52*kvz2+b53*kvz3+b54*kvz4)
  if(j==100)then
  call derivs(xtemp,ytemp,vxtemp4,vytemp4,vztemp4,kvx5,kvy5,kvz5)
  else
    call fcn(xtemp,ytemp,vxtemp4,vytemp4,vztemp4,kvx5,kvy5,kvz5,x0,y0,vx0,vy0,vz0)
  end if
  !step 6
  xtemp=x+h*(b61*vx+b62*vxtemp1+b63*vxtemp2+b64*vxtemp3+b65*vxtemp4)
  ytemp=y+h*(b61*vy+b62*vytemp1+b63*vytemp2+b64*vytemp3+b65*vytemp4)
  vxtemp5=vx+h*(b61*ax+b62*kvx2+b63*kvx3+b64*kvx4+b65*kvx5)
  vytemp5=vy+h*(b61*ay+b62*kvy2+b63*kvy3+b64*kvy4+b65*kvy5)
  vztemp5=vz+h*(b61*az+b62*kvz2+b63*kvz3+b64*kvz4+b65*kvz5)
  if(j==100)then
  call derivs(xtemp,ytemp,vxtemp5,vytemp5,vztemp5,kvx6,kvy6,kvz6)
  else
    call fcn(xtemp,ytemp,vxtemp5,vytemp5,vztemp5,kvx6,kvy6,kvz6,x0,y0,vx0,vy0,vz0)
  end if
  xnext=x+h*(c1*vx+c3*vxtemp2+c4*vxtemp3+c6*vxtemp5)
  ynext=y+h*(c1*vy+c3*vytemp2+c4*vytemp3+c6*vytemp5)
  znext=z+h*(c1*vz+c3*vztemp2+c4*vztemp3+c6*vztemp5)
  vxnext=vx+h*(c1*ax+c3*kvx3+c4*kvx4+c6*kvx6)
  vynext=vy+h*(c1*ay+c3*kvy3+c4*kvy4+c6*kvy6)
  vznext=vz+h*(c1*az+c3*kvz3+c4*kvz4+c6*kvz6)
  !estimate error
  xerr=h*(dc1*vx+dc3*vxtemp2+dc4*vxtemp3+dc5*vxtemp4+dc6*vxtemp5)
  yerr=h*(dc1*vy+dc3*vytemp2+dc4*vytemp3+dc5*vytemp4+dc6*vytemp5)
  zerr=h*(dc1*vz+dc3*vztemp2+dc4*vztemp3+dc5*vztemp4+dc6*vztemp5)
  vxerr=h*(dc1*ax+dc3*kvx3+dc4*kvx4+dc5*kvx5+dc6*kvx6)
  vyerr=h*(dc1*ay+dc3*kvy3+dc4*kvy4+dc5*kvy5+dc6*kvy6)
  vzerr=h*(dc1*az+dc3*kvz3+dc4*kvz4+dc5*kvz5+dc6*kvz6)
return
end
 !================================================================================
subroutine fcn(x,y,vx,vy,vz,ax,ay,az,x0,y0,vx0,vy0,vz0)
!dvx/dt=fx(x,y,z,vx,vy,vz,t)=vz*By(x)
!dvy/dt=fy(x,y,z,vx,vy,vz,t)=-vz*y
!dvz/dt=fz(x,y,z,vx,vy,vz,t)=a-vx*By(x)+vy*y
!dx/dt=vx
!dy/dt=vy
!dz/dt=vz
use parameters
implicit none
real*8 ::x0,y0,vx0,vy0,vz0
real*8 ::x,y,vx,vy,vz,ax,ay,az
if(-length<(x0+x).and.(x+x0)<length)then
    ax=q*(vy*bz)
    ay=q*(vz0*y+y0*vz-vx*bz)
    az=q*(ma-vy0*y-y0*vy)
    else if((x+x0)>=length)then
    ax=q*(vy*bz-vz0*x-(x0-length)*vz)
    ay=q*(vz0*y+y0*vz-vx*bz)
    az=q*(ma+vx0*x+(x0-length)*vx-vy0*y-y0*vy)
    else
    ax=q*(vy*bz-vz0*x-(x0+length)*vz)
    ay=q*(vz0*y+y0*vz-vx*bz)
    az=q*(ma+vx0*x+(x0+length)*vx-vy0*y-y0*vy)
  end if
return
end 
!==================================================
subroutine derivs(x,y,vx,vy,vz,ax,ay,az)
!dvx/dt=fx(x,y,z,vx,vy,vz,t)=vy*Bz-vz*By(x)
!dvy/dt=fy(x,y,z,vx,vy,vz,t)=vz*y-vx*Bz
!dvz/dt=fz(x,y,z,vx,vy,vz,t)=a+vx*By(x)-vy*y
!dx/dt=vx
!dy/dt=vy
!dz/dt=vz
use parameters
implicit none
real*8,external::by
real*8 x,y,vx,vy,vz,ax,ay,az
ax=q*(vy*bz-vz*by(x))
ay=q*(vz*y-vx*bz)
az=q*(ma+vx*by(x)-vy*y)
return 
end
!====================================================
function by(x)
!Magnetic field By
use parameters
implicit none
real*8 x
real*8 by
if (x>length)then
  by=b*(x-length)
else if (x<-length)then
  by=b*(x+length)
else
  by=0.0
end if
return
end
!=====================================
!random number of a~b
function RandNum(a,b)
implicit none
real*8 a,b,RandNum,l,t
l=b-a
call random_number(t)
 RandNum=a+l*t
return
end
!=====================================
subroutine distri(a,num,maxv,minv,mgrid,h)
implicit none
integer mgrid
integer i,k,num(mgrid)
real*8 a,maxv,minv,h

 if (a==minv) then
    k=1
  else if(a>minv .and. a<=maxv) then
    k=ceiling((a-minv)/h)
  else if(a<minv) then
    k=mgrid-1
  else
    k=mgrid
  end if
  num(k)=num(k)+1
return
end
