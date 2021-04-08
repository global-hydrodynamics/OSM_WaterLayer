      program wrte_ctl
! ===============================================
      implicit none
! vars
      integer            ::  nx,  ny
      parameter             (nx=6000)
      parameter             (ny=6000)
      real*8             ::  lon, lat
      real*8             ::  size
      character*128      ::  buf
! file
      character*128      ::  hdrfile
      character*15       ::  nodata
      real*8             ::  ULXMAP, ULYMAP
! ===============================================
      call getarg(1,buf)
       read(buf,*) lon
      call getarg(2,buf)
       read(buf,*) lat
      call getarg(3,hdrfile)

      size=dble(1.0)/dble(1200.)

      ULXMAP=lon
      ULYMAP=lat+5.-size

      open(21,file=hdrfile,form='formatted')
        write(21,'(a)'         ) 'BYTEORDER       I   '
        write(21,'(a)'         ) 'LAYOUT          BIL '
        write(21,'(a)'         ) 'NROWS           6000'
        write(21,'(a)'         ) 'NCOLS           6000'
        write(21,'(a)'         ) 'NBANDS          1   '
        write(21,'(a)'         ) 'NBITS           8   '
        write(21,'(a)'         ) 'BANDROWBYTES    6000'
        write(21,'(a)'         ) 'TOTALROWBYTES   6000'
        write(21,'(a)'         ) 'BANDGAPBYTES    0   '
        write(21,'(a)'         ) 'NODATA          -9  '
        write(21,'(a,f25.20)'  ) 'ULXMAP        ', ULXMAP
        write(21,'(a,f25.20)'  ) 'ULYMAP        ', ULYMAP
        write(21,'(a,f25.20)'  ) 'XDIM          ', size
        write(21,'(a,f25.20)'  ) 'YDIM          ', size
      close(21)

      end program wrte_ctl
