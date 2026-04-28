module Sorting
   use Order_io
   use Environment
   use omp_lib
   implicit none
   
contains
  
   pure function PositionLess(a, b, positions_rank) result(res)
      character(kind=CH_), intent(in) :: a(:), b(:)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      logical :: res
      integer :: pos_a, pos_b, j
      
      pos_a = 0
      pos_b = 0
      
      ! поиск позиции для a 
      do j = 1, POS_AMOUNT
         ! positions_rank(:, j) — столбец j (должность)
         if (all(positions_rank(:, j) == a)) then
            pos_a = j
            exit
         end if
      end do
      
      ! поиск позиции для b
      do j = 1, POS_AMOUNT
         if (all(positions_rank(:, j) == b)) then
            pos_b = j
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
      
      integer :: n, j, k
      logical :: sorted
      character(kind=CH_) :: tmp_s(SURNAME_LEN), tmp_p(POSITION_LEN)
      
      ! surnames(k, j): k — буква, j — сотрудник 
      n = size(surnames, 2)  
      sorted = .false.
    
    ! ДОБАВЬТЕ ЭТОТ БЛОК ДЛЯ ДИАГНОСТИКИ:
   !$omp parallel
   !$omp single
   print *, "=== Внутри SortEmpl ==="
   print *, "Количество потоков: ", omp_get_num_threads()
   print *, "Максимум потоков:   ", omp_get_max_threads()
   print *, "======================"
   !$omp end single
   !$omp end parallel
      do while (.not. sorted)
         sorted = .true.
         
         ! Чётная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !обмен фамилиями 
               !$omp simd simdlen(32) 
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               !$omp end simd

               !обмен должностями
               !$omp simd simdlen(32) 
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(k, j)
                  positions(k, j) = positions(k, j+1)
                  positions(k, j+1) = tmp_p(k)
               end do
               !$omp end simd
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !нечётная фаза 
         !$omp parallel do private(tmp_s, tmp_p, k) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !обмен фамилиями
               !$omp simd simdlen(32) 
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               !$omp end simd

               !обмен должностями
               !$omp simd simdlen(32)   
               do k = 1, POSITION_LEN
                  tmp_p(k) = positions(k, j)
                  positions(k, j) = positions(k, j+1)
                  positions(k, j+1) = tmp_p(k)
               end do
               !$omp end simd

               sorted = .false.
            end if
         end do
         !$omp end parallel do
      end do

   end subroutine SortEmpl
   
end module Sorting
