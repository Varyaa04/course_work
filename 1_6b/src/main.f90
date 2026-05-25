program main
   use Environment
   use Order_IO
   use Sorting
   
   implicit none
   character(:), allocatable :: input_file, output_file, positions_file
   
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
   
   call Output_employee_list(output_file, employees, "исходный список:", "rewind")
   
   call Sort_employee_list(employees, positions_rank, EMPL_AMOUNT)
   
   call Output_employee_list(output_file, employees, "отсортированный список:", "append")
   
   print *, "      результат сохранён в файл: ", output_file
      
end program main