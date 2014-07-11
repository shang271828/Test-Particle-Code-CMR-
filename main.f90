program Lexponent
use parameters
use problemsize
use output
use time_parameter
implicit none                               
integer g,i,j,k,intt
real*8 ::rscal
real*8 ::y(nn),ynext(nn),znorm(n)
real*8,external::RandNum 
lexp=0.0d0
num=0
vz=0.0d0
do i=1,7
  zone(i)=0.5d0+real(i)*0.1d0
end do
!============
open (unit=10,file='LLexponent1.txt')
open (unit=20,file='vz.txt')
open (unit=30,file='vgrid.txt')
open (unit=40,file='numvx.txt')
open (unit=50,file='numvy.txt')
open (unit=60,file='numvz.txt')
open (unit=70,file='number.txt')
open (unit=80,file='time.txt')
open (unit=90,file='tescape.txt')
open (unit=110,file='particle1.txt')
open (unit=120,file='particle2.txt')
open (unit=130,file='particle3.txt')
open (unit=140,file='particle4.txt')
open (unit=150,file='particle5.txt')
!==================================================
call random_seed()
do i=1,m

    write(*,*)i
  
  y=0.0d0
  !--------------------init-------------
  do k=1,3   
    y(k)=RandNum(-1.0d0,1.0d0)   
  end do
  do k=4,6
    y(k)=RandNum(-0.5d0,0.5d0)
  end do
  do k=1,n
    y((n+1)*k)=1.0d0
  end do
  h=0.01d0
  time=0.0d0  
  tescape=0.0d0
  tstep=0.0d0  
  ynext=0.0d0
 !*********************************************************************************8
  do j=1,tend   
     if (i==1) then
       write(110,"(8(1X,F14.8))") y(1),y(2),y(3),y(4),y(5),y(6),tstep,real(j)
     end if
     if (i==100) then
       write(120,"(8(1X,F14.8))") y(1),y(2),y(3),y(4),y(5),y(6),tstep,real(j)
     end if
     if (i==1000) then
       write(130,"(8(1X,F14.8))") y(1),y(2),y(3),y(4),y(5),y(6),tstep,real(j)
     end if
     if (i==10000) then
       write(140,"(8(1X,F14.8))") y(1),y(2),y(3),y(4),y(5),y(6),tstep,real(j)
     end if
     if (i==100000) then
       write(150,"(8(1X,F14.8))") y(1),y(2),y(3),y(4),y(5),y(6),tstep,real(j)
     end if
    !----------------------------call rk------------------------------------
     hold =h
     call rkasc(100,y(1),y(2),y(3),y(4),y(5),y(6),h,ynext(1),ynext(2),ynext(3),ynext(4),ynext(5)&
     &,ynext(6),0.0d0,0.0d0,0.0d0,0.0d0,0.0d0)
     
     do k=0,n-1
        hold1=hold
        call rkasc(k,y(7+k),y(13+k),y(19+k),y(25+k),y(31+k),y(37+k),hold1,ynext(7+k),ynext(13+k)&
        &,ynext(19+k),ynext(25+k),ynext(31+k),ynext(37+k),y(1),y(2),y(4),y(5),y(6))
     end do
!----------------------------------------------------------------------------------
     if (ynext(1)>=5000.0d0 .or. ynext(2)>=5000.0d0 )cycle
     call LyaExp(ynext,znorm)                     
!----------------------------time step---------------------------------------
     tstep=tstep+hold
     time=time+hold
     dt=th-time     
     if(hold<1.0d-15) then
        write(*,*) 'error'
        goto 100
     end if
     if(dt<1.0d-15) then
        write(*,*) 'error'
        goto 100
     end if
     if(dt<h) then
       h=dt
       time=-dt
      end if      
   !----------------------------------------------------------------------------------------------------
    if(y(1) .gt. 0.0d0)then
         rscal=sqrt(abs(y(1)-length)**2.0d0+abs(y(2))**2.0d0)
         else
         rscal=sqrt(abs(y(1)+length)**2.0d0+abs(y(2))**2.0d0) 
    end if  
    if(abs(time-hold)<1.0d-15) then    
      intt=int(tstep/th+1.0d-2)     
      if(intt>tgrid) cycle     
      do k=1,7
        if(rscal<=zone(k))then      
          lexp(k,intt)=lexp(k,intt)+log(znorm(1))/hold     
          num(k,intt)=num(k,intt)+1          
          vz(k,intt)=vz(k,intt)+y(6)         
        end if
      end do 
    end if    
    do k=1,nn
      y(k)=ynext(k)
    end do
  end do
end do
!---------------------------------------------------------
do i=1,tgrid-1
  do j=1,7
    if(num(j,i)/=0)then
      lexp(j,i)=lexp(j,i)/num(j,i)
      vz(j,i)=vz(j,i)/num(j,i)
    end if
  end do
  write(10,"(7(1X,F14.8))") (lexp(j,i),j=1,7)
  write(70,"(7(1X,I8.5))")(num(j,i),j=1,7)
  write(20,"(7(1X,F14.8))")(vz(j,i),j=1,7)  
 end do 
100 stop
end
