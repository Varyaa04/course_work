module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   ! Функция сравнения должностей через findloc
   pure function PositionLess(pos1, pos2, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos1, pos2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank1, rank2
      
      rank1 = findloc(positions_rank, trim(pos1), dim=1)
      rank2 = findloc(positions_rank, trim(pos2), dim=1)
      
      if (rank1 == 0 .or. rank2 == 0) then
         res = .false.
      else
         res = rank1 > rank2  ! Меняем, если ранг первого больше
      end if
   end function PositionLess
   
   !сортировка чёт-нечет 
   pure subroutine SortEmpl(employees, positions_rank)
      type(employee), intent(inout) :: employees(:)
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, j
      type(employee) :: tmp
      logical :: sorted
      
      n = size(employees)
      sorted = .false.
      
      do while (.not. sorted)
         sorted = .true.
         
         !четная фаза
         do j = 1, n-1, 2
            if (PositionLess(employees(j)%position, employees(j+1)%position, positions_rank)) then
               !обмен местами
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         
         !нечётная фаза
         do j = 2, n-1, 2
            if (PositionLess(employees(j)%position, employees(j+1)%position, positions_rank)) then
               !обмен местами
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
      end do
      
   end subroutine SortEmpl
   
end module Sorting