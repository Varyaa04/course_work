module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
   !создание неформатированного файла 
   subroutine CreateFile(Input_File, Data_File, n)
      character(*), intent(in) :: Input_File, Data_File
      integer, intent(out) :: n
      
      type(employee) :: emp
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      
      open(file=Input_File, encoding=E_, newunit=In)
      
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         n = n + 1
      end do
      rewind(In)
      
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open(file=Data_File, newunit=Out, access='direct', recl=recl)
      
      format = '(a15, 1x, a15)'
      do i = 1, n
         read(In, format, iostat=IO) emp%surname, emp%position
         call Handle_IO_status(IO, "reading formatted employee list, line " // i)
         
         write(Out, iostat=IO, rec=i) emp
         call Handle_IO_status(IO, "creating unformatted file with employee list, record " // i)
      end do
      
      close(In)
      close(Out)
   end subroutine CreateFile
   
   !чтение списка сотрудников из неформатированного файла
   function ReadEmpl(Data_File, n) result(employees)
      type(employee), allocatable :: employees(:)
      character(*), intent(in) :: Data_File
      integer, intent(in) :: n
      
      integer :: In, IO, recl
      
      recl = ((SURNAME_LEN + POSITION_LEN) * CH_) * n
      open(file=Data_File, newunit=In, access='direct', recl=recl)
      
      allocate(employees(n))
      read(In, iostat=IO, rec=1) employees
      call Handle_IO_status(IO, "reading unformatted employee list")
      close(In)
   end function ReadEmpl
   
   !вывод списка 
   subroutine WriteEmpl(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO, i
      character(:), allocatable :: format
      
      open(file=Output_File, position=Position, newunit=Out)
      write(Out, '(/a)') List_name
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees)
         write(Out, format, iostat=IO) employees(i)%surname, employees(i)%position
         call Handle_IO_status(IO, "writing " // List_name)
      end do
      
      close(Out)
   end subroutine WriteEmpl
   
   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
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
   end subroutine ReadPositions
   
end module Order_io