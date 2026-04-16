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
      character(len=POSITION_LEN, kind=CH_) :: str_a, str_b
      character(len=POSITION_LEN, kind=CH_), allocatable :: rank_strings(:)
      
      str_a = ""
      do i = 1, POSITION_LEN
         if (a(i) /= SPACE) str_a(i:i) = a(i)
      end do
      str_a = trim(str_a)
      
      str_b = ""
      do i = 1, POSITION_LEN
         if (b(i) /= SPACE) str_b(i:i) = b(i)
      end do
      str_b = trim(str_b)
      
      allocate(rank_strings(size(positions_rank, 1)))
      do i = 1, size(positions_rank, 1)
         rank_strings(i) = ""
         do pos_a = 1, POSITION_LEN  
            if (positions_rank(i, pos_a) /= SPACE) then
               rank_strings(i)(pos_a:pos_a) = positions_rank(i, pos_a)
            end if
         end do
         rank_strings(i) = trim(rank_strings(i))
      end do
      
      pos_a = findloc(rank_strings, str_a, dim=1)
      pos_b = findloc(rank_strings, str_b, dim=1)
      
      if (pos_a == 0 .or. pos_b == 0) then
         res = .false.
      else
         res = pos_a < pos_b
      end if
   end function PositionLess
   
   !Сортировка чёт-нечет 
   subroutine SortEmpl(surnames, positions, positions_rank)
      character(kind=CH_), intent(inout) :: surnames(:, :), positions(:, :)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      
      integer :: n, j, k
      logical :: sorted
      character(kind=CH_) :: tmp_s(SURNAME_LEN), tmp_p(POSITION_LEN)
      
      n = size(surnames, 1)
      sorted = .false.
    
      do while (.not. sorted)
         sorted = .true.
         
         !Четная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(positions(j+1, :), positions(j, :), positions_rank)) then
               ! Обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(j, k)
                  surnames(j, k) = surnames(j+1, k)
                  surnames(j+1, k) = tmp_s(k)
               end do
               
               ! Обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(j, k)
                  positions(j, k) = positions(j+1, k)
                  positions(j+1, k) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !Нечетная фаза
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(positions(j+1, :), positions(j, :), positions_rank)) then
               ! Обмен фамилиями
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(j, k)
                  surnames(j, k) = surnames(j+1, k)
                  surnames(j+1, k) = tmp_s(k)
               end do
               
               ! Обмен должностями
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(j, k)
                  positions(j, k) = positions(j+1, k)
                  positions(j+1, k) = tmp_p(k)
               end do
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine SortEmpl
   
end module Sorting
