      program check_area
! ===============================================
      implicit none
      character*128      ::  buf
      real               ::  w0, e0, s0, n0

      character*6        ::  w1, e1, s1, n1

      real               ::  hres
      parameter             (hres=1./1200.*0.5)
! ===============================================
      call getarg(1,buf)
      read(buf,*) w0
      call getarg(2,buf)
      read(buf,*) e0
      call getarg(3,buf)
      read(buf,*) s0
      call getarg(4,buf)
      read(buf,*) n0

      w0=w0-0.1
      e0=e0+0.1
      s0=s0-0.1
      n0=n0+0.1

      write(w1,'(f6.1)') w0
      write(e1,'(f6.1)') e0
      write(s1,'(f6.1)') s0
      write(n1,'(f6.1)') n0

      w1=adjustl(w1)
      e1=adjustl(e1)
      s1=adjustl(s1)
      n1=adjustl(n1)

      buf='left='//trim(w1)//' right='//trim(e1)//' top='//trim(n1)//' bottom='//trim(s1)
      print *, trim(buf)

!BOUND="left=${WEST} right=${EAST} top=${INORTH} bottom=${ISOUTH}"


      end program check_area