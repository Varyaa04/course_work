module Sorting
   use Environment
   use Order_io, only: employee, POSITION_LEN, SURNAME_LEN
   implicit none
   
contains
   
   ! Сортировка списка сотрудников по рангу должности рекурсивно методом пузырька
   recursive subroutine Sort_employee_list(employees, positions_rank, N)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: N
      
      ! Работаем только с первыми N элементами: помещаем в их конец менее приоритетного
      call Drop_down(employees, positions_rank, 1, N-1)
      
      ! Если необходимо, делаем то же с первыми N-1 элементами
      if (N >= 3) &
         call Sort_employee_list(employees, positions_rank, N-1)
   end subroutine Sort_employee_list
   
   ! Помещаем с j-ой на N-ую позицию менее приоритетного, поочерёдно сравнивая
   recursive subroutine Drop_down(employees, positions_rank, j, N)
      type(employee), pointer :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: j, N
      
      ! Если требуется, то меняем местами текущего сотрудника со следующим
      if (Need_swap(employees, positions_rank)) then
         call Swap_from_current(employees)
      end if
      
      if (j < N) &
         call Drop_down(employees%next, positions_rank, j+1, N)
   end subroutine Drop_down
   
   ! Проверка, нужно ли менять местами текущего сотрудника со следующим
   pure function Need_swap(current, positions_rank) result(swap_needed)
      type(employee), intent(in) :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: swap_needed
      
      integer :: rank_current, rank_next
      
      rank_current = findloc(positions_rank, current%position, dim=1)
      rank_next    = findloc(positions_rank, current%next%position, dim=1)
      
      ! Меняем, если следующий сотрудник имеет БОЛЕЕ ВЫСОКИЙ ранг (меньший номер)
      swap_needed = rank_current > rank_next
   end function Need_swap
   
   ! Перестановка местами двух элементов списка, начиная с текущего
   subroutine Swap_from_current(current)
      type(employee), pointer :: current
      
      type(employee), pointer :: tmp_emp
      
      ! Перестановка: current и current%next меняются местами
      tmp_emp       => current%next
      current%next  => current%next%next
      tmp_emp%next  => current
      current       => tmp_emp
   end subroutine Swap_from_current
   
end module Sorting
