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
      
      do j = 1, size(positions_rank, 2)
         if (all(positions_rank(:, j) == a)) then
            pos_a = j
            exit
         end if
      end do
      
      do j = 1, size(positions_rank, 2)
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
   
   subroutine SortEmpl(surnames, positions, positions_rank)
      character(kind=CH_), allocatable, intent(inout) :: surnames(:, :), positions(:, :)
      character(kind=CH_), intent(in) :: positions_rank(:, :)
      
      integer :: n, j, k
      logical :: sorted
      character(kind=CH_), allocatable :: tmp_s(:), tmp_p(:)
      
      n = size(surnames, 2)
      
      !выравнивание 
      !!$omp allocate(tmp_s) align(64)
      allocate(tmp_s(SURNAME_LEN))
      !!$omp allocate(tmp_p) align(64)
      allocate(tmp_p(POSITION_LEN))
      
      sorted = .false.
   
      do while (.not. sorted)
         sorted = .true.
         
         !чётная фаза 
         !$omp parallel do reduction(.and.:sorted) &
         !$omp shared(surnames, positions, positions_rank)
         do j = 1, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !обмен фамилиями 
               !$omp simd aligned(surnames, tmp_s:32)
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               !$omp end simd

               !обмен должностями 
               !$omp simd aligned(positions, tmp_p:32)
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
         !$omp parallel do reduction(.and.:sorted) &
         !$omp shared(surnames, positions, positions_rank)
         do j = 2, n-1, 2
            if (PositionLess(positions(:, j+1), positions(:, j), positions_rank)) then
               !обмен фамилиями 
               !$omp simd aligned(surnames, tmp_s:32)
               do k = 1, SURNAME_LEN
                  tmp_s(k) = surnames(k, j)
                  surnames(k, j) = surnames(k, j+1)
                  surnames(k, j+1) = tmp_s(k)
               end do
               !$omp end simd

               !обмен должностями 
               !$omp simd aligned(positions, tmp_p:32)
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
      
      deallocate(tmp_s, tmp_p)

   end subroutine SortEmpl
   
end module Sorting
