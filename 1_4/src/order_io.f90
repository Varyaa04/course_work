module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15, EMPL_AMOUNT = 15
   integer, parameter :: POS_AMOUNT = 5
   
   !структура одного сотрудника
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
   
   !чтение из текстового файла
   subroutine ReadEmployeesBinary(input_file, employees)
      character(*), intent(in) :: input_file
      type(employee), allocatable, intent(out) :: employees(:)
      
      integer :: In, IO, i
      character(:), allocatable :: format
      
      allocate(employees(EMPL_AMOUNT))
      
      open(file=input_file, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening formatted input file")
      
      format = '(a15, 1x, a15)'
      read(In, format, iostat=IO) (employees(i)%surname, employees(i)%position, i = 1, EMPL_AMOUNT)
      call Handle_IO_status(IO, "reading formatted file")
      
      close(In)
   end subroutine ReadEmployeesBinary
   
   ! Запись бинарного файла (потоковый режим)
   subroutine WriteBinaryFile(binary_file, employees)
      character(*), intent(in) :: binary_file
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO
      
      open(file=binary_file, form='unformatted', newunit=Out, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary file for writing")
      
      write(Out, iostat=IO) employees
      call Handle_IO_status(IO, "writing binary file")
      
      close(Out)
   end subroutine WriteBinaryFile
   
   ! Создание бинарного файла с должностями
   subroutine CreatePositionsBinary(pos_file, binary_pos_file)
      character(*), intent(in) :: pos_file, binary_pos_file
      character(POSITION_LEN, kind=CH_) :: pos
      integer :: In, Out, IO, i
      
      open(file=pos_file, encoding=E_, newunit=In)
      open(file=binary_pos_file, form='unformatted', newunit=Out, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary positions file")
      
      do i = 1, POS_AMOUNT
         read(In, '(a)', iostat=IO) pos
         call Handle_IO_status(IO, "reading position " // i)
         write(Out, iostat=IO) pos
         call Handle_IO_status(IO, "writing position " // i)
      end do
      
      close(In)
      close(Out)
   end subroutine CreatePositionsBinary
   
   ! Чтение должностей из бинарного файла
   function ReadPositionsBinary(binary_pos_file) result(positions_rank)
      character(*), intent(in) :: binary_pos_file
      character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
      
      integer :: In, IO
      
      allocate(positions_rank(POS_AMOUNT))
      
      open(file=binary_pos_file, form='unformatted', newunit=In, access='stream', iostat=IO)
      call Handle_IO_status(IO, "opening binary positions file")
      
      read(In, iostat=IO) positions_rank
      call Handle_IO_status(IO, "reading positions")
      
      close(In)
   end function ReadPositionsBinary
   
   ! Вывод в текстовый файл
   subroutine WriteOutputFile(output_file, employees, title, position)
      character(*), intent(in) :: output_file, position, title
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO, i
      logical :: file_exists
      character(:), allocatable :: format
      
      inquire(file=output_file, exist=file_exists)
      
      if (position == 'append' .and. file_exists) then
         open(file=output_file, position='append', newunit=Out, iostat=IO)
      else
         open(file=output_file, newunit=Out, iostat=IO)
      end if
      call Handle_IO_status(IO, "opening output file")
      
      if (file_exists .and. position == 'append') then
         write(Out, '(a)', iostat=IO) ""
      end if
      write(Out, '(a)', iostat=IO) title
      
      format = '(a15, 1x, a15)'
      do i = 1, size(employees)
         write(Out, format, iostat=IO) employees(i)%surname, employees(i)%position
      end do
      call Handle_IO_status(IO, "writing " // title)
      
      close(Out)
   end subroutine WriteOutputFile
   
end module Order_io