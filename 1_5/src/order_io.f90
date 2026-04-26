module Order_IO
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15, POS_AMOUNT = 5
   
   !массив структур
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
   
   !создание неформатированного файла 
   subroutine Create_data_file(Input_File, Data_File)
      character(*), intent(in) :: Input_File, Data_File
      
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      type(employee) :: employees(EMPL_AMOUNT)  
      
      open(file=Input_File, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening input file")
      
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) (employees(i)%surname, employees(i)%position, i = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "reading formatted file")
      close(In)
      
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open(file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl, iostat=IO)
      call Handle_IO_status(IO, "opening direct access file for writing")
      
      do i = 1, EMPL_AMOUNT
         write(Out, iostat=IO, rec=i) employees(i)
         call Handle_IO_status(IO, "writing binary file, record " // i)
      end do
      
      close(Out)
   end subroutine Create_data_file
   
   !чтение списка сотрудников из неформатированного файла 
   function Read_employee_list(Data_File) result(employees)
      type(employee), allocatable :: employees(:)
      character(*), intent(in) :: Data_File
      
      integer :: In, IO, recl
      
      allocate(employees(EMPL_AMOUNT))
      recl = (SURNAME_LEN + POSITION_LEN) * CH_ * EMPL_AMOUNT
      open(file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl, iostat=IO)
      call Handle_IO_status(IO, "opening direct access file for reading")
      
      read(In, iostat=IO, rec=1) employees
      call Handle_IO_status(IO, "reading binary file")
      
      close(In)
   end function Read_employee_list
   
   !чтение  должностей
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
   
   !вывод списка 
   subroutine Output_employee_list(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO, i
      character(:), allocatable :: format
      
      open(file=Output_File, position=Position, newunit=Out, iostat=IO)
      call Handle_IO_status(IO, "opening output file")
      
      write(Out, '(/a)', iostat=IO) List_name
      call Handle_IO_status(IO, "writing " // List_name // " title")
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees)
         write(Out, format, iostat=IO) employees(i)%surname, employees(i)%position
         call Handle_IO_status(IO, "writing employee, line " // i)
      end do
      
      close(Out)
   end subroutine Output_employee_list
   
end module Order_IO