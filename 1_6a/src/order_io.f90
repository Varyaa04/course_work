module Order_IO
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15, POS_AMOUNT = 5
   
   ! ОДНОНАПРАВЛЕННЫЙ СПИСОК
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
      type(employee), pointer            :: next     => Null()
   end type employee
   
contains
   
   ! Чтение списка сотрудников из форматированного файла
   function Read_employee_list(Input_File) result(empl)
      type(employee), pointer :: empl
      character(*), intent(in) :: Input_File
      integer :: In, i
      
      open(file=Input_File, encoding=E_, newunit=In)
      
      ! Чтение первого сотрудника
      allocate(empl)
      call Read_employee_data(In, empl, 1)
      
      ! Чтение остальных сотрудников (ХВОСТОВАЯ РЕКУРСИЯ)
      call Read_remaining_employees(In, empl, 2)
      close(In)

      contains
      ! Чтение данных одного сотрудника
         subroutine Read_employee_data(In, emp, num)
            integer, intent(in) :: In, num
            type(employee), intent(inout) :: emp
            integer :: IO
            character(:), allocatable :: format
            
            format = '(a15, 1x, a15)'
            read(In, format, iostat=IO) emp%surname, emp%position
            call Handle_IO_status(IO, "reading employee " // num)
         end subroutine Read_employee_data
   end function Read_employee_list
   
  
   
   ! ХВОСТОВАЯ РЕКУРСИЯ: чтение оставшихся сотрудников
   recursive subroutine Read_remaining_employees(In, prev, num)
      integer, intent(in) :: In, num
      type(employee), pointer, intent(in) :: prev
      
      if (num > EMPL_AMOUNT) then
         prev%next => Null()
         return
      end if
      
      allocate(prev%next)
      call Read_employee_data(In, prev%next, num)
      
      ! ХВОСТОВАЯ РЕКУРСИЯ
      call Read_remaining_employees(In, prev%next, num + 1)
   end subroutine Read_remaining_employees
   
   ! Чтение ранга должностей
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), intent(out) :: positions_rank(POS_AMOUNT)
      
      integer :: In, IO, i
      
      open(file=positions_file, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening positions file")
      
      do i = 1, POS_AMOUNT
         read(In, '(a)', iostat=IO) positions_rank(i)
         call Handle_IO_status(IO, "reading position rank, line " // i)
      end do
      
      close(In)
   end subroutine Read_positions
   
   ! Получение ранга должности (ЦИКЛ вместо findloc)
   pure function Get_position_rank(position, positions_rank) result(rank)
      character(POSITION_LEN, kind=CH_), intent(in) :: position
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer :: rank
      integer :: i
      
      rank = 0
      do i = 1, size(positions_rank)
         if (positions_rank(i) == position) then
            rank = i
            exit
         end if
      end do
   end function Get_position_rank
   
   ! Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, head, List_Name, Position)
      character(*), intent(in) :: Output_File, Position, List_Name
      type(employee), pointer, intent(in) :: head
      integer :: Out
      
      open(file=Output_File, position=Position, newunit=Out)
      write(Out, '(/a)') List_Name
      
      ! ХВОСТОВАЯ РЕКУРСИЯ для вывода
      call Output_employee(Out, head)
      
      close(Out)
   end subroutine Output_employee_list
   
   ! ХВОСТОВАЯ РЕКУРСИЯ: вывод сотрудников
   recursive subroutine Output_employee(Out, emp)
      integer, intent(in) :: Out
      type(employee), pointer, intent(in) :: emp
      integer :: IO
      character(:), allocatable :: format
      
      if (.not. Associated(emp)) return
      
      format = '(a15, 1x, a15)'
      write(Out, format, iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "writing employee")
      
      ! ХВОСТОВАЯ РЕКУРСИЯ
      call Output_employee(Out, emp%next)
   end subroutine Output_employee
   
   ! Освобождение памяти списка (ХВОСТОВАЯ РЕКУРСИЯ)
   recursive subroutine Free_employee_list(emp)
      type(employee), pointer :: emp
      
      if (Associated(emp)) then
         call Free_employee_list(emp%next)
         deallocate(emp)
         emp => Null()
      end if
   end subroutine Free_employee_list
   
end module Order_IO