program main
   use Environment
   use Order_IO
   use Sorting
   !use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, data_file, pos_file
   type(employees_soa) :: employees
   character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
   integer :: start_time, end_time, rate
   integer :: out_unit = 10

   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   data_file   = "employees.bin"
   pos_file    = "../data/positions.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   print *, ""
   
   !создание бинарного файла 
   call Create_data_file(input_file, data_file)
   print *, "      Прочитано сотрудников: ", EMPL_AMOUNT
   
   !чтение должностей
   call Read_positions(pos_file, positions_rank)
   print *, "      Прочитано должностей: ", POS_AMOUNT
   print *, ""
   
   !чтение бинарного файла
   employees = Read_employee_list(data_file)
   
   call Output_employee_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   !сортировка
   call system_clock(count_rate=rate)
   call system_clock(count=start_time)
   !start_time = omp_get_wtime()
   call Sort_employees(employees, positions_rank, EMPL_AMOUNT)
   !end_time = omp_get_wtime()
   call system_clock(count=end_time)

   call Output_employee_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")

   open(unit=out_unit, file=output_file, position='append', status='old', action='write')
   write(out_unit, '(/a)') repeat('=', 50)
   !write(out_unit, '(a, f10.6, a)') " Время сортировки: ", end_time - start_time, " секунд"
   write(out_unit, '(a, f10.6, a)') " Время сортировки: ", &
     real(end_time - start_time) / real(rate), " секунд"
   write(out_unit, '(a)') repeat('=', 50)
   close(out_unit)

end program main
