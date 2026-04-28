FC = flang
FFLAGS = -fimplicit-none -fopenmp -O3 

#OMP_ROOT = /usr/lib/llvm-19
#OMP_LIB = -L$(OMP_ROOT)/lib -lomp
OMP_ROOT=/opt/homebrew/opt/libomp
OMP_LIB=-L$(OMP_ROOT)/lib -lomp
OMP_INC = -I$(OMP_ROOT)/include

all: obj bin
	$(FC) $(FFLAGS) $(OMP_INC) -c src/environment.f90 -J obj -o obj/environment.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/order_io.f90 -J obj -o obj/order_io.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/sorting.f90 -J obj -o obj/sorting.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/main.f90 -I obj -o obj/main.o
	$(FC) $(FFLAGS) -o bin/app obj/environment.o obj/order_io.o obj/sorting.o obj/main.o $(OMP_LIB)

check-vec: obj
	$(FC) $(FFLAGS) $(OMP_INC) -c src/environment.f90 -J obj -o obj/environment.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/order_io.f90 -J obj -o obj/order_io.o
	$(FC) $(FFLAGS) $(OMP_INC) -S src/sorting.f90 -J obj -o sorting.s
	@echo "=== Поиск SIMD инструкций ==="
	@grep -E "ldr.*q[0-9]|str.*q[0-9]|fadd.*v|fmul.*v" sorting.s || echo "SIMD инструкции не найдены для SURNAME_LEN=15"
	@echo "=== Готово ==="

obj:
	mkdir -p obj

bin:
	mkdir -p bin

clean:
	rm -rf obj/* bin/* output.txt

run:
	cd ./bin && ./app
	cat bin/output.txt