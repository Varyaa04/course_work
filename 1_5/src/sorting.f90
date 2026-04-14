module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   ! Сортировка списка сотрудников по рангу должности РЕКУРСИВНО методом пузырька
   pure recursive subroutine Sort_employee_list(employees, positions_rank, N)
      type(employees_data), intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: N
      
      ! Работаем только с первыми N элементами: помещаем в их конец менее приоритетного
      call Drop_down(employees, positions_rank, 1, N-1)
      
      ! Если необходимо, делаем то же с последними N-1 элементами
      if (N >= 3) &
         call Sort_employee_list(employees, positions_rank, N-1)
   end subroutine Sort_employee_list
   
   ! Помещаем с j-ой на N-ую позицию менее приоритетного, поочерёдно сравнивая
   pure recursive subroutine Drop_down(employees, positions_rank, j, N)
      type(employees_data), intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: j, N
      
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      
      ! Если требуется, то меняем местами текущего сотрудника со следующим
      if (Need_swap(employees, positions_rank, j)) then
         ! Обмен фамилиями
         tmp_surname = employees%surnames(j+1)
         employees%surnames(j+1) = employees%surnames(j)
         employees%surnames(j) = tmp_surname
         
         ! Обмен должностями
         tmp_position = employees%positions(j+1)
         employees%positions(j+1) = employees%positions(j)
         employees%positions(j) = tmp_position
      end if
      
      if (j < N) &
         call Drop_down(employees, positions_rank, j+1, N)
   end subroutine Drop_down
   
   ! Проверка, нужно ли менять местами сотрудников
   pure logical function Need_swap(employees, positions_rank, j)
      type(employees_data), intent(in) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: j
      
      integer :: rank_j, rank_j1
      
      rank_j  = findloc(positions_rank, trim(employees%positions(j)), dim=1)
      rank_j1 = findloc(positions_rank, trim(employees%positions(j+1)), dim=1)
      
      ! Меняем, если должность j+1 имеет БОЛЕЕ ВЫСОКИЙ ранг (меньший номер)
      Need_swap = rank_j > rank_j1
   end function Need_swap
   
end module Sorting
