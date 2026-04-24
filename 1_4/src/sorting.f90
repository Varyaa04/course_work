module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   ! Сравнение должностей
   pure function PositionLess(a, b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: a, b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: ra, rb
      
      ra = findloc(positions_rank, a, dim=1)
      rb = findloc(positions_rank, b, dim=1)
      
      if (ra == 0 .or. rb == 0) then
         res = .false.
      else
         res = ra < rb
      end if
   end function PositionLess
   
   ! Сортировка массива структур по должности (чёт-нечет)
   subroutine SortEmployees(employees, positions_rank)
      type(employee), intent(inout) :: employees(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, i
      type(employee) :: tmp
      logical :: sorted
      
      n = size(employees)
      sorted = .false.
      
      do while (.not. sorted)
         sorted = .true.
         
         ! Чётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do i = 1, n-1, 2
            if (PositionLess(employees(i+1)%position, employees(i)%position, positions_rank)) then
               tmp = employees(i)
               employees(i) = employees(i+1)
               employees(i+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         ! Нечётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do i = 2, n-1, 2
            if (PositionLess(employees(i+1)%position, employees(i)%position, positions_rank)) then
               tmp = employees(i)
               employees(i) = employees(i+1)
               employees(i+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine SortEmployees
   
end module Sorting