      program check_area
! ===============================================
      implicit none
      character*128      ::  buf
      real               ::  w0, e0, s0, n0

      real               ::  hres
      parameter             (hres=1./18000.*0.0)
! ===============================================
      call getarg(1,buf)
      read(buf,*) w0
      call getarg(2,buf)
      read(buf,*) s0
      e0=w0+1
      n0=s0+1

      print '(4f20.8)', w0-hres, s0-hres, e0-hres, n0-hres

      end program check_area