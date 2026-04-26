module Order_IO
   use Environment
   implicit none
   
   integer, parameter, public :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter, public :: EMPL_AMOUNT = 15, POS_AMOUNT = 5
   
   ! Рекурсивно размещаемый тип (однонаправленный список)
   type, public :: employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
      type(employee), allocatable        :: next
   end type employee
   
contains
   
   ! Чтение списка сотрудников из форматированного файла
   function Read_employee_list(Input_File) result(employees)
      type(employee), allocatable :: employees
      character(*), intent(in) :: Input_File
      integer :: In
      
      open(file=Input_File, encoding=E_, newunit=In)
      call Read_employee_tail(In, employees)
      close(In)
   end function Read_employee_list
   
   ! ХВОСТОВАЯ РЕКУРСИЯ: чтение сотрудников с накоплением
   recursive subroutine Read_employee_tail(In, emp, count)
      integer, intent(in) :: In
      type(employee), allocatable, intent(inout) :: emp
      integer, intent(in), optional :: count
      
      integer :: IO, current_count
      character(:), allocatable :: format
      type(employee), allocatable :: new_emp
      
      current_count = 1
      if (present(count)) current_count = count
      
      if (current_count > EMPL_AMOUNT) then
         if (allocated(emp)) deallocate(emp)
         return
      end if
      
      allocate(new_emp)
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) new_emp%surname, new_emp%position
      call Handle_IO_status(IO, "reading employee " // current_count)
      
      if (IO == 0) then
         ! ХВОСТОВАЯ РЕКУРСИЯ
         call Read_employee_tail(In, new_emp%next, current_count + 1)
         call move_alloc(new_emp, emp)
      else
         deallocate(new_emp)
         if (allocated(emp)) deallocate(emp)
      end if
   end subroutine Read_employee_tail
   
   ! Чтение ранга должностей
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      
      integer :: In, IO, i, m
      
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
      end do
      
      close(In)
   end subroutine Read_positions
   
   ! Получение ранга должности (ЦИКЛ вместо findloc для совместимости)
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
   
   ! Подсчёт количества сотрудников (ХВОСТОВАЯ РЕКУРСИЯ)
   recursive function Count_employees(emp, accum) result(n)
      type(employee), allocatable, intent(in) :: emp
      integer, intent(in) :: accum
      integer :: n
      
      if (allocated(emp)) then
         n = Count_employees(emp%next, accum + 1)
      else
         n = accum
      end if
   end function Count_employees
   
   ! Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_Name, Position)
      character(*), intent(in) :: Output_File, Position, List_Name
      type(employee), allocatable, intent(in) :: employees
      integer :: Out
      
      open(file=Output_File, encoding=E_, position=Position, newunit=Out)
      write(Out, '(/a)') List_Name
      call Output_employee_tail(Out, employees)
      close(Out)
   end subroutine Output_employee_list
   
   ! ХВОСТОВАЯ РЕКУРСИЯ: вывод сотрудников
   recursive subroutine Output_employee_tail(Out, emp)
      integer, intent(in) :: Out
      type(employee), allocatable, intent(in) :: emp
      integer :: IO
      character(:), allocatable :: format
      
      if (.not. allocated(emp)) return
      
      format = '(a15, 1x, a15)'
      write(Out, format, iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "writing employee")
      
      call Output_employee_tail(Out, emp%next)
   end subroutine Output_employee_tail
   
   ! Освобождение памяти списка (ХВОСТОВАЯ РЕКУРСИЯ)
   recursive subroutine Free_employee_list(emp)
      type(employee), allocatable, intent(inout) :: emp
      
      if (allocated(emp)) then
         call Free_employee_list(emp%next)
         deallocate(emp)
      end if
   end subroutine Free_employee_list
   
   ! Копирование списка в массив структур для сортировки
   recursive subroutine List_to_array(emp, array, idx)
      type(employee), allocatable, intent(in) :: emp
      type(employee), allocatable, intent(inout) :: array(:)
      integer, intent(in) :: idx
      
      if (.not. allocated(emp)) return
      if (idx > size(array)) return
      
      array(idx) = emp
      call List_to_array(emp%next, array, idx + 1)
   end subroutine List_to_array
   
   ! Копирование массива обратно в список (рекурсивно)
   recursive subroutine Array_to_list(emp, array, idx)
      type(employee), allocatable, intent(inout) :: emp
      type(employee), allocatable, intent(in) :: array(:)
      integer, intent(in) :: idx
      
      if (idx > size(array)) return
      
      if (.not. allocated(emp)) then
         allocate(emp)
      end if
      emp = array(idx)
      call Array_to_list(emp%next, array, idx + 1)
   end subroutine Array_to_list
   
end module Order_IO