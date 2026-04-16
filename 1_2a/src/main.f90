program main
   use Sorting
   use Environment
   use omp_lib
   use Order_io
   implicit none
   
   character(kind=CH_), allocatable :: surnames(:, :), positions(:, :)
   character(kind=CH_), allocatable :: positions_rank(:, :)
   integer :: n, m
   real(8) :: start_time, end_time
   character(:), allocatable :: input_file, output_file, pos_file

   input_file = "../data/input_file.txt"
   output_file = "output.txt"
   pos_file = "../data/positions.txt"

   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
          
   call ReadPositions(pos_file, positions_rank, m)
   print *, "      Прочитано должностей: ", m
   
   call ReadEmpl(input_file, surnames, positions, n)
   print *, "      Прочитано сотрудников: ", n
   print *, ""
 
   call WriteEmpl(output_file, surnames, positions, "ИСХОДНЫЙ СПИСОК:")
   
   start_time = omp_get_wtime()
   call SortEmpl(surnames, positions, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   

   call WriteEmpl(output_file, surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:")
   
end program main
