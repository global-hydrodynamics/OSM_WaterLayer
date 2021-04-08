      program check_relation
! ===============================================
      implicit none
! vars
      integer              ::  id, irelation, itype

      character*128        ::  rfile, buf

! ===============================================
      call getarg(1,buf)
      read(buf,*) id

      rfile='./tag_mod/water-relation-id.txt'
 1000 continue
        read(21,*,end=1090) irelation, itype
        if( id==irelation ) then
          print *, itype
          stop
        endif
      goto 1000
 1090 continue
      print *, -9

      end program check_relation
