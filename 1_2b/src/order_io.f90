module Order_io
   use Environment
   implicit none
   
   !длины должны быть кратны 32 байтам
   integer, parameter :: SURNAME_LEN = 32      
   integer, parameter :: POSITION_LEN = 32   
   integer, parameter :: REAL_SURNAME_LEN = 15
   integer, parameter :: REAL_POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15   
   integer, parameter :: POS_AMOUNT = 5   
   
contains

   !чтение сотрудников 
   subroutine ReadEmpl(input_file, surnames, positions)
      character(*), intent(in) :: input_file
      character(kind=CH_), allocatable, intent(out) :: surnames(:, :), positions(:, :)
      integer :: In, IO, j
      character(:), allocatable :: format
      character(kind=CH_) :: temp_surnames(15, EMPL_AMOUNT)  !временный массив для чтения
      character(kind=CH_) :: temp_positions(15, EMPL_AMOUNT) !временный массив для чтения
      
      allocate(surnames(SURNAME_LEN, EMPL_AMOUNT))
      allocate(positions(POSITION_LEN, EMPL_AMOUNT))
      
      !oбнуляем лишние байты
      surnames = ''
      positions = ''
      
      open (file=input_file, encoding=E_, newunit=In)
         format = '(' // REAL_SURNAME_LEN// 'a1, 1x, ' // REAL_POSITION_LEN// 'a1)'
         !читаем во временный массив
         read (In, format, iostat=IO) (temp_surnames(1:15, j), temp_positions(1:15, j), j = 1, EMPL_AMOUNT)
         call Handle_IO_status(IO, "reading employees")
         
         !копируем в выровненные массивы 
         surnames(1:15, 1:EMPL_AMOUNT) = temp_surnames(1:15, 1:EMPL_AMOUNT)
         positions(1:15, 1:EMPL_AMOUNT) = temp_positions(1:15, 1:EMPL_AMOUNT)
      close (In)
   end subroutine ReadEmpl

   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(kind=CH_), allocatable, intent(out) :: positions_rank(:, :)
      integer :: In, IO, j
      character(:), allocatable :: format
      character(kind=CH_) :: temp_rank(15, POS_AMOUNT)
      
      allocate(positions_rank(POSITION_LEN, POS_AMOUNT))
      positions_rank = ''
      
      open (file=positions_file, encoding=E_, newunit=In)
         format = '(' // REAL_POSITION_LEN //'a1)'
         read (In, format, iostat=IO) (temp_rank(1:15, j), j = 1, POS_AMOUNT)
         call Handle_IO_status(IO, "reading positions")
         
         !копируем в выровненные массивы 
         positions_rank(1:15, 1:POS_AMOUNT) = temp_rank(1:15, 1:POS_AMOUNT)
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
   
      format = '(' // REAL_SURNAME_LEN // 'a1, 1x, ' // REAL_POSITION_LEN // 'a1)'
      !выводим только реальные 15 символов
      write(Out, format, iostat=IO) (surnames(1:15, j), positions(1:15, j), j = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "writing employees")

      close(Out)
   end subroutine WriteEmpl

end module Order_io