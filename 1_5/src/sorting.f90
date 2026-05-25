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
      integer :: rank_a, rank_b
      
      rank_a = findloc(positions_rank, pos_a, dim=1)
      rank_b = findloc(positions_rank, pos_b, dim=1)
      
      if (rank_a == 0 .or. rank_b == 0) then
         res = .false.
      else
         res = rank_a > rank_b  
      end if
   end function Position_less
   
   !сортировка чет-нечет 
   recursive subroutine Sort_employees(employees, positions_rank, n)
      type(employees_soa), intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      integer, intent(in) :: n
      
      integer :: i
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      logical :: sorted
      
      if (n <= 1) return
      
      sorted = .true.
      
      !четная фаза
      !$omp parallel do reduction(.and.:sorted) private(tmp_surname, tmp_position)
      do i = 1, n-1, 2
         if (Position_less(employees%positions(i), employees%positions(i+1), positions_rank)) then
            !обмен фамилий
            tmp_surname = employees%surnames(i)
            employees%surnames(i) = employees%surnames(i+1)
            employees%surnames(i+1) = tmp_surname
            
            !обмен должностей
            tmp_position = employees%positions(i)
            employees%positions(i) = employees%positions(i+1)
            employees%positions(i+1) = tmp_position
            
            sorted = .false.
         end if
      end do
      !$omp end parallel do
      
      !нечетная фаза
      !$omp parallel do reduction(.and.:sorted) private(tmp_surname, tmp_position)
      do i = 2, n-1, 2
         if (Position_less(employees%positions(i), employees%positions(i+1), positions_rank)) then
            !обмен фамилий
            tmp_surname = employees%surnames(i)
            employees%surnames(i) = employees%surnames(i+1)
            employees%surnames(i+1) = tmp_surname
            
            !обмен должностей
            tmp_position = employees%positions(i)
            employees%positions(i) = employees%positions(i+1)
            employees%positions(i+1) = tmp_position
            
            sorted = .false.
         end if
      end do
      !$omp end parallel do 
      
      !хвостовая рекурсия
      if (.not. sorted) then
         call Sort_employees(employees, positions_rank, n)
      end if
   end subroutine Sort_employees
   
end module Sorting