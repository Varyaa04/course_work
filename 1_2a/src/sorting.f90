module Sorting
   use Order_io
   use Environment
   implicit none
   
contains
  
   pure function PositionLess(a, b, positions_rank) result(res)
      character(kind=CH_), intent(in) :: a(:), b(:)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      logical :: res
      integer :: pos_a, pos_b, i
      
      pos_a = 0
      pos_b = 0
      
      ! поиск позиции для a 
      do i = 1, POS_AMOUNT
         if (all(positions_rank(i, :) == a)) then
            pos_a = i
            exit
         end if
      end do
      
      ! поиск позиции для b
      do i = 1, POS_AMOUNT
         if (all(positions_rank(i, :) == b)) then
            pos_b = i
            exit
         end if
      end do
      
      if (pos_a == 0 .or. pos_b == 0) then
         res = .false.
      else
         res = pos_a < pos_b
      end if
      
   end function PositionLess
   
   !cортировка чёт-нечет
   subroutine SortEmpl(surnames, positions, positions_rank)
      character(kind=CH_), intent(inout) :: surnames(:, :), positions(:, :)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      integer :: n, i, k
      logical :: sorted
      character(kind=CH_) :: tmp_s(SURNAME_LEN), tmp_p(POSITION_LEN)
      
      n = size(surnames, 1)  
      sorted = .false.
    
      do while (.not. sorted)
         sorted = .true.
         
         ! Чётная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do i = 1, n-1, 2
            if (PositionLess(positions(i+1, :), positions(i, :), positions_rank)) then
               !обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(i, k)
                  surnames(i, k) = surnames(i+1, k)
                  surnames(i+1, k) = tmp_s(k)
               end do
               !обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(i, k)
                  positions(i, k) = positions(i+1, k)
                  positions(i+1, k) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !нечётная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do i = 2, n-1, 2
            if (PositionLess(positions(i+1, :), positions(i, :), positions_rank)) then
 !!убрать явно              !обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(i, k)
                  surnames(i, k) = surnames(i+1, k)
                  surnames(i+1, k) = tmp_s(k)
               end do
               !обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(i, k)
                  positions(i, k) = positions(i+1, k)
                  positions(i+1, k) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
      end do
      
   end subroutine SortEmpl
   
end module Sorting
