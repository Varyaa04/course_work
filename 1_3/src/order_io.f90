! Copyright 2015 Fyodorov S. A.

module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 15
   integer, parameter :: POS_AMOUNT = 5
   
   type employee
      character(SURNAME_LEN, kind=CH_)   :: surname  = ""
      character(POSITION_LEN, kind=CH_)  :: position = ""
   end type employee
   
contains
   
   ! Создание неформатированного файла из текстового
   subroutine CreateFile(Input_File, Data_File)
      character(*), intent(in) :: Input_File, Data_File
      
      type(employee) :: emp
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      
      open (file=Input_File, encoding=E_, newunit=In)
      
      ! Исправлено: вычисление размера записи для одного сотрудника
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open (file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl)
      
      ! Исправлен формат: читаем строки без разбивки на отдельные символы
      format = '(a, 1x, a)'
      do i = 1, EMPL_AMOUNT
         read (In, format, iostat=IO) emp
         call Handle_IO_status(IO, "reading formatted employee list, line " // i)
         
         write (Out, iostat=IO, rec=i) emp
         call Handle_IO_status(IO, "creating unformatted file with employee list, record " // i)
      end do
      
      close (In)
      close (Out)
   end subroutine CreateFile
   
   ! Чтение списка сотрудников из неформатированного файла
   function ReadEmpl(Data_File) result(employees)
      type(employee) :: employees(EMPL_AMOUNT)
      character(*), intent(in) :: Data_File
      
      integer :: In, IO, recl
      
      ! Исправлено: размер записи для всего массива
      recl = (SURNAME_LEN + POSITION_LEN) * CH_ * EMPL_AMOUNT
      open (file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl)
         read (In, iostat=IO, rec=1) employees
         call Handle_IO_status(IO, "reading unformatted employee list")
      close (In)
   end function ReadEmpl
   
   ! Вывод списка сотрудников
   subroutine WriteEmpl(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employee), intent(in) :: employees(:)
      
      integer :: Out, IO, i
      character(:), allocatable :: format
      
      open (file=Output_File, encoding=E_, position=Position, newunit=Out)
         write (Out, '(/,a)') List_name
         format = '(a, 1x, a)'
         ! Исправлено: выводим каждого сотрудника отдельно
         do i = 1, size(employees)
            write (Out, format, iostat=IO) employees(i)%surname, employees(i)%position
            call Handle_IO_status(IO, "writing " // List_name)
         end do
      close (Out)
   end subroutine WriteEmpl
   
   ! Чтение должностей из текстового файла
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), intent(out) :: positions_rank(POS_AMOUNT)
      
      integer :: In, IO, i
      character(:), allocatable :: format
      
      open (file=positions_file, encoding=E_, newunit=In)
         format = '(a)'
         do i = 1, POS_AMOUNT
            read (In, format, iostat=IO) positions_rank(i)
            call Handle_IO_status(IO, "reading positions, line " // i)
         end do
      close (In)
   end subroutine ReadPositions
   
   ! Получение массива символов из строки должности (для PositionLess)
   pure function String_to_array(str) result(arr)
      character(POSITION_LEN, kind=CH_), intent(in) :: str
      character(kind=CH_) :: arr(POSITION_LEN)
      integer :: i
      
      do i = 1, POSITION_LEN
         arr(i) = str(i:i)
      end do
   end function String_to_array
   
end module Order_io