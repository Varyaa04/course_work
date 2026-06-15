module Order_IO
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15
   integer, parameter :: POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 100000
   integer, parameter :: POS_AMOUNT = 5
   
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
      type(employee), pointer            :: next     => Null()
   end type employee
   
contains
   !чтение списка сотрудников 
   function Read_employee_list(Input_File) result(empl_list)
      type(employee), pointer     :: empl_list
      character(*), intent(in)    :: Input_File
      integer                     :: In
      
      open (file=Input_File, encoding=E_, newunit=In)
         empl_list => Read_employee(In)
      close (In)
   end function Read_employee_list
   
   !чтение следующего сотрудника
   recursive function Read_employee(In) result(empl)
      type(employee), pointer  :: empl
      integer, intent(in)      :: In
      integer                  :: IO
      character(:), allocatable :: format
      
      allocate (empl)
      format = '(a' // SURNAME_LEN // ', 1x, a' // POSITION_LEN // ')'
      read (In, format, iostat=IO) empl%surname, empl%position
      call Handle_IO_status(IO, "reading line from file")
      if (IO == 0) then
         empl%next => Read_employee(In)
      else
         deallocate (empl)
         empl => Null()
      end if
   end function Read_employee
   
   !чтение ранга должностей
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in)                     :: positions_file
      character(POSITION_LEN, kind=CH_), intent(out) :: positions_rank(POS_AMOUNT)
      integer                                      :: In, IO, i
      
      open (file=positions_file, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening positions file")
      
      do i = 1, POS_AMOUNT
         read (In, '(a)', iostat=IO) positions_rank(i)
         call Handle_IO_status(IO, "reading position rank, line " // i)
      end do
      
      close (In)
   end subroutine Read_positions
   
   !вывод списка сотрудников
   subroutine Output_employee_list(Output_File, empl_list, List_Name, Position)
      character(*), intent(in)   :: Output_File, Position, List_Name
      type(employee), intent(in) :: empl_list
      integer                    :: Out
      
      open (file=Output_File, position=Position, newunit=Out)
         write (Out, '(/a)') List_Name
         call Output_employee(Out, empl_list)
      close (Out)
   end subroutine Output_employee_list
   
   !вывод следующего сотрудника
   recursive subroutine Output_employee(Out, empl)
      integer, intent(in)        :: Out
      type(employee), intent(in) :: empl
      integer                    :: IO
      character(:), allocatable  :: format
      
      format = '(a' // SURNAME_LEN // ', 1x, a' // POSITION_LEN // ')'
      write (Out, format, iostat=IO) empl%surname, empl%position
      call Handle_IO_status(IO, "writing employee")
      if (Associated(empl%next)) &
         call Output_employee(Out, empl%next)
   end subroutine Output_employee
   
   
end module Order_IO
