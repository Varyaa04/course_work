program main
   use Environment
   use Sorting
   use Order_io
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, data_file
   
   type(employee), allocatable :: employees(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   data_file   = "employees.dat"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   
   !cоздание неформатированного файла
   call CreateFile(input_file, data_file, n)
   print *, "      Прочитано сотрудников: ", n
   
   call ReadPositions("../data/positions.txt", positions_rank)
   print *, "      Прочитано должностей: ", size(positions_rank)
   print *, ""
   
   employees = ReadEmpl(data_file, n)
   
   call WriteEmpl(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   start_time = omp_get_wtime()
   call SortEmpl(employees, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   call WriteEmpl(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
end program main