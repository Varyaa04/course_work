module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   ! Логическая функция сравнения двух должностей
   ! Возвращает .true., если pos1 выше по рангу (имеет меньший индекс в массиве)
   pure function Is_position_higher(pos1, pos2, positions_rank) result(higher)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos1, pos2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: higher
      
      integer :: rank1, rank2
      
      rank1 = findloc(positions_rank, trim(pos1), dim=1)
      rank2 = findloc(positions_rank, trim(pos2), dim=1)
      
      ! Если должность не найдена, считаем её низшей
      if (rank1 == 0) rank1 = huge(1)
      if (rank2 == 0) rank2 = huge(1)
      
      higher = rank1 < rank2
   end function Is_position_higher
   
   ! Логическая функция проверки необходимости обмена
   pure function Need_swap(current, positions_rank) result(swap_needed)
      type(employee), intent(in) :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: swap_needed
      
      ! Меняем, если следующий сотрудник имеет БОЛЕЕ ВЫСОКИЙ ранг
      swap_needed = Is_position_higher(current%next%position, current%position, positions_rank)
   end function Need_swap
   
   ! Сортировка списка сотрудников по рангу должности (хвостовая рекурсия)
   recursive subroutine Sort_employee_list(employees, positions_rank, N)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: N
      
      ! Работаем только с первыми N элементами: помещаем в их конец менее приоритетного
      call Drop_down(employees, positions_rank, 1, N-1)
      
      ! Если необходимо, делаем то же с первыми N-1 элементами (хвостовая рекурсия)
      if (N >= 3) &
         call Sort_employee_list(employees, positions_rank, N-1)
   end subroutine Sort_employee_list
   
   ! Помещаем с j-ой на N-ую позицию менее приоритетного (хвостовая рекурсия)
   recursive subroutine Drop_down(employees, positions_rank, j, N)
      type(employee), pointer :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: j, N
      
      ! Если требуется, то меняем местами текущего сотрудника со следующим
      if (Associated(employees%next)) then
         if (Need_swap(employees, positions_rank)) then
            call Swap_from_current(employees)
         end if
      end if
      
      ! Хвостовая рекурсия - переход к следующему элементу
      if (j < N) &
         call Drop_down(employees%next, positions_rank, j+1, N)
   end subroutine Drop_down
   
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
