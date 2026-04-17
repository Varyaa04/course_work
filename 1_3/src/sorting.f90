module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   !сравнение должностей
   pure logical function NeedSwap(empl1, empl2, positions_rank)
      type(employee), intent(in) :: empl1, empl2
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer :: rank1, rank2
      
      rank1 = findloc(positions_rank, trim(empl1%position), dim=1)
      rank2 = findloc(positions_rank, trim(empl2%position), dim=1)
      
      if (rank1 == 0 .or. rank2 == 0) then
         NeedSwap = .false.
      else
         NeedSwap = rank1 > rank2
      end if
   end function NeedSwap
   
   !сортировка чет-нечет
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
            if (NeedSwap(employees(j), employees(j+1), positions_rank)) then
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
         
         !нечет фаза
         do j = 2, n-1, 2
            if (NeedSwap(employees(j), employees(j+1), positions_rank)) then
               tmp = employees(j)
               employees(j) = employees(j+1)
               employees(j+1) = tmp
               sorted = .false.
            end if
         end do
      end do
      
   end subroutine SortEmpl
   
end module Sorting
