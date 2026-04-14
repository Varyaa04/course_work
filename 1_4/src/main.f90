program main
   use Environment
   use Sorting
   use Order_io
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, binary_file
   
   type(employees_data) :: employees
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   binary_file = "employees.bin"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   
   call Read_formatted_file(input_file, employees, n)
   print *, "      Прочитано сотрудников: ", n
   
   call Write_binary_file(binary_file, employees)
   print *, "      Создан двоичный файл: ", binary_file
   
   call Read_positions("../data/positions.txt", positions_rank)
   print *, "      Прочитано должностей: ", size(positions_rank)
   print *, ""
   
   call Write_output_file(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   start_time = omp_get_wtime()
   call Sort_employees(employees, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   call Write_output_file(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
   
end program main
