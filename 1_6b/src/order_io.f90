module Order_IO
   use Environment
   implicit none
   
   integer, parameter, public :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter, public :: EMPL_AMOUNT = 102
   integer, parameter, public :: POS_AMOUNT = 5
   
   type, public :: employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
      type(employee), allocatable        :: next
   end type employee
   
contains
   
   !чтение списка сотрудников
   function Read_employee_list(Input_File) result(employees)
      type(employee), allocatable :: employees
      character(*), intent(in) :: Input_File
      integer :: In
      
      open (file=Input_File, encoding=E_, newunit=In)
         call Read_employee_tail(In, employees, 1)
      close (In)
   end function Read_employee_list
   
   !хвостовая рекурсия: чтение сотрудников
   recursive subroutine Read_employee_tail(In, emp, num)
      integer, intent(in) :: In, num
      type(employee), allocatable, intent(inout) :: emp
      
      integer :: IO
      character(:), allocatable :: format
      type(employee), allocatable :: new_emp
      
      if (num > EMPL_AMOUNT) then
         if (allocated(emp)) deallocate(emp)
         return
      end if
      
      allocate(new_emp)
      format = '(a15, 1x, a15)'
      read (In, format, iostat=IO) new_emp%surname, new_emp%position
      call Handle_IO_status(IO, "reading employee " // num)
      
      if (IO == 0) then
         call Read_employee_tail(In, new_emp%next, num + 1)
         call move_alloc(new_emp, emp)
      else
         deallocate(new_emp)
         if (allocated(emp)) deallocate(emp)
      end if
   end subroutine Read_employee_tail
   
   !чтение ранга должностей
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      
      integer :: In, IO, i
      
      allocate(positions_rank(POS_AMOUNT))
      
      open (file=positions_file, encoding=E_, newunit=In)
      do i = 1, POS_AMOUNT
         read (In, '(a)', iostat=IO) positions_rank(i)
         call Handle_IO_status(IO, "reading position rank, line " // i)
      end do
      close (In)
   end subroutine Read_positions
   
   !вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_Name, Position)
      character(*), intent(in) :: Output_File, Position, List_Name
      type(employee), allocatable, intent(in) :: employees
      integer :: Out
      
      open (file=Output_File, encoding=E_, position=Position, newunit=Out)
         write (Out, '(/a)') List_Name
         call Output_employee_tail(Out, employees)
      close (Out)
   end subroutine Output_employee_list
   
   !хвостовая рекурсия: вывод сотрудников
   recursive subroutine Output_employee_tail(Out, emp)
      integer, intent(in) :: Out
      type(employee), allocatable, intent(in) :: emp
      integer :: IO
      character(:), allocatable :: format
      
      if (.not. allocated(emp)) return
      
      format = '(a15, 1x, a15)'
      write (Out, format, iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "writing employee")
      
      call Output_employee_tail(Out, emp%next)
   end subroutine Output_employee_tail
   
   
end module Order_IO