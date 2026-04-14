module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPLOYEE_AMOUNT = 15  ! или читать из файла
   
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
  
   subroutine Create_data_file(Input_File, Data_File, n)
      character(*), intent(in) :: Input_File, Data_File
      integer, intent(out) :: n
      
      type(employee) :: emp
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      
      open(file=Input_File, encoding=E_, newunit=In)
      
      !подсчёт количества сотрудников
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         n = n + 1
      end do
      rewind(In)
      
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open(file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl)
            
      format = '(a15, 1x, a15)'
      do i = 1, n
         read(In, format, iostat=IO) emp%surname, emp%position
         call Handle_IO_status(IO, "reading formatted employee list, line " // i)
         
         write(Out, iostat=IO, rec=i) emp
         call Handle_IO_status(IO, "creating unformatted file with employee list, record " // i)
      end do
      
      close(In)
      close(Out)
   end subroutine Create_data_file
   
   !Чтение списка сотрудников из неформатированного файла
   function Read_employee_list(Data_File, n) result(employees)
      type(employee), allocatable :: employees(:)
      character(*), intent(in) :: Data_File
      integer, intent(in) :: n
      
      integer :: In, IO, recl
      
      recl = ((SURNAME_LEN + POSITION_LEN) * CH_) * n
      open(file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl)
      
      allocate(employees(n))
      read(In, iostat=IO, rec=1) employees
      call Handle_IO_status(IO, "reading unformatted employee list")
      close(In)
   end function Read_employee_list
   
   !Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO
      character(:), allocatable :: format
      
      open(file=Output_File, encoding=E_, position=Position, newunit=Out)
      write(Out, '(/a)') List_name
      format = '(a15, 1x, a15)'
      write(Out, format, iostat=IO) employees
      call Handle_IO_status(IO, "writing " // List_name)
      close(Out)
   end subroutine Output_employee_list
   
   !Чтение должностей из текстового файла
   subroutine Read_positions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      
      integer :: In, IO, m, i
      
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
         positions_rank(i) = trim(positions_rank(i))
      end do
      
      close(In)
   end subroutine Read_positions
   
end module Order_io
