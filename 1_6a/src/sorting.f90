module Sorting
   use Environment
   use Order_IO
   implicit none
   
contains
   
   !сравнение должностей 
   pure function Position_less(pos_a, pos_b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos_a, pos_b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank_a, rank_b, i
      
      !поиск для pos_a
      rank_a = 0
      do i = 1, size(positions_rank)
         if (positions_rank(i) == pos_a) then
            rank_a = i
            exit
         end if
      end do
      
      !поиск для pos_b
      rank_b = 0
      do i = 1, size(positions_rank)
         if (positions_rank(i) == pos_b) then
            rank_b = i
            exit
         end if
      end do
      
      if (rank_a == 0 .or. rank_b == 0) then
         res = .false.
      else
         res = rank_a > rank_b
      end if
   end function Position_less
   
   !чет-нечет сортировка 
   recursive subroutine Sort_employee_list(employees, positions_rank)
      type(employee), pointer, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      logical :: sorted
      type(employee), pointer :: current
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      
      if (.not. associated(employees)) return
      if (.not. associated(employees%next)) return
      
      sorted = .true.
      
      !четная фаза
      current => employees
      do while (associated(current) .and. associated(current%next))
         if (Position_less(current%position, current%next%position, positions_rank)) then
            !обмен данными
            tmp_surname = current%surname
            tmp_position = current%position
            
            current%surname = current%next%surname
            current%position = current%next%position
            
            current%next%surname = tmp_surname
            current%next%position = tmp_position
            
            sorted = .false.
         end if
         if (associated(current%next%next)) then
            current => current%next%next
         else
            exit
         end if
      end do
      
      !нечетная фаза
      if (associated(employees%next)) then
         current => employees%next
         do while (associated(current) .and. associated(current%next))
            if (Position_less(current%position, current%next%position, positions_rank)) then
               !обмен данными
               tmp_surname = current%surname
               tmp_position = current%position
               
               current%surname = current%next%surname
               current%position = current%next%position
               
               current%next%surname = tmp_surname
               current%next%position = tmp_position
               
               sorted = .false.
            end if
            if (associated(current%next%next)) then
               current => current%next%next
            else
               exit
            end if
         end do
      end if
      
      !хвостовая рекурсия
      if (.not. sorted) then
         call Sort_employee_list(employees, positions_rank)
      end if
      
   end subroutine Sort_employee_list
   
end module Sorting