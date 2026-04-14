program main
   use Environment
   use Sorting
   use Order_io
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file
   
   type(employee), pointer :: employees => Null()
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n, m
   real(8) :: start_time, end_time
   
   input_file  = "../data/input_file.txt"
   output_file = "output.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ"
   
   ! Чтение ранга должностей
   call Read_positions("../data/positions.txt", positions_rank, m)
   print *, "      Прочитано должностей: ", m
   
   ! Чтение списка сотрудников из форматированного файла
   employees => Read_employee_list(input_file)
   
   if (Associated(employees)) then
      ! Подсчёт количества сотрудников
      n = Count_employees(employees)
      print *, "      Прочитано сотрудников: ", n
      print *, ""
      
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
      
      ! Освобождение памяти
      call Free_employee_list(employees)
   else
      print *, "      ОШИБКА: Файл пуст или не найден!"
   end if
   
end program main
