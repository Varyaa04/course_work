program main
   use Sorting
   use Environment
   use omp_lib
   use Order_io
   implicit none
   
   character(SURNAME_LEN, kind=CH_), allocatable :: surnames(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n, m
   real(8) :: start_time, end_time
   
  
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
           
   
   call ReadPositions("../data/positions.txt", positions_rank, m)
   print *, "      Прочитано должностей: ", m
   
   call ReadEmpl("../data/input_file.txt", surnames, positions, n)
   print *, "      Прочитано сотрудников: ", n
   print *, ""
 
   call WriteEmpl("output.txt", surnames, positions, "ИСХОДНЫЙ СПИСОК:")
   
   start_time = omp_get_wtime()
   call SortEmpl(surnames, positions, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   call WriteEmpl("output.txt", surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:")
  
end program main
