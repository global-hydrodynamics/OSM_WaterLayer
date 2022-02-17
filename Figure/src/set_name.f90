      program list_file
! ===============================================
      implicit none
!
      real            ::  lon, lat

      character*1     ::  ew, sn
      character*2     ::  clat
      character*3     ::  clon
      character*30    ::  wfile

      character*128   ::  buf
! ===============================================
      call getarg(1,buf)
      read(buf,*) lon
      call getarg(2,buf)
      read(buf,*) lat

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

      wfile=sn//clat//ew//clon
      print '(a7)', wfile

      end program list_file