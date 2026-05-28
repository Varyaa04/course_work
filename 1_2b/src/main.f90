program main
   use Sorting
   use Environment
   use Order_io
   !use omp_lib
   implicit none
   
   character(kind=CH_), allocatable :: surnames(:, :), positions(:, :), positions_rank(:, :)
   character(:), allocatable :: input_file, output_file, pos_file
   integer :: start_time, end_time, rate
   integer :: out_unit = 10
   
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

   !start_time = omp_get_wtime()
   
   !call SortEmpl(surnames, positions, positions_rank)
   
   !end_time = omp_get_wtime()

   call system_clock(count_rate=rate)
   call system_clock(count=start_time)
   call SortEmpl(surnames, positions, positions_rank)
   call system_clock(count=end_time)
   call WriteEmpl(output_file, surnames, positions, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
   open(unit=out_unit, file=output_file, position='append', status='old', action='write')
   write(out_unit, '(/a)') repeat('=', 50)
   !write(out_unit, '(a, f10.6, a)') " Время сортировки: ", end_time - start_time, " секунд"
   write(out_unit, '(a, f10.6, a)') " Время сортировки: ", &
      real(end_time - start_time) / real(rate), " секунд"
   write(out_unit, '(a)') repeat('=', 50)
   close(out_unit)

   deallocate(surnames, positions, positions_rank)

end program main
