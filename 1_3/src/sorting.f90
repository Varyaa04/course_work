module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   !cортировка списка сотрудников по рангу должности
   pure subroutine Sort_employee_list(employees, positions_rank)
      type(employee), intent(inout) :: employees(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: i, j
      type(employee) :: tmp_emp
      
      !cортировка чёт-нечет
      do i = size(employees), 2, -1
         do j = 1, i-1
            if (Need_swap(employees, j, positions_rank)) then
               tmp_emp = employees(j+1)
               employees(j+1) = employees(j)
               employees(j) = tmp_emp
            end if
         end do
      end do
   end subroutine Sort_employee_list
   
   !проверка, нужно ли менять местами сотрудников
   pure logical function Need_swap(employees, j, positions_rank)
      type(employee), intent(in) :: employees(:)
      integer, intent(in) :: j
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: rank_j, rank_j1
      
      rank_j  = findloc(positions_rank, trim(employees(j)%position), dim=1)
      rank_j1 = findloc(positions_rank, trim(employees(j+1)%position), dim=1)
      
      Need_swap = rank_j > rank_j1
   end function Need_swap
   
end module Sorting
