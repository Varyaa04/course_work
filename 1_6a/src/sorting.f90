module Sorting
   use Environment
   use Order_IO
   implicit none
   
contains
   
   ! Сравнение должностей согласно рангу
   pure function Position_less(a, b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: a, b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: ra, rb
      
      ra = Get_position_rank(a, positions_rank)
      rb = Get_position_rank(b, positions_rank)
      
      if (ra == 0 .or. rb == 0) then
         res = .false.
      else
         res = ra > rb
      end if
   end function Position_less
   
   ! ЧЁТ-НЕЧЕТ СОРТИРОВКА для однонаправленного списка
   recursive subroutine Sort_employee_list(employees, positions_rank)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      logical :: sorted
      integer :: i
      
      if (.not. Associated(employees)) return
      if (.not. Associated(employees%next)) return
      
      sorted = .true.
      
      ! ЧЁТНАЯ ФАЗА: сравниваем пары (1,2), (3,4), (5,6)...
      call Odd_phase(employees, positions_rank, 1, sorted)
      
      ! НЕЧЁТНАЯ ФАЗА: сравниваем пары (2,3), (4,5), (6,7)...
      if (Associated(employees%next)) then
         call Even_phase(employees%next, positions_rank, 2, sorted)
      end if
      
      ! ХВОСТОВАЯ РЕКУРСИЯ
      if (.not. sorted) then
         call Sort_employee_list(employees, positions_rank)
      end if
   end subroutine Sort_employee_list
   
   ! ЧЁТНАЯ ФАЗА: обход с шагом 2, начиная с позиции 1
   recursive subroutine Odd_phase(current, positions_rank, pos, sorted)
      type(employee), pointer :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: pos
      logical, intent(inout) :: sorted
      
      if (.not. Associated(current)) return
      if (.not. Associated(current%next)) return
      if (pos >= EMPL_AMOUNT) return
      
      ! Сравниваем и меняем данные (не указатели!)
      if (Position_less(current%position, current%next%position, positions_rank)) then
         call Swap_data(current, current%next)
         sorted = .false.
      end if
      
      ! Переходим к следующей паре (через один узел)
      if (Associated(current%next%next)) then
         call Odd_phase(current%next%next, positions_rank, pos + 2, sorted)
      end if
   end subroutine Odd_phase
   
   ! НЕЧЁТНАЯ ФАЗА: обход с шагом 2, начиная с позиции 2
   recursive subroutine Even_phase(current, positions_rank, pos, sorted)
      type(employee), pointer :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: pos
      logical, intent(inout) :: sorted
      
      if (.not. Associated(current)) return
      if (.not. Associated(current%next)) return
      if (pos >= EMPL_AMOUNT) return
      
      ! Сравниваем и меняем данные (не указатели!)
      if (Position_less(current%position, current%next%position, positions_rank)) then
         call Swap_data(current, current%next)
         sorted = .false.
      end if
      
      ! Переходим к следующей паре (через один узел)
      if (Associated(current%next%next)) then
         call Even_phase(current%next%next, positions_rank, pos + 2, sorted)
      end if
   end subroutine Even_phase
   
   ! Обмен данными между двумя узлами (меняем содержимое, а не указатели)
   pure subroutine Swap_data(node1, node2)
      type(employee), intent(inout) :: node1, node2
      
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      
      tmp_surname = node1%surname
      tmp_position = node1%position
      
      node1%surname = node2%surname
      node1%position = node2%position
      
      node2%surname = tmp_surname
      node2%position = tmp_position
   end subroutine Swap_data
   
end module Sorting