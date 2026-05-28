module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   !сравнение должностей
   pure function PositionLess(pos_a, pos_b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: pos_a, pos_b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: rank_a, rank_b
      
      rank_a = findloc(positions_rank, pos_a, dim=1)
      rank_b = findloc(positions_rank, pos_b, dim=1)
      
      res = (rank_a /= 0 .and. rank_b /= 0 .and. rank_a < rank_b)
   end function PositionLess
   
   !cортировка чет-нечет
   subroutine SortEmployees(employees, positions_rank)
      type(employees_soa), intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, i
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      logical :: sorted
      
      n = EMPL_AMOUNT
      sorted = .false.
      
      do while (.not. sorted)
         sorted = .true.
         
         !четная фаза 
         !$omp parallel do reduction(.and.:sorted)
         do i = 1, n-1, 2
            if (PositionLess(employees%positions(i+1), employees%positions(i), positions_rank)) then
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
         !$omp parallel do  reduction(.and.:sorted)
         do i = 2, n-1, 2
            if (PositionLess(employees%positions(i+1), employees%positions(i), positions_rank)) then
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
         
      end do
      
   end subroutine SortEmployees
   
end module Sorting
