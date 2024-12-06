subroutine binopen(unit, file, action, nx, ny, nz, recl)
    implicit none

    integer     , intent(out) :: unit
    character(*), intent(in) :: file
    character(*), intent(in) :: action
    integer     , intent(in) :: nx
    integer     , intent(in) :: ny
    integer     , intent(in) :: nz
    integer     , intent(in) :: recl

    if (nx <= 0) then
        write(*,'(A)') 'ERROR STOP'
        write(*,'(A,I0)') 'Invalid Grid Size : NX=', nx
        write(*,'(A)') 'Argument "nx" should be more than 0'
        ERROR STOP
    endif

    if (ny <= 0) then
        write(*,'(A)') 'ERROR STOP'
        write(*,'(A,I0)') 'Invalid Grid Size : NY=', ny
        write(*,'(A)') 'Argument "ny" should be more than 0'
        ERROR STOP
    endif

    if (nz <= 0) then
        write(*,'(A)') 'ERROR STOP'
        write(*,'(A,I0)') 'Invalid Grid Size : NZ=', nz
        write(*,'(A)') 'Argument "nz" should be more than 0'
        ERROR STOP
    endif

    if (recl <= 0) then
        write(*,'(A)') 'ERROR STOP'
        write(*,'(A,I0)') 'Invalid record length : ', recl
        write(*,'(A)') 'Argument "recl" should be more than 0'
        ERROR STOP
    endif

    open(NEWUNIT=unit         , &
       & FILE   =file         , &
       & ACTION =action       , &
       & FORM   ='UNFORMATTED', &
       & ACCESS ='DIRECT'     , &
       & RECL   =recl           )

end subroutine binopen


subroutine fclose(unit)
    implicit none

    integer, intent(inout) :: unit
    logical :: open_status

    INQUIRE(unit      , &  !! IN
          & OPENED=open_status)  !! OUT

    if (open_status) then
        close(unit)
        return
    else
        return
    endif

end subroutine fclose


subroutine fread(unit, nx, ny, nz, record, input_data)
    implicit none

    integer, intent(in)  :: unit
    integer, intent(in)  :: nx
    integer, intent(in)  :: ny
    integer, intent(in)  :: nz
    integer, intent(in)  :: record
    real(4), intent(out) :: input_data(nx,ny,nz)

    read(unit,rec=record) input_data(1:nx,1:ny,1:nz)

end subroutine fread


subroutine fwrite_sp(unit, nx, ny, nz, record, output_data)
    implicit none

    integer, intent(in) :: unit
    integer, intent(in) :: nx
    integer, intent(in) :: ny
    integer, intent(in) :: nz
    integer, intent(in) :: record
    real(4), intent(in) :: output_data(nx,ny,nz)

    write(unit,rec=record) output_data(1:nx,1:ny,1:nz)

end subroutine fwrite_sp


subroutine fwrite_dp(unit, nx, ny, nz, record, output_data)
    implicit none

    integer, intent(in) :: unit
    integer, intent(in) :: nx
    integer, intent(in) :: ny
    integer, intent(in) :: nz
    integer, intent(in) :: record
    real(8), intent(in) :: output_data(nx,ny,nz)

    write(unit,rec=record) output_data(1:nx,1:ny,1:nz)

end subroutine fwrite_dp



