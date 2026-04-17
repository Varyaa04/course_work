module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 12   
   integer, parameter :: POS_AMOUNT = 5     
contains

   !чтение сотрудников 
   subroutine ReadEmpl(input_file, surnames, positions)
      character(*), intent(in) :: input_file
      character(SURNAME_LEN, kind=CH_), intent(out) :: surnames(EMPL_AMOUNT)
      character(POSITION_LEN, kind=CH_), intent(out) :: positions(EMPL_AMOUNT)
      integer :: In, IO, i
      character(:), allocatable :: format

      format = '(a15, 1x, a15)'

      open (file=input_file, encoding=E_, newunit=In)
         read(In, format, iostat=IO) (surnames(i), positions(i), i = 1, EMPL_AMOUNT)  
      close(In)

      if (IO /= 0) then
         write(ERROR_UNIT, '(a, i0)') "Error while reading employees: ", IO
         stop
      end if

   end subroutine ReadEmpl

   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), intent(out) :: positions_rank(POS_AMOUNT)
      integer :: In, IO, i

      open (file=positions_file, encoding=E_, newunit=In)
         read(In, '(a)', iostat=IO) (positions_rank(i), i = 1, POS_AMOUNT)  
      close(In)

      if (IO /= 0) then
         write(ERROR_UNIT, '(a, i0)') "Error while reading positions: ", IO
         stop
      end if

   end subroutine ReadPositions

   !запись сотрудников
   subroutine WriteEmpl(output_file, surnames, positions, title, mode)
      character(*), intent(in) :: output_file
      character(SURNAME_LEN, kind=CH_), intent(in) :: surnames(EMPL_AMOUNT)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions(EMPL_AMOUNT)
      character(*), intent(in) :: title
      character(*), intent(in) :: mode  
      integer :: Out, IO, i
      character(:), allocatable :: format

      if (mode == "rewind") then
         open(file=output_file, newunit=Out, iostat=IO, status='replace')
      else
         open(file=output_file, position='append', newunit=Out, iostat=IO)
      end if

      if (IO /= 0) then
         write(ERROR_UNIT, '(a, i0)') "Error opening output file: ", IO
         stop
      end if

      format = '(a15, 1x, a15)'

      if (mode == "append") then
         write(Out, '(a)', iostat=IO) ''
      end if
      
      write(Out, '(a)', iostat=IO) title
      write(Out, format, iostat=IO) (surnames(i), positions(i), i = 1, EMPL_AMOUNT)

      close(Out)

      if (IO /= 0) then
         write(ERROR_UNIT, '(a, i0)') "Error while writing employees: ", IO
         stop
      end if

   end subroutine WriteEmpl

end module Order_io