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
      
      ra = findloc(positions_rank, trim(a), dim=1)
      rb = findloc(positions_rank, trim(b), dim=1)
      
      if (ra == 0 .or. rb == 0) then
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
      logical :: swap_needed
      
      n = size(surnames)
      sorted = .false.
    
      do while (.not. sorted)
         sorted = .true.
   
         !$omp simd private(tmp_s, tmp_p) private(swap_needed)
         do j = 1, n-1, 2
            swap_needed = PositionLess(positions(j+1), positions(j), positions_rank)
            if (swap_needed) then
               !Меняем фамилии
               tmp_s = surnames(j)
               surnames(j) = surnames(j+1)
               surnames(j+1) = tmp_s
               
               !Меняем должности
               tmp_p = positions(j)
               positions(j) = positions(j+1)
               positions(j+1) = tmp_p
               
               sorted = .false.
            end if
         end do
         !$omp end simd       

         !$omp simd private(tmp_s, tmp_p) private(swap_needed)
         do j = 2, n-1, 2
            swap_needed = PositionLess(positions(j+1), positions(j), positions_rank)
            if (swap_needed) then
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
         !$omp end simd
         
      end do
      
   end subroutine SortEmpl
   
end module Sorting
