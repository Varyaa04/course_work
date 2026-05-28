module Order_IO
   use Environment
   implicit none
   
   integer, parameter, public :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter, public :: EMPL_AMOUNT = 50000
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
         call Read_employee(In, employees)
      close (In)
   end function Read_employee_list
   
   ! Чтение следующего сотрудника 
   recursive subroutine Read_employee(In, emp)
      type(employee), allocatable :: emp
      integer, intent(in)         :: In
      integer  IO
      
      allocate(emp)
      read (In, '(a15, 1x, a15)', iostat=IO) emp%surname, emp%position
      call Handle_IO_status(IO, "reading employee from file")
      
      if (IO == 0) then
          call Read_employee(In, emp%next)
      else
         deallocate(emp)
      end if
   end subroutine Read_employee
   
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
         call Output_employee(Out, employees)
      close (Out)
   end subroutine Output_employee_list
   
   ! Вывод сотрудника 
   recursive subroutine Output_employee(Out, emp)
      integer, intent(in)         :: Out
      type(employee), allocatable, intent(in) :: emp
      
      integer :: IO
      
      if (allocated(emp)) then
         write (Out, '(a15, 1x, a15)', iostat=IO) emp%surname, emp%position
         call Handle_IO_status(IO, "writing employee")
         call Output_employee(Out, emp%next)
      end if
   end subroutine Output_employee
   
end module Order_IO
