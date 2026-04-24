program main
   use Sorting
   use Environment
   use Order_io
   use omp_lib
   implicit none

   character(kind=CH_) :: surnames(SURNAME_LEN, EMPL_AMOUNT)       
   character(kind=CH_) :: positions(POSITION_LEN, EMPL_AMOUNT)    
   character(kind=CH_) :: positions_rank(POSITION_LEN, POS_AMOUNT)
   character(:), allocatable :: input_file, output_file, pos_file
   real(8) :: start_time, end_time
   
   input_file = "../data/input_file.txt"
   output_file = "output.txt"
   pos_file = "../data/positions.txt"

   print *, "     СОРТИРОВКА СОТРУДНИКОВ"

   call ReadPositions(pos_file, positions_rank)
   print *, "      Прочитано должностей: ", POS_AMOUNT

   call ReadEmpl(input_file, surnames, positions)
   print *, "      Прочитано сотрудников: ", EMPL_AMOUNT
   print *, ""

   call WriteEmpl(output_file, surnames, positions, "ИСХОДНЫЙ СПИСОК:", "rewind")

   start_time = omp_get_wtime()
   call SortEmpl(surnames, positions, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   call WriteEmpl(output_file, surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")

end program main
