module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   !сортировка чёт-нечет
   pure subroutine Sort_employee_list(employees, positions_rank)
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
         do j = 1, n-1, 2
            if (Need_swap(employees(j), employees(j+1), positions_rank)) then
               !обмен
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         
         !нечётная фаза 
         do j = 2, n-1, 2
            if (Need_swap(employees(j), employees(j+1), positions_rank)) then
               !обмен
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         
      end do
      
   end subroutine Sort_employee_list
   
   !проверка, нужно ли менять местами сотрудников
   pure logical function Need_swap(emp1, emp2, positions_rank)
      type(employee), intent(in) :: emp1, emp2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: rank1, rank2
      
      rank1 = findloc(positions_rank, trim(emp1%position), dim=1)
      rank2 = findloc(positions_rank, trim(emp2%position), dim=1)
      
      !меняем, если ранг первого больше ранга второго 
      Need_swap = rank1 > rank2
   end function Need_swap
   
end module Sorting
