module Sorting
   use Environment
   use Order_IO
   implicit none

contains

   function Position_less(pos_a, pos_b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos_a, pos_b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: i, ra, rb

      ra = 0
      rb = 0

      do i = 1, size(positions_rank)
         if (positions_rank(i) == pos_a) ra = i
         if (positions_rank(i) == pos_b) rb = i
      end do

      if (ra == 0 .or. rb == 0) then
         res = .false.
      else
         res = ra > rb
      end if
   end function Position_less

   ! Рекурсивный проход сортировки (как Sort_pass в вашем коде)
   recursive subroutine Sort_pass(employees, positions_rank, swapped)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical, intent(inout) :: swapped
      
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      
      if (.not. allocated(employees)) return
      if (.not. allocated(employees%next)) return
      
      ! Меняем местами, если нужно
      if (Position_less(employees%position, employees%next%position, positions_rank)) then
         tmp_surname = employees%surname
         tmp_position = employees%position
         
         employees%surname = employees%next%surname
         employees%position = employees%next%position
         
         employees%next%surname = tmp_surname
         employees%next%position = tmp_position
         
         swapped = .true.
      end if
      
      ! Рекурсивный вызов для следующей пары
      call Sort_pass(employees%next, positions_rank, swapped)
   end subroutine Sort_pass

   ! Рекурсивная внешняя сортировка
   recursive subroutine Sort_employee_list_tail(employees, positions_rank, swapped)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical, intent(in) :: swapped
      
      logical :: new_swapped
      
      if (.not. swapped) return
      
      new_swapped = .false.
      call Sort_pass(employees, positions_rank, new_swapped)
      
      ! Рекурсивный вызов
      call Sort_employee_list_tail(employees, positions_rank, new_swapped)
   end subroutine Sort_employee_list_tail

   ! Вызов из main
   subroutine Sort_employee_list(employees, positions_rank)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      call Sort_employee_list_tail(employees, positions_rank, .true.)
   end subroutine Sort_employee_list

end module Sorting