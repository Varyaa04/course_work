module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: ALIGN = 64
   
contains
   
    subroutine ReadEmpl(input_file, surnames, positions, n)
      character(*), intent(in) :: input_file
      character(SURNAME_LEN, kind=CH_), allocatable, intent(out) :: surnames(:)
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions(:)
      integer, intent(out) :: n
      integer :: In, IO, i
      
      open(file=input_file, newunit=In, iostat=IO, encoding=E_)
      call Handle_IO_status(IO, "opening input file")
      
      ! Подсчёт строк 
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (IO == IOSTAT_END) exit
         call Handle_IO_status(IO, "reading input file for line counting")
         n = n + 1
      end do
      rewind(In)
     
      !$omp allocate(surnames) align(ALIGN)
      allocate(surnames(n))

      !$omp allocate(positions) align(ALIGN)
      allocate(positions(n))
     
      !print *, "      Выравнивание surnames:", mod(loc(surnames), 64)
      !print *, "      Выравнивание positions:", mod(loc(positions), 64) 
      
      do i = 1, n
         read(In, '(a15, 1x, a15)', iostat=IO) surnames(i), positions(i)
         call Handle_IO_status(IO, "reading data, line " // i)
         surnames(i) = trim(surnames(i))
         positions(i) = trim(positions(i))
      end do
      
      close(In)
   end subroutine ReadEmpl
   
   subroutine WriteEmpl(output_file, surnames, positions, title)
      character(*), intent(in) :: output_file
      character(SURNAME_LEN, kind=CH_), intent(in) :: surnames(:), positions(:)
      character(*), intent(in), optional :: title
      integer :: Out, IO, i
      logical :: file_exists
      
      inquire(file=output_file, exist=file_exists)
      
      if (file_exists) then
         open(file=output_file, position='append', newunit=Out, iostat=IO, encoding=E_)
         call Handle_IO_status(IO, "opening output file for append")
      else
         open(file=output_file, newunit=Out, iostat=IO, encoding=E_)
         call Handle_IO_status(IO, "opening output file")
      end if
      
      if (present(title)) then
         if (file_exists) then
            write(Out, '(a)', iostat=IO) ""
            call Handle_IO_status(IO, "writing empty line")
         end if 
         write(Out, '(a)', iostat=IO) title
         call Handle_IO_status(IO, "writing title: " // title)
      end if
      
      do i = 1, size(surnames)
         write(Out, '(a15, 1x, a15)', iostat=IO) surnames(i), positions(i)
         call Handle_IO_status(IO, "writing data, line " // i)
      end do
      
      close(Out)
   end subroutine WriteEmpl
   
  subroutine ReadPositions(positions_file, positions_rank, m)
      character(*), intent(in) :: positions_file
      character(POSITION_LEN, kind=CH_), allocatable, intent(out) :: positions_rank(:)
      integer, intent(out) :: m
      integer :: In, IO, i
      
      open(file=positions_file, newunit=In, iostat=IO, encoding=E_)
      call Handle_IO_status(IO, "opening positions file")
      
      m = 0
      do
         read(In, '(a)', iostat=IO)
         if (IO == IOSTAT_END) exit
         call Handle_IO_status(IO, "reading positions file for line counting")
         m = m + 1
      end do
      rewind(In)
      
      !$omp allocate(positions_rank) align(ALIGN)
      allocate(positions_rank(m))
      
      do i = 1, m
         read(In, '(a)', iostat=IO) positions_rank(i)
         call Handle_IO_status(IO, "reading position rank, line " // i)
         positions_rank(i) = trim(positions_rank(i))
      end do
      
      close(In)
   end subroutine ReadPositions
   
end module Order_io
