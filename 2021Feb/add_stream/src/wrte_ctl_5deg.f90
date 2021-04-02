      program wrte_ctl
! ===============================================
      implicit none
! vars
      integer            ::  nx,  ny
      parameter             (nx=6000)
      parameter             (ny=6000)
      real*8             ::  lon, lat
      character*128      ::  buf
! file
      character*60       ::  binfile, ctlfile
! ===============================================
      call getarg(1,buf)
      read(buf,*) lon
      call getarg(2,buf)
      read(buf,*) lat
      call getarg(3,binfile)
      call getarg(4,ctlfile)

      open(21,file=ctlfile,form='formatted')
        write(21,'(a6,a)'  )              'dset ^', binfile
        write(21,'(a)')                   'undef 0'
        write(21,'(a)')                   'title DFO_MODIS'
        write(21,'(a)')                   'options yrev little_endian'
        write(21,'(a5,i4,a8,f22.16,a16)') 'xdef ', nx, ' linear ', lon, ' 0.0008333333333'
        write(21,'(a5,i4,a8,f22.16,a16)') 'ydef ', ny, ' linear ', lat, ' 0.0008333333333'
        write(21,'(a)')                   'tdef 1 linear 00Z01jan2000 1yr'
        write(21,'(a)')                   'zdef 1 linear 1 1'
        write(21,'(a)')                   'vars 1'
        write(21,'(a)')                   'var  1 -1,40,1 **'
        write(21,'(a)')                   'ENDVARS'
      close(21)

      end program wrte_ctl
