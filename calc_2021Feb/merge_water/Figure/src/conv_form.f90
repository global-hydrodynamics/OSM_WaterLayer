      program slope_srtm30
! ===============================================
      implicit none

      integer                ::  ix, iy
      integer                ::  nx, ny
      parameter                 (nx=6000)  !! input
      parameter                 (ny=6000)

      real,allocatable       ::  elevtn(:,:)
      integer*1,allocatable  ::  water(:,:), osm(:,:)
      real,allocatable       ::  var(:,:)

      character*128          ::  rfile1, wfile1
      integer                ::  ios
      real                   ::  west1, south1
      character*7            ::  cname1

      character*128          ::  buf
! ===============================================
      allocate(elevtn(nx,ny),water(nx,ny),osm(nx,ny),var(nx,ny))

      call getarg(1,buf)
      read(buf,*) west1
      call getarg(2,buf)
      read(buf,*) south1
      call set_name(west1,south1,cname1)

      rfile1='./MERIT_DEM/'//trim(cname1)//'.bin'
      open(11,file=rfile1,form='unformatted',access='direct',recl=4*nx*ny,status='old',iostat=ios)
      if( ios/=0 ) stop
      read(11,rec=1) elevtn
      close(11)

      rfile1='./G3WBM/'//trim(cname1)//'_wat.bil'
      open(11,file=rfile1,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) water
      close(11)

      rfile1='../5deg/'//trim(cname1)//'.bil'
      open(11,file=rfile1,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) osm
      close(11)

! ===================================
      var(:,:)=0
      do iy=1, ny
        do ix=1, nx
          if( elevtn(ix,iy)==-9999 )then
            var(ix,iy)=99
          else
            if( water(ix,iy)>=50 )then
              if( osm(ix,iy)==0 ) var(ix,iy)=10
              if( osm(ix,iy)>=1 ) var(ix,iy)=11
            else
              if( osm(ix,iy)==0 ) var(ix,iy)=0
              if( osm(ix,iy)>=1 ) var(ix,iy)=1
            endif
          endif
        end do
      end do



      wfile1='./var_'//trim(cname1)//'.bin'
      open(21,file=wfile1,form='unformatted',access='direct',recl=4*nx*ny)
      write(21,rec=1) var
      close(21)


      end program slope_srtm30





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

