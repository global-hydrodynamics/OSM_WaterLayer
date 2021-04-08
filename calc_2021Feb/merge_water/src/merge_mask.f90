      program check_area
! ===============================================
      implicit none
      character*128      ::  rfile, wfile

      integer            ::  ix, iy, nx, ny
      parameter             (nx=6000)
      parameter             (ny=6000)

      integer*1,allocatable :: water(:,:), canal(:,:), river(:,:), stream(:,:)

      character*7        :: cname
! ===============================================
      call getarg(1,cname)

      allocate(water(nx,ny),canal(nx,ny),river(nx,ny),stream(nx,ny))

      rfile='../extract_water/5deg/'//trim(cname)//'.bil'
      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) water
      close(11)

      rfile='../add_stream/5deg/'//trim(cname)//'.bil'
      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) stream
      close(11)

      rfile='../add_canal/5deg/'//trim(cname)//'.bil'
      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) canal
      close(11)

      rfile='../add_river/5deg/'//trim(cname)//'.bil'
      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) river
      close(11)


      do iy=1, ny
        do ix=1, nx
          if( water(ix,iy)==1 )then
            water(ix,iy)=1            !! ocean
          elseif( water(ix,iy)==2 )then
            water(ix,iy)=3            !! line
          elseif( water(ix,iy)==3 )then
            water(ix,iy)=2            !! polygon
          endif
        end do
      end do

      do iy=1, ny
        do ix=1, nx
          if( stream(ix,iy)>=2 )then
            water(ix,iy)=5            !! stream
          endif
        end do
      end do

      do iy=1, ny
        do ix=1, nx
          if( canal(ix,iy)>=2 )then
            water(ix,iy)=4            !! canal
          endif
        end do
      end do

      do iy=1, ny
        do ix=1, nx
          if( river(ix,iy)==3 )then
            water(ix,iy)=2            !! line to polygon
          elseif( river(ix,iy)==2 )then
            water(ix,iy)=3
          endif
        end do
      end do


      wfile='./5deg/'//trim(cname)//'.bil'
      open(11,file=wfile,form='unformatted',access='direct',recl=1*nx*ny)
      write(11,rec=1) water
      close(11)

      end program check_area
