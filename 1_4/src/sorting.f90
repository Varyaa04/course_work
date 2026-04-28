module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   ! сравнение должностей
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
         res = rank_a < rank_b
      end if
   end function Position_less
   
   ! сортировка чёт-нечет для структуры массивов
   subroutine Sort_employees(employees, positions_rank)
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
         
         ! чётная фаза
         !$omp parallel do private(tmp_surname, tmp_position) reduction(.and.:sorted)
         do i = 1, n-1, 2
            if (Position_less(employees%positions(i+1), employees%positions(i), positions_rank)) then
               ! меняем местами фамилии
               tmp_surname = employees%surnames(i)
               employees%surnames(i) = employees%surnames(i+1)
               employees%surnames(i+1) = tmp_surname
               
               ! меняем местами должности
               tmp_position = employees%positions(i)
               employees%positions(i) = employees%positions(i+1)
               employees%positions(i+1) = tmp_position
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         ! нечётная фаза
         !$omp parallel do private(tmp_surname, tmp_position) reduction(.and.:sorted)
         do i = 2, n-1, 2
            if (Position_less(employees%positions(i+1), employees%positions(i), positions_rank)) then
               ! меняем местами фамилии
               tmp_surname = employees%surnames(i)
               employees%surnames(i) = employees%surnames(i+1)
               employees%surnames(i+1) = tmp_surname
               
               ! меняем местами должности
               tmp_position = employees%positions(i)
               employees%positions(i) = employees%positions(i+1)
               employees%positions(i+1) = tmp_position
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine Sort_employees
   
end module Sorting