module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: ALIGN = 64
   
   !Структура массивов 
   type employees_data
      character(SURNAME_LEN, kind=CH_), allocatable :: surnames(:)
      character(POSITION_LEN, kind=CH_), allocatable :: positions(:)
   end type employees_data
   
contains
   subroutine Read_formatted_file(input_file, employees, n)
      character(*), intent(in) :: input_file
      type(employees_data), intent(out) :: employees
      integer, intent(out) :: n
      
      integer :: In, IO, i
      character(:), allocatable :: format
      
      open(file=input_file, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening formatted input file")
      
      !Подсчёт строк
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         n = n + 1
      end do
      rewind(In)
      
      !Выделение памяти
      allocate(employees%surnames(n), employees%positions(n))
      
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) (employees%surnames(i), employees%positions(i), i = 1, n)
      call Handle_IO_status(IO, "reading formatted file with implicit loop")
      
      close(In)
   end subroutine Read_formatted_file
   
   subroutine Write_binary_file(binary_file, employees)
      character(*), intent(in) :: binary_file
      type(employees_data), intent(in) :: employees
      
      integer :: Out, IO
      
      open(file=binary_file, form='unformatted', newunit=Out, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary file for writing")
      
      write(Out, iostat=IO) employees%surnames, employees%positions
      call Handle_IO_status(IO, "writing binary file")
      
      close(Out)
   end subroutine Write_binary_file
   
   !чтение 
   function Read_binary_file(binary_file, n) result(employees)
      character(*), intent(in) :: binary_file
      integer, intent(in) :: n
      type(employees_data) :: employees
      
      integer :: In, IO
      
      allocate(employees%surnames(n), employees%positions(n))
      
      !потоковый режим
      open(file=binary_file, form='unformatted', newunit=In, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary file for reading")
      
      read(In, iostat=IO) employees%surnames, employees%positions
      call Handle_IO_status(IO, "reading binary file")
      
      close(In)
   end function Read_binary_file
   
   !Вывод в текстовый файл (для отчёта)
   subroutine Write_output_file(output_file, employees, title, position)
      character(*), intent(in) :: output_file, position, title
      type(employees_data), intent(in) :: employees
      
      integer :: Out, IO, i
      logical :: file_exists
      character(:), allocatable :: format
      
      inquire(file=output_file, exist=file_exists)
      
      if (position == 'append' .and. file_exists) then
         open(file=output_file, position='append', newunit=Out, iostat=IO, encoding=E_)
      else
         open(file=output_file, newunit=Out, iostat=IO, encoding=E_)
      end if
      call Handle_IO_status(IO, "opening output file")
      
      if (file_exists .and. position == 'append') then
         write(Out, '(a)', iostat=IO) ""
      end if
      write(Out, '(a)', iostat=IO) title
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees%surnames)
         write(Out, format, iostat=IO) employees%surnames(i), employees%positions(i)
      end do
      call Handle_IO_status(IO, "writing " // title)
      
      close(Out)
   end subroutine Write_output_file
   
   !Чтение ранга должностей из текстового файла
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      
      integer :: In, IO, m, i
      
      open(file=positions_file, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening positions file")
      
      m = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         m = m + 1
      end do
      rewind(In)
      
      allocate(positions_rank(m))
      
      do i = 1, m
         read(In, '(a)', iostat=IO) positions_rank(i)
         call Handle_IO_status(IO, "reading position rank, line " // i)
         positions_rank(i) = trim(positions_rank(i))
      end do
      
      close(In)
   end subroutine Read_positions
   
end module Order_io
