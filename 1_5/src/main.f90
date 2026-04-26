program main
   use Environment
   use Sorting
   use Order_IO
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, data_file, pos_file
   
   type(employee), allocatable :: employees(:)
   character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   data_file   = "employees.bin"
   pos_file    = "../data/positions.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   print *, ""
   
   call Create_data_file(input_file, data_file)
   print *, "      Прочитано сотрудников: ", EMPL_AMOUNT
   
   call Read_positions(pos_file, positions_rank)
   print *, "      Прочитано должностей: ", POS_AMOUNT
   print *, ""
   
   employees = Read_employee_list(data_file)
   
   call Output_employee_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   start_time = omp_get_wtime()
   call Sort_employees(employees, positions_rank, EMPL_AMOUNT)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   call Output_employee_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
   print *, "      Результат сохранён в output.txt"
   
end program main