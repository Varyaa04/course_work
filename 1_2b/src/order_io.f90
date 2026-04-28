module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15   
   integer, parameter :: POS_AMOUNT = 5     
   
contains

   !чтение сотрудников 
   subroutine ReadEmpl(input_file, surnames, positions)
      character(*), intent(in) :: input_file
      character(kind=CH_), intent(out) :: surnames(:, :), positions(:, :)
      integer :: In, IO, j
      character(:), allocatable :: format
      
      open (file=input_file, encoding=E_, newunit=In)
         format = '(15a1, 1x, 15a1)'
         ! Вторая размерность - номер записи (j), первая - символы (индексы i и j поменяны)
         read (In, format, iostat=IO) (surnames(1:SURNAME_LEN, j), positions(:, j), j = 1, EMPL_AMOUNT)
         call Handle_IO_status(IO, "reading employees")
      close (In)
   end subroutine ReadEmpl

   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(kind=CH_), intent(out) :: positions_rank(:, :)
      integer :: In, IO, j
      character(:), allocatable :: format
      
      open (file=positions_file, encoding=E_, newunit=In)
         format = '(15a1)'
         read (In, format, iostat=IO) (positions_rank(:, j), j = 1, POS_AMOUNT)
         call Handle_IO_status(IO, "reading positions")
      close (In)
   end subroutine ReadPositions

   !запись сотрудников 
   subroutine WriteEmpl(output_file, surnames, positions, title, mode)
      character(*), intent(in) :: output_file
      character(kind=CH_), intent(in) :: surnames(:, :), positions(:, :)
      character(*), intent(in) :: title
      character(*), intent(in) :: mode  
      integer :: Out, IO, j
      character(:), allocatable :: format
      
      if (mode == "rewind") then
         open(file=output_file, newunit=Out, iostat=IO, status='replace')
      else
         open(file=output_file, position='append', newunit=Out, iostat=IO)
      end if
      call Handle_IO_status(IO, "opening output file")

      if (mode == "append") then
         write(Out, '(a)', iostat=IO) ''
         call Handle_IO_status(IO, "writing empty line")
      end if
      
      write(Out, '(a)', iostat=IO) title
      call Handle_IO_status(IO, "writing " // title)
   
      format = '(15a1, 1x, 15a1)'
      !surnames(:, j) — столбец j (фамилия из 15 букв)
      write(Out, format, iostat=IO) (surnames(:, j), positions(:, j), j = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "writing employees")

      close(Out)
   end subroutine WriteEmpl

end module Order_io
