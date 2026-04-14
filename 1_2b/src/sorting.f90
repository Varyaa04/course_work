module Sorting
   use Order_io
   use Environment
   implicit none
   
contains
  
   pure function PositionLess(a, b, positions_rank) result(res)
      character(kind=CH_), intent(in) :: a(:), b(:)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      logical :: res
      integer :: i, pos_a, pos_b
      logical :: found_a, found_b
      
      pos_a = huge(1)
      pos_b = huge(1)
      found_a = .false.
      found_b = .false.
      
      do i = 1, size(positions_rank, 2)
         if (.not. found_a) then
            if (CompareStrings(positions_rank(:, i), a, POSITION_LEN)) then
               pos_a = i
               found_a = .true.
            end if
         end if
         if (.not. found_b) then
            if (CompareStrings(positions_rank(:, i), b, POSITION_LEN)) then
               pos_b = i
               found_b = .true.
            end if
         end if
         if (found_a .and. found_b) exit
      end do
      
      res = pos_a < pos_b
   end function PositionLess
   
   !Сортировка чёт-нечет
   subroutine SortEmpl(surnames, positions, positions_rank)
      character(kind=CH_), intent(inout) :: surnames(:, :), positions(:, :)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      
      integer :: n, j, k
      logical :: sorted
      character(kind=CH_) :: tmp_s(SURNAME_LEN), tmp_p(POSITION_LEN)
      
      n = size(surnames, 2)  ! количество сотрудников (второй индекс)
      sorted = .false.
    
      do while (.not. sorted)
         sorted = .true.
         
         !Четная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !Обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               
               !Обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(k, j)
                  positions(k, j) = positions(k, j+1)
                  positions(k, j+1) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !Нечетная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !Обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               
               !Обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(k, j)
                  positions(k, j) = positions(k, j+1)
                  positions(k, j+1) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine SortEmpl
   
end module Sorting
