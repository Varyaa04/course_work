module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   
   ! Структура данных для хранения информации о сотруднике (однонаправленный список)
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
      type(employee), pointer            :: next     => Null()
   end type employee
   
contains
   
   ! Чтение списка сотрудников из форматированного файла
   function Read_employee_list(Input_File) result(employees)
      type(employee), pointer :: employees
      character(*), intent(in) :: Input_File
      integer :: In
      
      open(file=Input_File, encoding=E_, newunit=In)
      employees => Read_employee(In)
      close(In)
   end function Read_employee_list
   
   ! Рекурсивное чтение следующего сотрудника (хвостовая рекурсия)
   recursive function Read_employee(In) result(emp)
      type(employee), pointer :: emp
      integer, intent(in) :: In
      integer :: IO
      character(:), allocatable :: format
      
      allocate(emp)
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "reading line from file")
      
      if (IO == 0) then
         emp%next => Read_employee(In)
      else
         deallocate(emp)
         nullify(emp)
      end if
   end function Read_employee
   
   ! Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_Name, Position)
      character(*), intent(in) :: Output_File, Position, List_Name
      type(employee), intent(in) :: employees
      integer :: Out
      
      open(file=Output_File, encoding=E_, position=Position, newunit=Out)
      write(Out, '(/a)') List_Name
      call Output_employee(Out, employees)
      close(Out)
   end subroutine Output_employee_list
   
   ! Рекурсивный вывод сотрудников
   recursive subroutine Output_employee(Out, emp)
      integer, intent(in) :: Out
      type(employee), intent(in) :: emp
      integer :: IO
      character(:), allocatable :: format
      
      format = '(a15, 1x, a15)'
      write(Out, format, iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "writing employee")
      
      if (Associated(emp%next)) &
         call Output_employee(Out, emp%next)
   end subroutine Output_employee
   
   ! Чтение ранга должностей из текстового файла (в массив для быстрого доступа)
   subroutine Read_positions(positions_file, positions_rank, m)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      integer, intent(out) :: m
      
      integer :: In, IO, i
      
      open(file=positions_file, encoding=E_, newunit=In)
      
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
   
   ! Подсчёт количества сотрудников в списке (НЕ pure из-за указателей)
   recursive function Count_employees(emp) result(n)
      type(employee), pointer, intent(in) :: emp
      integer :: n
      
      if (Associated(emp)) then
         n = 1 + Count_employees(emp%next)
      else
         n = 0
      end if
   end function Count_employees
   
   ! Освобождение памяти списка
   recursive subroutine Free_employee_list(emp)
      type(employee), pointer :: emp
      
      if (Associated(emp)) then
         call Free_employee_list(emp%next)
         deallocate(emp)
         nullify(emp)
      end if
   end subroutine Free_employee_list
   
end module Order_io
