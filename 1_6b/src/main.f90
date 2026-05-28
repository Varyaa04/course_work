program main
   use Environment
   use Order_IO
   use Sorting
   use omp_lib

   implicit none
   character(:), allocatable :: input_file, output_file, positions_file
   integer :: out_unit = 10
   real(8) :: start_time, end_time
   type(employee), allocatable :: employees
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   
   input_file    = "../data/input_file.txt"
   output_file   = "output.txt"
   positions_file = "../data/positions.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   print *, ""
   
   call Read_positions(positions_file, positions_rank)
   print *, "      прочитано должностей: ", size(positions_rank)
   print *, ""
   
   employees = Read_employee_list(input_file)
   print *, "      прочитано сотрудников: ", EMPL_AMOUNT
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
