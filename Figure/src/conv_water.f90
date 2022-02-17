      program slope_srtm30
! ===============================================
      implicit none

      integer                ::  ix, iy, jx, jy, kx, ky, dx, dy, sx, sy
      integer                ::  mx, my
      parameter                 (mx=6000)  !! calc domain
      parameter                 (my=6000)

      integer*1,allocatable  ::  osm(:,:)
      real,allocatable       ::  var(:,:), ori(:,:)

      integer                ::  pek_thrs, pg, ng
      real                   ::  dd, var_this

      real                   ::  upa_thrs
      parameter                 (upa_thrs=1)

      character*128          ::  rfile1, wfile1
      integer                ::  ios
      real                   ::  west1, south1
      character*7            ::  cname1

      character*128          ::  buf
! ===============================================
      allocate(osm(mx,my))
      allocate(var(mx,my),ori(mx,my))

      call getarg(1,buf)
      read(buf,*) west1
      call getarg(2,buf)
      read(buf,*) south1
      call set_name(west1,south1,cname1)

      rfile1='./2021Feb/'//trim(cname1)//'.bil'
      open(11,file=rfile1,form='unformatted',access='direct',recl=1*mx*my,status='old',iostat=ios)
      if( ios/=0 ) stop
      read(11,rec=1) osm
      close(11)

! ===================================
      var(:,:)=0
      do iy=1, my
        do ix=1, mx
          if( osm(ix,iy)==1 ) var(ix,iy)=-99 !! ocean
          if( osm(ix,iy)==2 ) var(ix,iy)=51 !! ocean
          if( osm(ix,iy)==3 ) var(ix,iy)=41 !! ocean
          if( osm(ix,iy)==4 ) var(ix,iy)=31 !! ocean
          if( osm(ix,iy)==5 ) var(ix,iy)=21 !! ocean
        end do
      end do

      ori(:,:)=var(:,:)
      do iy=1, my
        do ix=1, mx
          if( ori(ix,iy)>0 )then
            var_this=ori(ix,iy)
            do dx=-1, 1
              do dy=-1, 1
                jx=ix+dx
                jy=iy+dy
                if( jx>=1 .and. jx<=mx .and. jy>=1 .and. jy<=my )then
                  if( var(jx,jy)>=0 )then
                    var(jx,jy)=max(var(jx,jy),var_this)
                  endif
                endif
              end do
            end do
          endif
        end do
      end do

      wfile1='./wat_'//trim(cname1)//'.bin'
      open(21,file=wfile1,form='unformatted',access='direct',recl=4*mx*my)
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

