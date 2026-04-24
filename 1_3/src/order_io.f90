module Order_io
   use Environment
   implicit none

   integer, parameter :: SURNAME_LEN = 15
   integer, parameter :: POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15
   integer, parameter :: POS_AMOUNT = 5

   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname   = ""
      character(POSITION_LEN, kind=CH_)  :: position  = ""
   end type employee

contains

   !создание неформатированного файла 
   subroutine CreateEmplBinary(input_file, binary_file)
      character(*), intent(in) :: input_file, binary_file
      type(employee) :: emp
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format

      recl = SURNAME_LEN * CH_ + POSITION_LEN * CH_ !длина одной записи в байтах для прямого доступа
      format = '(a15, 1x, a15)'

      open (file=input_file, encoding=E_, newunit=In)
      open (file=binary_file, form='unformatted', newunit=Out, access='direct', recl=recl)

      do i = 1, EMPL_AMOUNT
         read (In, format, iostat=IO) emp%surname, emp%position
         call Handle_IO_Status(IO, "reading formatted employee " // i)

         write (Out, iostat=IO, rec=i) emp
         call Handle_IO_Status(IO, "writing unformatted employee " // i)
      end do

      close (In)
      close (Out)
   end subroutine CreateEmplBinary

   !чтение всего массива структур из неформатированного файла
   function ReadEmployeesBinary(binary_file) result(employees)
      character(*), intent(in) :: binary_file
      type(employee), allocatable :: employees(:)
      integer :: In, IO, recl

      allocate(employees(EMPL_AMOUNT))
      recl = (SURNAME_LEN * CH_ + POSITION_LEN * CH_) * EMPL_AMOUNT !длина всего массива в байтах для чтения за один раз

      open (file=binary_file, form='unformatted', newunit=In, access='direct', recl=recl)
      read (In, iostat=IO, rec=1) employees
      call Handle_IO_Status(IO, "reading unformatted employees array")
      close (In)
   end function ReadEmployeesBinary

   !создание бинарного файла с должностями
   subroutine CreatePositionsBinary(pos_file, binary_pos_file)
      character(*), intent(in) :: pos_file, binary_pos_file
      character(POSITION_LEN, kind=CH_) :: pos
      integer :: In, Out, IO, i, recl

      recl = POSITION_LEN * CH_

      open (file=pos_file, encoding=E_, newunit=In)
      open (file=binary_pos_file, form='unformatted', newunit=Out, access='direct', recl=recl)

      do i = 1, POS_AMOUNT
         read (In, '(a)', iostat=IO) pos
         call Handle_IO_Status(IO, "reading position " // i)

         write (Out, iostat=IO, rec=i) pos
         call Handle_IO_Status(IO, "writing unformatted position " // i)
      end do

      close (In)
      close (Out)
   end subroutine CreatePositionsBinary

   !чтение должностей из бинарного файла
   function ReadPositionsBinary(binary_pos_file) result(positions_rank)
      character(*), intent(in) :: binary_pos_file
      character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
      integer :: In, IO, recl

      allocate(positions_rank(POS_AMOUNT))
      recl = POSITION_LEN * CH_ * POS_AMOUNT

      open (file=binary_pos_file, form='unformatted', newunit=In, access='direct', recl=recl)
      read (In, iostat=IO, rec=1) positions_rank
      call Handle_IO_Status(IO, "reading unformatted positions array")
      close (In)
   end function ReadPositionsBinary

   !вывод сотрудников 
   subroutine WriteEmployeesText(output_file, employees, title, position)
      character(*), intent(in) :: output_file, title, position
      type(employee), intent(in) :: employees(:)
      integer :: Out, IO, i
      character(:), allocatable :: format

      open (file=output_file, position=position, newunit=Out)

      write (Out, '(/, a)', iostat=IO) title
      call Handle_IO_Status(IO, "writing title")

      format = '(a15, 1x, a15)'
      do i = 1, size(employees)
         write (Out, format, iostat=IO) employees(i)%surname, employees(i)%position
         call Handle_IO_Status(IO, "writing employee " // i)
      end do

      close (Out)
   end subroutine WriteEmployeesText

end module Order_io