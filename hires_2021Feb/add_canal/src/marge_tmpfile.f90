      program check_area
! ===============================================
      implicit none
      character*128      ::  rfile, wfile
      integer            ::  ios

      integer            ::  ix, iy, nx, ny
      parameter             (nx=10800)
      parameter             (ny=10800)

      integer*1,allocatable :: inp(:,:), out(:,:)
! ===============================================
      call getarg(1,rfile)
      call getarg(2,wfile)

      allocate(inp(nx,ny),out(nx,ny))

      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny,status='old',iostat=ios)
      if( ios/=0 ) stop
      read(11,rec=1) inp
      close(11)

      open(12,file=wfile,form='unformatted',access='direct',recl=1*nx*ny,status='old',iostat=ios)
      if( ios==0 )then
        read(12,rec=1) out
      else
        open(12,file=wfile,form='unformatted',access='direct',recl=1*nx*ny,status='new')
        out(:,:)=0
      endif

      do iy=1, ny
        do ix=1, nx
          if( out(ix,iy)/=1 )then
            out(ix,iy)=max(out(ix,iy),inp(ix,iy))
          endif
        end do
      end do

      write(12,rec=1) out
      close(12)

      end program check_area