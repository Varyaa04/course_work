module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 100, POS_AMOUNT = 5
   
   type employees_soa
      character(SURNAME_LEN, kind=CH_) :: surnames(EMPL_AMOUNT)
      character(POSITION_LEN, kind=CH_) :: positions(EMPL_AMOUNT)
   end type employees_soa
   
contains
   
   !чтение сотрудников
   subroutine Read_employees_list(Input_File, employees)
      character(*), intent(in) :: Input_File
      type(employees_soa), intent(out) :: employees
      
      integer :: In, IO, i 
      character(:), allocatable :: format
      character(SURNAME_LEN, kind=CH_) :: surnames_tmp(EMPL_AMOUNT)
      character(POSITION_LEN, kind=CH_) :: positions_tmp(EMPL_AMOUNT)
      
      open (file=Input_File, encoding=E_, newunit=In)
      format = '(a' // SURNAME_LEN // ', 1x, a'// POSITION_LEN // ')'
      
      read(In, format, iostat=IO) (surnames_tmp(i), positions_tmp(i), i = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "reading formatted employees list")
      
      employees%surnames = surnames_tmp
      employees%positions = positions_tmp
      
      close (In)
   end subroutine Read_employees_list
   
   !создание бинарного файла 
   subroutine Create_employees_binary(Input_File, Binary_File)
      character(*), intent(in) :: Input_File, Binary_File
      
      type(employees_soa) :: employees
      integer :: Out, IO
      
      call Read_employees_list(Input_File, employees)
      
      open (file=Binary_File, form='unformatted', access='stream', newunit=Out, iostat=IO)
      call Handle_IO_status(IO, "opening binary file for writing")
      
      write(Out, iostat=IO) employees
      call Handle_IO_status(IO, "creating stream file with employees list")
      
      close (Out)
   end subroutine Create_employees_binary
   
   !чтение из бинарного файла
   function Read_employees_binary(Binary_File) result(employees)
      type(employees_soa) :: employees
      character(*), intent(in) :: Binary_File
      
      integer :: In, IO
      
      open (file=Binary_File, form='unformatted', access='stream', newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening binary file for reading")
      
      read(In, iostat=IO) employees
      call Handle_IO_status(IO, "reading stream employees list")
      
      close (In)
   end function Read_employees_binary
   
   !создание бинарного файла с должностями 
   subroutine Create_positions_binary(Pos_File, Binary_Pos_File)
      character(*), intent(in) :: Pos_File, Binary_Pos_File
      character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
      integer :: In, Out, IO, i  
      
      open (file=Pos_File, encoding=E_, newunit=In)
      
      read(In, '(a)', iostat=IO) (positions_rank(i), i = 1, POS_AMOUNT)
      call Handle_IO_status(IO, "reading positions")
      
      open (file=Binary_Pos_File, form='unformatted', access='stream', newunit=Out, iostat=IO)
      call Handle_IO_status(IO, "opening positions binary file for writing")
      
      write(Out, iostat=IO) positions_rank
      call Handle_IO_status(IO, "writing positions to stream file")
      
      close (In)
      close (Out)
   end subroutine Create_positions_binary
   
   !чтение должностей из бинарного файла 
   function Read_positions_binary(Binary_Pos_File) result(positions_rank)
      character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
      character(*), intent(in) :: Binary_Pos_File
      
      integer :: In, IO
      
      open (file=Binary_Pos_File, form='unformatted', access='stream', newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening positions binary file for reading")
      
      read(In, iostat=IO) positions_rank
      call Handle_IO_status(IO, "reading positions from stream file")
      
      close (In)
   end function Read_positions_binary
   
   !вывод 
   subroutine Output_employees_list(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employees_soa), intent(in) :: employees
      
      integer :: Out, IO, i
      logical :: file_exists
      character(:), allocatable :: format
      
      inquire(file=Output_File, exist=file_exists)
      
      if (Position == 'append' .and. file_exists) then
         open(file=Output_File, position='append', newunit=Out, iostat=IO)
      else
         open(file=Output_File, newunit=Out, iostat=IO)
      end if
      call Handle_IO_status(IO, "opening output file")
      
      if (file_exists .and. Position == 'append') then
         write(Out, '(a)', iostat=IO) ""
      end if
      write(Out, '(a)', iostat=IO) List_name
      
      format = '(a' // SURNAME_LEN // ', 1x, a'// POSITION_LEN // ')'
      
      write(Out, format, iostat=IO) (employees%surnames(i), employees%positions(i), i = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "writing " // List_name)
      
      close(Out)
   end subroutine Output_employees_list
   
end module Order_io
