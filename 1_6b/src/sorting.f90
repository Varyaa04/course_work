module Sorting
   use Environment
   use Order_IO
   implicit none
   
contains
   
   ! Сравнение должностей
   pure function Position_less(pos1, pos2, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos1, pos2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank1, rank2
      
      rank1 = Get_position_rank(pos1, positions_rank)
      rank2 = Get_position_rank(pos2, positions_rank)
      
      if (rank1 == 0 .or. rank2 == 0) then
         res = .false.
      else
         res = rank1 > rank2
      end if
   end function Position_less
   
   ! ЧЁТ-НЕЧЕТ СОРТИРОВКА с использованием массива структур (для OpenMP)
   recursive subroutine Sort_employee_list(employees, positions_rank, n)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: n
      
      type(employee), allocatable :: array(:)
      logical :: sorted
      integer :: i
      type(employee) :: tmp
      
      if (n <= 1) return
      
      ! Преобразуем список в массив структур
      allocate(array(n))
      call List_to_array(employees, array, 1)
      
      sorted = .true.
      
      ! ЧЁТНАЯ ФАЗА - параллельная
      !$omp parallel do private(tmp) reduction(.and.:sorted)
      do i = 1, n-1, 2
         if (Position_less(array(i)%position, array(i+1)%position, positions_rank)) then
            tmp = array(i)
            array(i) = array(i+1)
            array(i+1) = tmp
            sorted = .false.
         end if
      end do
      !$omp end parallel do
      
      ! НЕЧЁТНАЯ ФАЗА - параллельная
      !$omp parallel do private(tmp) reduction(.and.:sorted)
      do i = 2, n-1, 2
         if (Position_less(array(i)%position, array(i+1)%position, positions_rank)) then
            tmp = array(i)
            array(i) = array(i+1)
            array(i+1) = tmp
            sorted = .false.
         end if
      end do
      !$omp end parallel do
      
      ! Восстанавливаем список из массива
      call Free_employee_list(employees)
      call Array_to_list(employees, array, 1)
      
      ! ХВОСТОВАЯ РЕКУРСИЯ
      if (.not. sorted) then
         call Sort_employee_list(employees, positions_rank, n)
      end if
      
      deallocate(array)
   end subroutine Sort_employee_list
   
   ! Альтернативная версия: сортировка прямым обменом в списке (без OpenMP)
   recursive subroutine Sort_employee_list_direct(employees, positions_rank, n)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: n
      
      logical :: sorted
      
      if (n <= 1) return
      
      sorted = .true.
      
      ! ЧЁТНАЯ ФАЗА
      call Odd_phase_direct(employees, positions_rank, 1, n, sorted)
      
      ! НЕЧЁТНАЯ ФАЗА
      if (allocated(employees%next)) then
         call Even_phase_direct(employees%next, positions_rank, 2, n, sorted)
      end if
      
      ! ХВОСТОВАЯ РЕКУРСИЯ
      if (.not. sorted) then
         call Sort_employee_list_direct(employees, positions_rank, n)
      end if
   end subroutine Sort_employee_list_direct
   
   ! ЧЁТНАЯ ФАЗА (прямая работа со списком)
   recursive subroutine Odd_phase_direct(current, positions_rank, pos, n, sorted)
      type(employee), allocatable, intent(inout) :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: pos, n
      logical, intent(inout) :: sorted
      
      if (.not. allocated(current)) return
      if (.not. allocated(current%next)) return
      if (pos >= n) return
      
      if (Position_less(current%position, current%next%position, positions_rank)) then
         call Swap_data(current, current%next)
         sorted = .false.
      end if
      
      if (allocated(current%next%next)) then
         call Odd_phase_direct(current%next%next, positions_rank, pos + 2, n, sorted)
      end if
   end subroutine Odd_phase_direct
   
   ! НЕЧЁТНАЯ ФАЗА (прямая работа со списком)
   recursive subroutine Even_phase_direct(current, positions_rank, pos, n, sorted)
      type(employee), allocatable, intent(inout) :: current
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: pos, n
      logical, intent(inout) :: sorted
      
      if (.not. allocated(current)) return
      if (.not. allocated(current%next)) return
      if (pos >= n) return
      
      if (Position_less(current%position, current%next%position, positions_rank)) then
         call Swap_data(current, current%next)
         sorted = .false.
      end if
      
      if (allocated(current%next%next)) then
         call Even_phase_direct(current%next%next, positions_rank, pos + 2, n, sorted)
      end if
   end subroutine Even_phase_direct
   
   ! Обмен данными между двумя узлами
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