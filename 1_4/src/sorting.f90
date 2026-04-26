module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   !cравнение должностей
   pure function Position_less(a, b, positions_rank) result(res)
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
   end function Position_less
   
   !cортировка чёт-нечет 
   subroutine Sort_employees(employees, positions_rank)
      type(employee), intent(inout) :: employees(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, i
      type(employee) :: tmp
      logical :: sorted
      
      n = size(employees)
      sorted = .false.
      
      do while (.not. sorted)
         sorted = .true.
         
         !чётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do i = 1, n-1, 2
            if (Position_less(employees(i+1)%position, employees(i)%position, positions_rank)) then
               tmp = employees(i)
               employees(i) = employees(i+1)
               employees(i+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !нечётная фаза
         !$omp parallel do private(tmp) reduction(.and.:sorted)
         do i = 2, n-1, 2
            if (Position_less(employees(i+1)%position, employees(i)%position, positions_rank)) then
               tmp = employees(i)
               employees(i) = employees(i+1)
               employees(i+1) = tmp
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine Sort_employees
   
end module Sorting
