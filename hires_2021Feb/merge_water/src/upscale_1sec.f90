      program conv_5deg
! ===============================================
      implicit none
!
      character*128          ::  buf
      real                   ::  west,  south
!
      character*7            ::  cname
      character*128          ::  finp
      character*128          ::  fout
      integer                ::  ios
! 
      integer                ::  ix, iy, dx, dy
      integer                ::  nx, ny
      parameter                 (nx=10800)
      parameter                 (ny=10800)

      integer                ::  iXX, iYY
      integer                ::  nXX, nYY
      parameter                 (nXX=3600)
      parameter                 (nYY=3600)
! input
      integer*1,allocatable  ::  inp(:,:), cst(:,:)
! input
      integer*1,allocatable  ::  out(:,:)

      integer :: isPoly
! =============================================================
      call getarg(1,buf)
      read(buf,*) west
      call getarg(2,buf)
      read(buf,*) south
      call set_name(west,south,cname)

! ====================================
print *, 'READ FILES'

      allocate(inp(nx,ny))
      allocate(out(nXX,nYY),cst(nXX,nYY))

! ==================================================
      finp='./1deg_10m/'//trim(cname)//'.bil'
      open(11,file=finp,form='unformatted',access='direct',recl=1*nx*ny,status='old',iostat=ios)
      if( ios/=0 ) stop
      read(11,rec=1) inp
      close(11)

!! input  :    2=polygon, 3=river, 4=canal, 5=stream
!! output :  >10:polygon, 5=river, 2=canal, 1=stream

      out(:,:)=0
      do iYY=1, nYY
        do iXX=1, nXX
          out(iXX,iYY)=0
          isPoly=0
          do dy=1, 3
            do dx=1, 3
              ix=dx+3*(iXX-1)
              iy=dy+3*(iYY-1)
              if( inp(ix,iy)==2 ) isPoly=1
            end do
          end do

          if( isPoly==1 )then
            do dy=1, 3
              do dx=1, 3
                ix=dx+3*(iXX-1)
                iy=dy+3*(iYY-1)
                if( inp(ix,iy)>0 ) out(iXX,iYY)=out(iXX,iYY)+11 
              end do
            end do
          else
            do dy=1, 3
              do dx=1, 3
                ix=dx+3*(iXX-1)
                iy=dy+3*(iYY-1)
                if( inp(ix,iy)==3 .and. out(iXX,iYY)<5 ) out(iXX,iYY)=5
                if( inp(ix,iy)==4 .and. out(iXX,iYY)<2 ) out(iXX,iYY)=2
                if( inp(ix,iy)==5 .and. out(iXX,iYY)<1 ) out(iXX,iYY)=1
              end do
            end do
          endif

          if( out(iXX,iYY)==99 ) out(iXX,iYY)=100

        end do
      end do

      fout='./1deg_30m/'//trim(cname)//'.bil'
      print *, fout
      open(11,file=fout,form='unformatted',access='direct',recl=1*nXX*nYY)
      write(11,rec=1) out
      close(11)



      end program conv_5deg




      subroutine set_name(lon,lat,cname)
! ===============================================
      implicit none
!
      real            ::  lon, lat

      character*1     ::  ew, sn
      character*2     ::  clat
      character*3     ::  clon
      character*7     ::  cname
! ===============================================
      if( lon<0 )then
        ew='w'
        write(clon,'(i3.3)') int(-lon)
      else
        ew='e'
        write(clon,'(i3.3)')  int(lon)
      endif

      if( lat<0 )then
        sn='s'
        write(clat,'(i2.2)') int(-lat)
      else
        sn='n'
        write(clat,'(i2.2)')  int(lat)
      endif

      cname=sn//clat//ew//clon

      end subroutine set_name




      subroutine nextxy(ix,iy,jx,jy,dir)
! =============================================
      implicit none
!
      integer   :: ix,iy,jx,jy
      integer*1 :: dir
! ============================================
      jx=ix
      jy=iy

      if( dir==2 .or. dir==3 .or. dir==4 )then
        jx=ix+1
      elseif( dir==6 .or. dir==7 .or. dir==8 )then
        jx=ix-1
      endif

      if( dir==1 .or. dir==2 .or. dir==8 )then
        jy=iy-1
      elseif( dir==4 .or. dir==5 .or. dir==6 )then
        jy=iy+1
      endif

      end subroutine nextxy




