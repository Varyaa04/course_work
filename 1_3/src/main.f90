program main
   use Environment
   use Order_io
   use Sorting
   use omp_lib
   implicit none

   type(employee), allocatable :: employees(:)
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)

   character(:), allocatable :: input_file, binary_file, output_file, pos_file
   real(8) :: start_time, end_time

   input_file = "../data/input_file.txt"
   binary_file = "employees.bin"
   output_file = "output.txt"
   pos_file = "../data/positions.txt"

   print *, "     СОРТИРОВКА СОТРУДНИКОВ"


   call ReadPositions(pos_file, positions_rank)
   print *, "      Прочитано должностей: ", POS_AMOUNT

   call CreateBinaryFile(input_file, binary_file)

   print *, "      Чтение из двоичного"
   employees = ReadEmployeesBinary(binary_file)
   print *, "      Прочитано сотрудников: ", size(employees)
   print *, ""

   call WriteEmployeesText(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")

   start_time = omp_get_wtime()
   call SortEmployees(employees, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""

   call WriteEmployeesText(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")

   print *, "      Результат сохранён в output.txt"

end program main