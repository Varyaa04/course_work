module Order_io
   use Environment
   implicit none
   
   integer, parameter :: SURNAME_LEN = 15, POSITION_LEN = 15
   integer, parameter :: EMPL_AMOUNT = 12   
   integer, parameter :: POS_AMOUNT = 5     
   
contains

   !чтение сотрудников 
   subroutine ReadEmpl(input_file, surnames, positions)
      character(*), intent(in) :: input_file
      character(kind=CH_), intent(out) :: surnames(:, :), positions(:, :)
      integer :: In, IO, i
      character(SURNAME_LEN, kind=CH_) :: surname_str
      character(POSITION_LEN, kind=CH_) :: position_str

      open (file=input_file, encoding=E_, newunit=In)
         do i = 1, EMPL_AMOUNT
            read(In, '(a15, 1x, a15)', iostat=IO) surname_str, position_str
            call Handle_IO_status(IO, "reading employees")
            surnames(i, :) = transfer(surname_str, surnames(i, :))
            positions(i, :) = transfer(position_str, positions(i, :))
         end do
      close(In)
   end subroutine ReadEmpl

   !чтение должностей 
   subroutine ReadPositions(positions_file, positions_rank)
      character(*), intent(in) :: positions_file
      character(kind=CH_), intent(out) :: positions_rank(:, :)
      integer :: In, IO, i
      character(POSITION_LEN, kind=CH_) :: pos_str

      open (file=positions_file, encoding=E_, newunit=In)
         do i = 1, POS_AMOUNT
            read(In, '(a)', iostat=IO) pos_str
            call Handle_IO_status(IO, "reading positions")
            positions_rank(i, :) = transfer(pos_str, positions_rank(i, :))
         end do
      close(In)
   end subroutine ReadPositions

   !запись сотрудников 
   subroutine WriteEmpl(output_file, surnames, positions, title, mode)
      character(*), intent(in) :: output_file
      character(kind=CH_), intent(in) :: surnames(:, :), positions(:, :)
      character(*), intent(in) :: title
      character(*), intent(in) :: mode  
      integer :: Out, IO, i
      character(SURNAME_LEN, kind=CH_) :: surname_str
      character(POSITION_LEN, kind=CH_) :: position_str

      if (mode == "rewind") then
         open(file=output_file, newunit=Out, iostat=IO, status='replace')
      else
         open(file=output_file, position='append', newunit=Out, iostat=IO)
      end if
      call Handle_IO_status(IO, "opening output file")

      if (mode == "append") then
         write(Out, '(a)', iostat=IO) ''
         call Handle_IO_status(IO, "writing empty line")
      end if
      
      write(Out, '(a)', iostat=IO) title
      call Handle_IO_status(IO, "writing " // title)
      
      do i = 1, EMPL_AMOUNT
         surname_str = transfer(surnames(i, :), surname_str)
         position_str = transfer(positions(i, :), position_str)
         write(Out, '(a15, 1x, a15)', iostat=IO) surname_str, position_str
         call Handle_IO_status(IO, "writing employees")
      end do

      close(Out)
   end subroutine WriteEmpl

end module Order_io