program main
   use Environment
   use Order_io
   use Sorting
   use omp_lib
   implicit none

   type(employees_soa), allocatable :: employees
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)

   character(:), allocatable :: input_file, binary_file, output_file, pos_file, binary_pos_file
   real(8) :: start_time, end_time

   input_file = "../data/input_file.txt"
   binary_file = "employees.bin"
   output_file = "output.txt"
   pos_file = "../data/positions.txt"
   binary_pos_file = "positions.bin"

   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   print *, ""

   !cоздание бинарного файла с должностями
   call Create_positions_binary(pos_file, binary_pos_file)
   allocate(positions_rank(POS_AMOUNT))
   positions_rank = Read_positions_binary(binary_pos_file)
   print *, "      Прочитано должностей: ", size(positions_rank)

   !cоздание бинарного файла с сотрудниками
   call Create_employees_binary(input_file, binary_file)
   allocate(employees)
   employees = Read_employees_binary(binary_file)
   print *, "      Прочитано сотрудников: ", size(employees%surnames)
   print *, ""

   call Output_employees_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")

   start_time = omp_get_wtime()
   call Sort_employees(employees, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""

   call Output_employees_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")

end program main