      program check_area
! ===============================================
      implicit none
      character*128      ::  rfile, wfile

      integer            ::  ix, iy, nx, ny
      parameter             (nx=6000)
      parameter             (ny=6000)

      integer*1,allocatable :: inp(:,:), out(:,:)
! ===============================================
      call getarg(1,rfile)
      call getarg(2,wfile)

      allocate(inp(nx,ny),out(nx,ny))

      open(11,file=rfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(11,rec=1) inp
      close(11)

      open(12,file=wfile,form='unformatted',access='direct',recl=1*nx*ny)
      read(12,rec=1) out

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