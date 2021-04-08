      program check_relation
! ===============================================
      implicit none
! vars
      integer              ::  irel, nrel
      parameter               (nrel=1000000000)

      integer              ::  itype
      integer,allocatable  ::  type(:)

      character*512        ::  buf, buf2, first, nul

      character*128        ::  rfile, wfile
! ===============================================
      allocate(type(nrel))
      type(:)=0

      rfile='./tag_mod/water-relation-id.txt'
      open(11,file=rfile,form='formatted')
 1000 continue
        read(11,*,end=1090) irel, itype
        type(irel)=itype
      goto 1000
 1090 continue
      close(11)


!====================================================
      rfile='./tag_mod/notag-relation.osm'
      wfile='./tag_mod/water_add-relation.osm'

      open(11,file=rfile,form='formatted')
      open(21,file=wfile,form='formatted')

      print *, 'read header'

      read(11,'(a256)') buf
      write(21,'(a)') trim(buf)

      read(11,'(a256)') buf
      write(21,'(a)') trim(buf)

      read(11,'(a256)') buf
      write(21,'(a)') trim(buf)

!====================================================
      print *, 'read data'

 2000 continue

      read(11,'(a256)',end=2090) buf
      read(buf,*) first
      if( trim(first)=='<relation' )then
        buf2=buf
        call conv_buf(buf2)
        read(buf2,*) nul, nul, irel
        itype=type(irel)
      endif

      if( itype==1 )then
        write(21,'(a)') trim(buf)
        if( trim(first)=='<relation' )then
          print *, irel, itype, trim(buf)
          write(21,'(a)') '    <tag k="natural" v="water"/>'
          write(21,'(a)') '    <tag k="natural" v="water_add"/>'
        endif
      endif

      goto 2000
 2090 continue

      if( itype/=2 )then
        write(21,*) trim(buf)
      endif

      close(11)
      close(21)


      end program check_relation



!====================================================
      subroutine conv_buf(buf)
      character*512  ::  buf
      integer        ::  i

      do i=1, 512
        if( buf(i:i)=='"' ) buf(i:i)=' '
      end do

      end subroutine conv_buf


