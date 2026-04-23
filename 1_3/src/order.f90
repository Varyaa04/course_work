module Order_io
   use Environment

   implicit none
   integer, parameter :: SURNAME_LEN   = 15
   integer, parameter :: POSITION_LEN  = 15
   integer, parameter :: EMPL_AMOUNT = 15
   integer, parameter :: POS_AMOUNT = 5

   ! Структура данных для хранения данных о сотруднике
   type employee
      character(SURNAME_LEN, kind=CH_)    :: Surname             = ""
      character(POSITION_LEN, kind=CH_)   :: Initials             = ""
   end type employee
   
contains
   ! Создание неформатированного файла данных.
   subroutine Create_data_file(Input_File, Data_File)
      character(*), intent(in)   :: Input_File, data_file
      type(employee)              :: empl
      integer                    :: In, Out, IO, i, recl
      character(:), allocatable  :: format
	  
      open (file=Input_File, encoding=E_, newunit=In)
      recl = (SURNAME_LEN + POSITION_LEN )*CH_ 
      open (file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl)
         format = '(a15, 1x, a15)'
         do i = 1, EMPL_AMOUNT
            read (In, format, iostat=IO) empl
            call Handle_IO_status(IO, "reading formatted list, line " // i)
            write (Out, iostat=IO, rec=i) empl
            call Handle_IO_status(IO, "creating unformatted file with list, record " // i)
         end do
      close (In)
      close (Out)
   end subroutine Create_data_file

   ! Чтение списка класса: фамилии, инициалы, полы и оценки.
   function Read_class_list(Data_File) result(Order)
      type(empl)                 Order(EMPL_AMOUNT)
      character(*), intent(in)   :: Data_File

      integer In, IO, recl
      
      recl = ((SURNAME_LEN + INITIALS_LEN + 1)*CH_ + MARKS_AMOUNT*I_ + R_) * STUD_AMOUNT
      open (file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl)
         read (In, iostat=IO, rec=1) Group
	  ! для ifort/ifx: open (file=Data_File, form='unformatted', newunit=In, access='stream')
	  !  read (In, iostat=IO) Group
         call Handle_IO_status(IO, "reading unformatted class list")
      close (In)
   end function Read_class_list
 
   ! Вывод списка класса.
   subroutine Output_class_list(Output_File, Group, List_name, Position)
      character(*), intent(in)   :: Output_File, Position, List_name
      type(student), intent(in)  :: Group(:)

      integer                    :: Out, IO
      character(:), allocatable  :: format
      
      open (file=Output_File, encoding=E_, position=Position, newunit=Out)
         write (out, '(/a)') List_name
         format = '(3(a, 1x), ' // MARKS_AMOUNT // 'i1, f5.2)'
         write (Out, format, iostat=IO) Group
         call Handle_IO_status(IO, "writing " // List_name)
      close (Out)
   end subroutine Output_class_list
end module Order_io 
