module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: ALIGN = 64
   
   ! Структура массивов
   type employees_data
      character(SURNAME_LEN, kind=CH_), allocatable :: surnames(:)
      character(POSITION_LEN, kind=CH_), allocatable :: positions(:)
   end type employees_data
   
contains
   
   !Создание неформатированного файла данных из текстового
   subroutine Create_data_file(Input_File, Data_File, n)
      character(*), intent(in) :: Input_File, Data_File
      integer, intent(out) :: n
      
      integer :: In, Out, IO, i
      character(:), allocatable :: format
      character(SURNAME_LEN, kind=CH_), allocatable :: surnames(:)
      character(POSITION_LEN, kind=CH_), allocatable :: positions(:)
      
      open(file=Input_File, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening input file")
      
      !Подсчёт количества сотрудников
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         n = n + 1
      end do
      rewind(In)
      
      !Выделение памяти под временные массивы
      allocate(surnames(n), positions(n))
      
      !Чтение одним оператором с неявным циклом
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) (surnames(i), positions(i), i = 1, n)
      call Handle_IO_status(IO, "reading formatted file with implicit loop")
      close(In)
      
      !Запись в неформатированный файл (потоковый режим)
      open(file=Data_File, form='unformatted', newunit=Out, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary file for writing")
      
      write(Out, iostat=IO) surnames, positions
      call Handle_IO_status(IO, "writing binary file")
      
      close(Out)
   end subroutine Create_data_file
   
   !Чтение списка сотрудников из неформатированного файла
   function Read_employee_list(Data_File, n) result(employees)
      character(*), intent(in) :: Data_File
      integer, intent(in) :: n
      type(employees_data) :: employees
      
      integer :: In, IO
      
      allocate(employees%surnames(n), employees%positions(n))
      
      open(file=Data_File, form='unformatted', newunit=In, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary file for reading")
     

      read(In, iostat=IO) employees%surnames, employees%positions
      call Handle_IO_status(IO, "reading binary file")
      
      close(In)
   end function Read_employee_list
   
   ! Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employees_data), intent(in) :: employees
      
      integer :: Out, IO, i
      character(:), allocatable :: format
      
      open(file=Output_File, encoding=E_, position=Position, newunit=Out, iostat=IO)
      call Handle_IO_status(IO, "opening output file")
      
      write(Out, '(/a)', iostat=IO) List_name
      call Handle_IO_status(IO, "writing " // List_name // " title")
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees%surnames)
         write(Out, format, iostat=IO) employees%surnames(i), employees%positions(i)
         call Handle_IO_status(IO, "writing employee, line " // i)
      end do
      
      close(Out)
   end subroutine Output_employee_list
   
   ! Чтение ранга должностей
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
         positions_rank(i) = positions_rank(i)
      end do
      
      close(In)
   end subroutine Read_positions
   
end module Order_io
