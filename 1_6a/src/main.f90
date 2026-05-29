program main
   use Environment
   use Sorting
   use Order_IO
   use omp_lib
   implicit none

   character(:), allocatable :: input_file, output_file, positions_file
   type(employee), pointer :: employees => Null()
   character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
   real(8) :: start_time, end_time
   integer :: out_unit = 10

   input_file     = "../data/input_file.txt"
   positions_file = "../data/positions.txt"
   output_file    = "output.txt"

   print *, " СОРТИРОВКА СОТРУДНИКОВ"
   print *, ""

   call Read_positions(positions_file, positions_rank)
   print *, " Прочитано должностей: ", POS_AMOUNT

   employees => Read_employee_list(input_file)
   print *, " Прочитано сотрудников: ", EMPL_AMOUNT
   print *, ""

   call Output_employee_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")

   start_time = omp_get_wtime()
   call Sort_employee_list(employees, positions_rank)
   end_time = omp_get_wtime()

   call Output_employee_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")

   open(unit=out_unit, file=output_file, position='append', status='old', action='write')
   write(out_unit, '(/a)') repeat('=', 50)
   write(out_unit, '(a, f10.6, a)') " Время сортировки: ", end_time - start_time, " секунд"
   write(out_unit, '(a)') repeat('=', 50)
   close(out_unit)

end program main
