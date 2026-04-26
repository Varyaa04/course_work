program main
   use Environment
   use Order_IO
   use Sorting
   use omp_lib
   
   implicit none
   character(:), allocatable :: input_file, output_file, positions_file
   
   type(employee), allocatable :: employees
   character(POSITION_LEN, kind=CH_), allocatable :: positions_rank(:)
   integer :: n, m
   real(8) :: start_time, end_time
   
   input_file    = "../data/input_file.txt"
   output_file   = "output.txt"
   positions_file = "../data/positions.txt"
   
   print *, "     СОРТИРОВКА СОТРУДНИКОВ (ЧЁТ-НЕЧЕТ + OpenMP)"
   print *, "     Рекурсивно размещаемый тип, хвостовая рекурсия"
   print *, ""
   
   ! Чтение ранга должностей
   call Read_positions(positions_file, positions_rank)
   m = size(positions_rank)
   print *, "      Прочитано должностей: ", m
   print *, ""
   
   ! Чтение списка сотрудников
   employees = Read_employee_list(input_file)
   
   if (allocated(employees)) then
      ! Подсчёт количества сотрудников (хвостовая рекурсия)
      n = Count_employees(employees, 0)
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
      
      print *, "      Результат сохранён в файл: ", output_file
      
      ! Освобождение памяти
      call Free_employee_list(employees)
   else
      print *, "      ОШИБКА: Файл пуст или не найден!"
      print *, "      Проверьте наличие файла: ", input_file
   end if
   
end program main