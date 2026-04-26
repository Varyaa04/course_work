module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15, POS_AMOUNT = 5
   
   !структура данных для хранения данных о сотруднике
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
   
   !чтение списка сотрудников из текстового файла
   subroutine Read_employees_list(Input_File, employees)
      character(*), intent(in)   :: Input_File
      type(employee), allocatable, intent(out) :: employees(:)
      
      integer In, IO, i
      character(:), allocatable :: format
      
      allocate(employees(EMPL_AMOUNT))
      
      open (file=Input_File, encoding=E_, newunit=In)
         format = '(a15, 1x, a15)'
         read(In, format, iostat=IO) (employees(i)%surname, employees(i)%position, i = 1, EMPL_AMOUNT)
         call Handle_IO_status(IO, "reading formatted employees list")
      close (In)
   end subroutine Read_employees_list
   
   !создание неформатированного файла с сотрудниками
   subroutine Create_employees_binary(Input_File, Binary_File)
      character(*), intent(in)   :: Input_File, Binary_File
      
      type(employee) :: emp
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      
      open (file=Input_File, encoding=E_, newunit=In)
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open (file=Binary_File, form='unformatted', newunit=Out, access='direct', recl=recl)
         format = '(a15, 1x, a15)'
         do i = 1, EMPL_AMOUNT
            read(In, format, iostat=IO) emp%surname, emp%position
            call Handle_IO_status(IO, "reading formatted employees list, line " // i)
            
            write(Out, iostat=IO, rec=i) emp
            call Handle_IO_status(IO, "creating unformatted file with employees list, record " // i)
         end do
      close (In)
      close (Out)
   end subroutine Create_employees_binary
   
   !чтение сотрудников 
   function Read_employees_binary(Binary_File) result(employees)
      type(employee), allocatable :: employees(:)
      character(*), intent(in)   :: Binary_File
      
      integer In, IO, recl
      
      allocate(employees(EMPL_AMOUNT))
      recl = (SURNAME_LEN + POSITION_LEN) * CH_ * EMPL_AMOUNT
      open (file=Binary_File, form='unformatted', newunit=In, access='direct', recl=recl)
         read(In, iostat=IO, rec=1) employees
         call Handle_IO_status(IO, "reading unformatted employees list")
      close (In)
   end function Read_employees_binary
   
   !создание бинарного файла с должностями
   subroutine Create_positions_binary(Pos_File, Binary_Pos_File)
      character(*), intent(in) :: Pos_File, Binary_Pos_File
      character(POSITION_LEN, kind=CH_) :: pos
      integer :: In, Out, IO, i, recl
      
      open (file=Pos_File, encoding=E_, newunit=In)
      recl = POSITION_LEN * CH_
      open (file=Binary_Pos_File, form='unformatted', newunit=Out, access='direct', recl=recl)
         do i = 1, POS_AMOUNT
            read(In, '(a)', iostat=IO) pos
            call Handle_IO_status(IO, "reading position " // i)
            write(Out, iostat=IO, rec=i) pos
            call Handle_IO_status(IO, "writing position " // i)
         end do
      close (In)
      close (Out)
   end subroutine Create_positions_binary
   
   !чтение должностей
   function Read_positions_binary(Binary_Pos_File) result(positions_rank)
      character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
      character(*), intent(in) :: Binary_Pos_File
      
      integer In, IO, recl
      
      allocate(positions_rank(POS_AMOUNT))
      recl = POSITION_LEN * CH_ * POS_AMOUNT
      open (file=Binary_Pos_File, form='unformatted', newunit=In, access='direct', recl=recl)
         read(In, iostat=IO, rec=1) positions_rank
         call Handle_IO_status(IO, "reading positions")
      close (In)
   end function Read_positions_binary
   
   !вывод списка сотрудников в текстовый файл
   subroutine Output_employees_list(Output_File, employees, List_name, Position)
      character(*), intent(in)   :: Output_File, Position, List_name
      type(employee), intent(in) :: employees(:)
      
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
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees)
         write(Out, format, iostat=IO) employees(i)%surname, employees(i)%position
      end do
      call Handle_IO_status(IO, "writing " // List_name)
      
      close(Out)
   end subroutine Output_employees_list
   
end module Order_io