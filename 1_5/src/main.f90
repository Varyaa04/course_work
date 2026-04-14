program main
   use Environment
   use Sorting
   use Order_io
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, data_file
   
   type(employees_data) :: employees
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   data_file   = "employees.bin"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   
   ! Создание неформатированного файла из текстового
   call Create_data_file(input_file, data_file, n)
   print *, "      Прочитано сотрудников: ", n
   
   ! Чтение ранга должностей
   call Read_positions("../data/positions.txt", positions_rank)
   print *, "      Прочитано должностей: ", size(positions_rank)
   print *, ""
   
   ! Чтение списка сотрудников из неформатированного файла
   employees = Read_employee_list(data_file, n)
   
   ! Вывод исходного списка
   call Output_employee_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   ! ЗАМЕР ВРЕМЕНИ ТОЛЬКО СОРТИРОВКИ
   start_time = omp_get_wtime()
   call Sort_employee_list(employees, positions_rank, n)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   ! Вывод отсортированного списка
   call Output_employee_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
end program main
