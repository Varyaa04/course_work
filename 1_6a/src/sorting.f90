module Sorting
   use Environment
   use Order_io
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


   !переставляет местами узлы cur и nxt через ссылки:
   subroutine Swap_links(prev, employees, cur, nxt)
      type(employee), pointer, intent(inout) :: prev
      type(employee), pointer, intent(inout) :: employees
      type(employee), pointer, intent(inout) :: cur, nxt

      cur%next => nxt%next
      nxt%next => cur

      if (associated(prev)) then
         prev%next => nxt
      else
         employees => nxt
      end if
   end subroutine Swap_links

   !сортировка чет-нечет один проход
   subroutine Sort_pass(employees, positions_rank, swapped)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical, intent(out) :: swapped

      type(employee), pointer :: prev
      type(employee), pointer :: cur
      type(employee), pointer :: nxt

      swapped = .false.

      !четная фаза
      nullify(prev)
      cur => employees
      do while (associated(cur))

         nxt => cur%next
         if(.not. associated(nxt)) exit
         
         if (Position_less(cur%position, nxt%position, positions_rank)) then
            !обмен через ссылки, без копирования полей
            call Swap_links(prev, employees, cur, nxt)
            swapped = .true.
            prev => nxt
            !cur остаётся тем же узлом, теперь он идёт следом за nxt
         else
            prev => cur
            cur => nxt
         end if
      end do


      !нечетная фаза
      if (.not. associated(employees%next)) return
      prev => employees
      cur => employees%next
      do while (associated(cur))

         nxt => cur%next
         if(.not. associated(nxt)) exit

         if (Position_less(cur%position, nxt%position, positions_rank)) then
            !обмен через ссылки, без копирования полей
            call Swap_links(prev, employees, cur, nxt)
            swapped = .true.
            prev => nxt
         else
            prev => cur
            cur => nxt
         end if
      end do

   end subroutine Sort_pass

   !рекурсивная функция сортировки
   recursive subroutine Sort_employee_list_tail(employees, positions_rank, swapped)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical, intent(in) :: swapped

      logical :: new_swapped

      if (.not. swapped) return

      call Sort_pass(employees, positions_rank, new_swapped)

      call Sort_employee_list_tail(employees, positions_rank, new_swapped)

   end subroutine Sort_employee_list_tail

   !вызов в main
   subroutine Sort_employee_list(employees, positions_rank)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)

      call Sort_employee_list_tail(employees, positions_rank, .true.)

   end subroutine Sort_employee_list

end module Sorting