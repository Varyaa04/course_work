module Sorting
   use Order_io
   use Environment
   implicit none

contains
   pure function PositionLess(a, b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: a, b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: ra, rb
      integer :: i
      character(POSITION_LEN) :: a_trim, b_trim, rank_trim
   
      a_trim = trim(adjustl(a))
      b_trim = trim(adjustl(b))
   !!!!!!FINDLOC!!!!!
      ra = 0
      rb = 0
   
      do i = 1, size(positions_rank)
         rank_trim = trim(adjustl(positions_rank(i)))
         if (rank_trim == a_trim) ra = i
            if (rank_trim == b_trim) rb = i
      end do

      if (ra == 0 .and. rb == 0) then
         res = .false.
      else if (ra == 0) then
         res = .true.   
      else if (rb == 0) then
         res = .false.
      else
         res = ra < rb
      end if

   end function PositionLess 

   !Cортировка чёт-нечет
   subroutine SortEmpl(surnames, positions, positions_rank)
      character(SURNAME_LEN, kind=CH_), intent(inout) :: surnames(:)
      character(POSITION_LEN, kind=CH_), intent(inout) :: positions(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, j
      character(SURNAME_LEN, kind=CH_) :: tmp_s
      character(POSITION_LEN, kind=CH_) :: tmp_p
      logical :: sorted
      !logical :: swap_needed
      
      n = size(surnames)
      sorted = .false.
    
      do while (.not. sorted)
         sorted = .true.
      
         !четная фаза  
         !$omp parallel do private(tmp_s, tmp_p) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(positions(j+1), positions(j), positions_rank)) then
               ! Обмен фамилиями
               tmp_s = surnames(j)
               surnames(j) = surnames(j+1)
               surnames(j+1) = tmp_s
               
               ! Обмен должностями
               tmp_p = positions(j)
               positions(j) = positions(j+1)
               positions(j+1) = tmp_p
               
               sorted = .false. 
            end if
         end do
         !$omp end parallel do
      
         !нечетная фаза
         !$omp parallel do private(tmp_s, tmp_p) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(positions(j+1), positions(j), positions_rank)) then

     
               ! Меняем фамилии
               tmp_s = surnames(j)
               surnames(j) = surnames(j+1)
               surnames(j+1) = tmp_s
               
               ! Меняем должности
               tmp_p = positions(j)
               positions(j) = positions(j+1)
               positions(j+1) = tmp_p
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine SortEmpl
   
end module Sorting
