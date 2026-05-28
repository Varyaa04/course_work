program main
   use Sorting
   use Environment
   use Order_io
   use omp_lib
   implicit none
   
   character(kind=CH_), allocatable :: surnames(:, :), positions(:, :), positions_rank(:, :)
   character(:), allocatable :: input_file, output_file, pos_file
   real(8) :: start_time, end_time
   integer :: out_unit = 10, i
   
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

   
   call WriteEmpl(output_file, surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
   open(unit=out_unit, file=output_file, position='append', status='old', action='write')
   write(out_unit, '(/a)') repeat('=', 50)
   write(out_unit, '(a, f10.6, a)') " Время сортировки: ", end_time - start_time, " секунд"
   write(out_unit, '(a)') repeat('=', 50)
   close(out_unit)

   deallocate(surnames, positions, positions_rank)

end program main