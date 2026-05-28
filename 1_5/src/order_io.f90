module Order_IO
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15
   integer, parameter :: POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 100000
   integer, parameter :: POS_AMOUNT = 5
   
   ! Структура массивов (SoA) - сплошные данные
   type employees_soa
      character(SURNAME_LEN, kind=CH_)   :: surnames(EMPL_AMOUNT)
      character(POSITION_LEN, kind=CH_)  :: positions(EMPL_AMOUNT)
   end type employees_soa
   
contains
   
   ! Создание неформатированного файла
   subroutine Create_data_file(Input_File, Data_File)
      character(*), intent(in) :: Input_File, Data_File
      
      integer :: In, Out, IO, i, recl
      character(:), allocatable :: format
      type(employees_soa) :: employees
      
      open(file=Input_File, encoding=E_, newunit=In, iostat=IO)
      call Handle_IO_status(IO, "opening input file")
      
      ! Формат с конкатенацией как в прошлом проекте
      format = '(a' // SURNAME_LEN // ', 1x, a' // POSITION_LEN // ')'
      
      do i = 1, EMPL_AMOUNT
         read(In, format, iostat=IO) employees%surnames(i), employees%positions(i)
         call Handle_IO_status(IO, "reading employee line " // i)
      end do
      close(In)
      
      ! Запись в бинарный файл
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open(file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl, iostat=IO)
      call Handle_IO_status(IO, "opening direct access file for writing")
      
      do i = 1, EMPL_AMOUNT
         write(Out, iostat=IO, rec=i) employees%surnames(i), employees%positions(i)
         call Handle_IO_status(IO, "writing binary file, record " // i)
      end do
      
      close(Out)
   end subroutine Create_data_file
   
   ! Чтение списка сотрудников из неформатированного файла
   function Read_employee_list(Data_File) result(employees)
      type(employees_soa) :: employees
      character(*), intent(in) :: Data_File
      
      integer :: In, IO, i, recl
      
      recl = (SURNAME_LEN + POSITION_LEN) * CH_
      open(file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl, iostat=IO)
      call Handle_IO_status(IO, "opening direct access file for reading")
      
      do i = 1, EMPL_AMOUNT
         read(In, iostat=IO, rec=i) employees%surnames(i), employees%positions(i)
         call Handle_IO_status(IO, "reading binary file, record " // i)
      end do
      
      close(In)
   end function Read_employee_list
   
   ! Чтение должностей из текстового файла
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
   
   ! Вывод списка сотрудников
   subroutine Output_employee_list(Output_File, employees, List_name, Position)
      character(*), intent(in) :: Output_File, Position, List_name
      type(employees_soa), intent(in) :: employees
      
      integer :: Out, IO, i
      character(:), allocatable :: format
      logical :: file_exists
      
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
      write(Out, '(/a)', iostat=IO) List_name
      call Handle_IO_status(IO, "writing " // List_name // " title")
      
      ! Формат с конкатенацией как в прошлом проекте
      format = '(a' // SURNAME_LEN // ', 1x, a' // POSITION_LEN // ')'
      
      do i = 1, EMPL_AMOUNT
         write(Out, format, iostat=IO) employees%surnames(i), employees%positions(i)
         call Handle_IO_status(IO, "writing employee, line " // i)
      end do
      
      close(Out)
   end subroutine Output_employee_list
   
end module Order_IO