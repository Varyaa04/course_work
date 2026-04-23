module Sorting
   use Environment
   use Order_io
   implicit none
   
contains
   
   !Сортировка структуры массивов по должности
    subroutine Sort_employees(employees, positions_rank)
      type(employees_data), intent(inout) :: employees
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      
      integer :: n, j, k
      character(SURNAME_LEN, kind=CH_) :: tmp_surname
      character(POSITION_LEN, kind=CH_) :: tmp_position
      logical :: sorted
      
      n = size(employees%surnames)
      sorted = .false.
      
      do while (.not. sorted)
         sorted = .true.
         
         !Четная фаза
         !$omp parallel do private(tmp_surname, tmp_position) reduction(.and.:sorted)
         do j = 1, n-1, 2
            if (PositionLess(employees%positions(j+1), employees%positions(j), positions_rank)) then
               ! Обмен фамилиями
               tmp_surname = employees%surnames(j)
               employees%surnames(j) = employees%surnames(j+1)
               employees%surnames(j+1) = tmp_surname
               
               ! Обмен должностями
               tmp_position = employees%positions(j)
               employees%positions(j) = employees%positions(j+1)
               employees%positions(j+1) = tmp_position
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
         !Нечетная фаза
         !$omp parallel do private(tmp_surname, tmp_position) reduction(.and.:sorted)
         do j = 2, n-1, 2
            if (PositionLess(employees%positions(j+1), employees%positions(j), positions_rank)) then
               !Обмен фамилиями
               tmp_surname = employees%surnames(j)
               employees%surnames(j) = employees%surnames(j+1)
               employees%surnames(j+1) = tmp_surname
               
               !Обмен должностями
               tmp_position = employees%positions(j)
               employees%positions(j) = employees%positions(j+1)
               employees%positions(j+1) = tmp_position
               
               sorted = .false.
            end if
         end do
         !$omp end parallel do
         
      end do
      
   end subroutine Sort_employees
   
   !Сравнение должностей
   pure function PositionLess(a, b, positions_rank) result(res)
      character(POSITION_LEN, kind=CH_), intent(in) :: a, b
      character(POSITION_LEN, kind=CH_), intent(in) :: positions_rank(:)
      logical :: res
      integer :: ra, rb
      
      ra = findloc(positions_rank, a, dim=1)
      rb = findloc(positions_rank, b, dim=1)
      
      if (ra == 0 .or. rb == 0) then
         res = .false.
      else
         res = ra < rb
      end if
   end function PositionLess
   
end module Sorting
