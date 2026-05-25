module Sorting
   use Environment
   use Order_IO
   implicit none
   
contains
   
   !сравнение должностей 
   pure function Position_less(pos1, pos2, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos1, pos2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank1, rank2
      
      rank1 = get_rank(pos1, positions_rank)
      rank2 = get_rank(pos2, positions_rank)
      
      if (rank1 == 0 .or. rank2 == 0) then
         res = .false.
      else
         res = rank1 > rank2  
      end if
      
   contains
      !внутренняя чистая функция для получения ранга
      pure function get_rank(position, rank_array) result(r)
         character(POSITION_LEN, kind=CH_), intent(in) :: position
         character(POSITION_LEN, kind=CH_), intent(in) :: rank_array(:)
         integer :: r, i
         
         r = 0
         do i = 1, size(rank_array)
            if (rank_array(i) == position) then
               r = i
               exit
            end if
         end do
      end function get_rank
      
   end function Position_less
   
   !чет-нечет сортировка 
   recursive subroutine Sort_employee_list(employees, positions_rank, n)
      type(employee), allocatable, intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: n
      
      logical :: sorted
      
      if (n <= 1) return
      
      sorted = .true.
      
      !чётная фаза
      call Odd_phase(employees, positions_rank, 1, n, sorted)
      
      !нечётная фаза
      if (allocated(employees%next)) then
         call Even_phase(employees%next, positions_rank, 2, n, sorted)
      end if
      
      !хвостовая рекурсия
      if (.not. sorted) then
         call Sort_employee_list(employees, positions_rank, n)
      end if
   end subroutine Sort_employee_list
   
   !чётная фаза
   recursive subroutine Odd_phase(current, positions_rank, pos, n, sorted)
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
         call Odd_phase(current%next%next, positions_rank, pos + 2, n, sorted)
      end if
   end subroutine Odd_phase
   
   !нечётная фаза
   recursive subroutine Even_phase(current, positions_rank, pos, n, sorted)
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
         call Even_phase(current%next%next, positions_rank, pos + 2, n, sorted)
      end if
   end subroutine Even_phase
   
   !обмен данными между узлами 
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