module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: ALIGN = 64
   character(kind=CH_, len=1), parameter :: SPACE = ' '
   
contains
   
   subroutine ReadEmpl(input_file, surnames, positions, n)
      character(*), intent(in) :: input_file
      character(kind=CH_), allocatable, intent(out) :: surnames(:, :), positions(:, :)
      integer, intent(out) :: n
      integer :: In, IO, i, j
      character(len=SURNAME_LEN, kind=CH_) :: surname_str
      character(len=POSITION_LEN, kind=CH_) :: position_str
      
      open(file=input_file, newunit=In, iostat=IO, encoding=E_)
      call Handle_IO_status(IO, "opening input file")
      
      ! Подсчёт строк 
      n = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         n = n + 1
      end do
      rewind(In)
     
      !$omp allocate(surnames) align(ALIGN)
      allocate(surnames(n, SURNAME_LEN))
      
      !$omp allocate(positions) align(ALIGN)
      allocate(positions(n, POSITION_LEN))
      
      do i = 1, n
         do j = 1, SURNAME_LEN
            surnames(i, j) = SPACE
         end do
      end do
      
      do i = 1, n
         do j = 1, POSITION_LEN
            positions(i, j) = SPACE
         end do
      end do
      
      do i = 1, n
         read(In, '(a15, 1x, a15)', iostat=IO) surname_str, position_str
         call Handle_IO_status(IO, "reading data")
         
         !Копирование символов
         do j = 1, len_trim(surname_str)
            surnames(i, j) = surname_str(j:j)
         end do
         
         do j = 1, len_trim(position_str)
            positions(i, j) = position_str(j:j)
         end do
      end do
      
      close(In)
   end subroutine ReadEmpl
   
   subroutine WriteEmpl(output_file, surnames, positions, title)
      character(*), intent(in) :: output_file
      character(kind=CH_), intent(in) :: surnames(:, :), positions(:, :)
      character(*), intent(in), optional :: title
      integer :: Out, IO, i, j
      logical :: file_exists
      character(len=SURNAME_LEN, kind=CH_) :: surname_str
      character(len=POSITION_LEN, kind=CH_) :: position_str
      
      inquire(file=output_file, exist=file_exists)
      
      if (file_exists) then
         open(file=output_file, position='append', newunit=Out, iostat=IO, encoding=E_)
      else
         open(file=output_file, newunit=Out, iostat=IO, encoding=E_)
      end if
      call Handle_IO_status(IO, "opening output file")
      
      if (present(title)) then
         if (file_exists) then
            write(Out, '(a)', iostat=IO) ""
         end if 
         write(Out, '(a)', iostat=IO) title
      end if
      
      do i = 1, size(surnames, 1)
         !Сборка строки из символов
         surname_str = REPEAT(SPACE, SURNAME_LEN)
         do j = 1, SURNAME_LEN
            if (surnames(i, j) /= SPACE) then
               surname_str(j:j) = surnames(i, j)
            end if
         end do
         
         position_str = REPEAT(SPACE, POSITION_LEN)
         do j = 1, POSITION_LEN
            if (positions(i, j) /= SPACE) then
               position_str(j:j) = positions(i, j)
            end if
         end do
         
         write(Out, '(a15, 1x, a15)', iostat=IO) surname_str, position_str
      end do
      
      close(Out)
   end subroutine WriteEmpl
   
   subroutine ReadPositions(positions_file, positions_rank, m)
      character(*), intent(in) :: positions_file
      character(kind=CH_), allocatable, intent(out) :: positions_rank(:, :)
      integer, intent(out) :: m
      integer :: In, IO, i, j
      character(len=POSITION_LEN, kind=CH_) :: pos_str
      
      open(file=positions_file, newunit=In, iostat=IO, encoding=E_)
      call Handle_IO_status(IO, "opening positions file")
      
      m = 0
      do
         read(In, '(a)', iostat=IO)
         if (is_iostat_end(IO)) exit
         m = m + 1
      end do
      rewind(In)
      
      !$omp allocate(positions_rank) align(ALIGN)
      allocate(positions_rank(m, POSITION_LEN))
      
      do i = 1, m
         do j = 1, POSITION_LEN
            positions_rank(i, j) = SPACE
         end do
      end do
      
      do i = 1, m
         read(In, '(a)', iostat=IO) pos_str
         pos_str = trim(pos_str)
         
         do j = 1, len_trim(pos_str)
            positions_rank(i, j) = pos_str(j:j)
         end do
      end do
      
      close(In)
   end subroutine ReadPositions
   
   !Функция сравнения строк в двумерных массивах
   pure function CompareStrings(a, b, len) result(is_equal)
      character(kind=CH_), intent(in) :: a(:), b(:)
      integer, intent(in) :: len
      logical :: is_equal
      integer :: i
      
      is_equal = .true.
      do i = 1, len
         if (a(i) /= b(i)) then
            is_equal = .false.
            return
         end if
      end do
   end function CompareStrings
   
end module Order_io
