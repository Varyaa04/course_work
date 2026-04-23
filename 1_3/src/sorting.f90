module Sorting
   use Environment
   use Order_io
   implicit none

contains

   !функция сравнения должностей
   pure function PositionLess(pos_a, pos_b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos_a, pos_b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank_a, rank_b

      rank_a = findloc(positions_rank, pos_a, dim=1)
      rank_b = findloc(positions_rank, pos_b, dim=1)

      if (rank_a == 0 .or. rank_b == 0) then
         res = .false.
      else
         res = rank_a < rank_b
      end if
   end function PositionLess

   !cортировка чёт-нечет 
   subroutine SortEmployees(employees, positions_rank)
      type(employee), intent(inout) :: employees(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer :: n, j
      type(employee) :: tmp
      logical :: sorted

      n = size(employees)
      sorted = .false.

      do while (.not. sorted)
         sorted = .true.

         !чётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(employees(j+1)%position, employees(j)%position, positions_rank)) then
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do

         !нечётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(employees(j+1)%position, employees(j)%position, positions_rank)) then
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do
      end do
   end subroutine SortEmployees

end module Sorting