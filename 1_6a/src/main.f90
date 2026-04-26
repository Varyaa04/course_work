program main
   use Environment
   use Sorting
   use Order_IO
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file
   
   type(employee), pointer :: employees => Null()
   character(POSITION_LEN, kind=CH_) :: positions_rank(POS_AMOUNT)
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ (ЧЁТ-НЕЧЕТ + СПИСОК + OpenMP)"
   print *, ""
   
   ! Чтение ранга должностей
   call Read_positions("../data/positions.txt", positions_rank)
   print *, "      Прочитано должностей: ", POS_AMOUNT
   
   ! Чтение списка сотрудников из форматированного файла
   employees => Read_employee_list(input_file)
   print *, "      Прочитано сотрудников: ", EMPL_AMOUNT
   print *, ""
   
   ! Вывод исходного списка
   call Output_employee_list(output_file, employees, "ИСХОДНЫЙ СПИСОК:", "rewind")
   
   ! ЗАМЕР ВРЕМЕНИ ТОЛЬКО СОРТИРОВКИ
   start_time = omp_get_wtime()
   call Sort_employee_list(employees, positions_rank)
   end_time = omp_get_wtime()
   print '(a, f10.6, a)', "      Время сортировки: ", end_time - start_time, " секунд"
   print *, ""
   
   ! Вывод отсортированного списка
   call Output_employee_list(output_file, employees, "ОТСОРТИРОВАННЫЙ СПИСОК:", "append")
   
   print *, "      Результат сохранён в output.txt"
   
   ! Освобождение памяти
   call Free_employee_list(employees)
   
end program main