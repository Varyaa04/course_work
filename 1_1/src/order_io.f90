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
      character(SURNAME_LEN, kind=CH_), allocatable, intent(out) :: surnames(:)
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions(:)
      integer :: In, Out, IO, i
      character(:), allocatable :: format

      allocate(surnames(EMPL_AMOUNT))   
      allocate(positions(EMPL_AMOUNT))

      format = '(a15, 1x, a15)'

      !format = '(' // SURNAME_LEN // ', 1x,' //POSITION_LEN // ')'

      open (file=input_file, encoding=E_, newunit=In)
         read(In, format, iostat=IO) (surnames(i), positions(i), i = 1, EMPL_AMOUNT)  
      close(In)

      !обработка ошибок 
      Out = OUTPUT_UNIT
      open (Out, encoding=E_)
      select case(IO)
         case(0)
         case(IOSTAT_END)
            write (Out, '(a)') "End of file has been reached while reading employees."
         case(1:)
            write (Out, '(a, i0)') "Error while reading employees: ", IO
         case default
            write (Out, '(a, i0)') "Undetermined error while reading employees: ", IO
      end select

      if (IO /= 0) stop

   end subroutine ReadEmpl

   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      integer :: In, Out, IO, i
      character(:), allocatable :: format

      allocate(positions_rank(POS_AMOUNT))  

      open (file=positions_file, encoding=E_, newunit=In)
         read(In, '(a)', iostat=IO) (positions_rank(i), i = 1, POS_AMOUNT)  
      close(In)

      !обработка ошибок
      Out = OUTPUT_UNIT
      open (Out, encoding=E_)
      select case(IO)
         case(0)
         case(IOSTAT_END)
            write (Out, '(a)') "End of file has been reached while reading positions."
         case(1:)
            write (Out, '(a, i0)') "Error while reading positions: ", IO
         case default
            write (Out, '(a, i0)') "Undetermined error while reading positions: ", IO
      end select

      if (IO /= 0) stop

   end subroutine ReadPositions

   !запись сотрудников
   subroutine WriteEmpl(output_file, surnames, positions, title)
      character(*), intent(in) :: output_file
      character(SURNAME_LEN, kind=CH_), intent(in) :: surnames(:), positions(:)
      character(*), intent(in), optional :: title
      integer :: Out, IO, i
      character(:), allocatable :: format
      logical :: file_exists

      inquire(file=output_file, exist=file_exists)

      if (file_exists) then
         open(file=output_file, encoding=E_, position='append', newunit=Out, iostat=IO)
      else
         open(file=output_file, encoding=E_, newunit=Out, iostat=IO)
      end if

      if (IO /= 0) then
         Out = OUTPUT_UNIT
         open (Out, encoding=E_)
         write (Out, '(a, i0)') "Error opening output file: ", IO
         stop
      end if

      format = '(a15, 1x, a15)'



      if (present(title)) then
         if (file_exists) then
            write(Out, '(a)', iostat=IO) ""
         end if
         write(Out, '(a)', iostat=IO) title
      end if

      write(Out, format, iostat=IO) (surnames(i), positions(i), i = 1, size(surnames))

      close(Out)

      ! Обработка статуса записи
      Out = OUTPUT_UNIT
      open (Out, encoding=E_)
      select case(IO)
         case(0)
         case(IOSTAT_END)
            write (Out, '(a)') "End of file has been reached while writing employees."
         case(1:)
            write (Out, '(a, i0)') "Error while writing employees: ", IO
         case default
            write (Out, '(a, i0)') "Undetermined error while writing employees: ", IO
      end select

      if (IO /= 0) stop

   end subroutine WriteEmpl

end module Order_io
