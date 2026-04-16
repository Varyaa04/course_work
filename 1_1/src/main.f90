program main
   use Sorting
   use Environment
   use omp_lib
   use Order_io
   implicit none

   character(SURNAME_LEN, kind=CH_), allocatable :: surnames(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   character(:), allocatable :: input_file, output_file, pos_file
   real(8) :: start_time, end_time
!!!rewind and append add 
   input_file = "../data/input_file.txt"
   output_file = "output.txt"
   pos_file = "../data/positions.txt"

   print *, "     СОРТИРОВКА СОТРУДНИКОВ"

   call ReadPositions(pos_file, positions_rank)
   print *, "      Прочитано должностей: ", size(positions_rank)

   call ReadEmpl(input_file, surnames, positions)
   print *, "      Прочитано сотрудников: ", size(surnames)
   print *, ""

   call WriteEmpl(output_file, surnames, positions, "ИСХОДНЫЙ СПИСОК:")

   start_time = omp_get_wtime()
   call SortEmpl(surnames, positions, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""

   call WriteEmpl(output_file, surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:")

end program main
