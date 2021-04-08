      program check_relation
! ===============================================
      implicit none
! vars
      integer              ::  iway, nway
      parameter               (nway=1000000000)

      integer*1,allocatable  ::  way_type(:)

      character*128        ::  type, inout
      integer              ::  id, irelation, itype, iinner
      integer              ::  iwater

      integer              ::  count_water, count_non, nonid

      character*128        ::  rfile, wfile

! ===============================================
      allocate(way_type(nway))

      way_type(:)=0

      rfile='./tag_mod/way-id.txt'
      open(11,file=rfile,form='formatted')
 1000 continue
        read(11,*,end=1090) iway
        way_type(iway)=1
        goto 1000
 1090 continue
      close(11)

      rfile='./tag_mod/way-id2.txt'
      open(11,file=rfile,form='formatted')
 1100 continue
        read(11,*,end=1190) iway
        way_type(iway)=1
        goto 1100
 1190 continue
      close(11)

      iwater=0

      rfile='./tag_mod/relation-id.txt'
      wfile='./tag_mod/water-relation-id.txt'
      open(12,file=rfile,form='formatted')
      open(21,file=wfile,form='formatted')
      read(12,*) type, id, inout
      irelation=id
      itype=0
      iinner=0
      count_water=0
      count_non=0
      nonid=0
 2000 continue
        read(12,*,end=2090) type, id, inout
        if( trim(type)=='relation' )then

          if( iinner==1 ) itype=0
          print *, irelation, itype          !! print previous relation type
          if( itype>=0 ) then
            write(21,*) irelation, itype, count_water, count_non, nonid
          endif

          if( itype==1 ) iwater=iwater+1

          !!  set new ID and reset value
          irelation=id
          itype=0
          iinner=0
          count_water=0
          count_non=0
          nonid=0

        else

          iway=id

          if( way_type(iway)==1 .and. trim(inout)=='outer' )then
            if( itype==0 ) itype=1
            if( count_non>0 ) itype=2
            count_water=count_water+1
          elseif( way_type(iway)==0 .and. trim(inout)=='outer' )then
            if( itype==1 ) itype=2
            count_non=count_non+1
            nonid=iway
          elseif( way_type(iway)==1 .and. trim(inout)=='inner' )then
            iinner=1
          endif

        endif
        goto 2000  
 2090 continue

      if( iinner==1 ) itype=0
      print *, irelation, itype
      if( itype>=0 ) then
         write(21,*) irelation, itype, count_water, count_non, nonid
      endif
      if( itype==1 ) iwater=iwater+1

      close(12)
      close(21)

      print *, 'water relation=', iwater

      end program check_relation
