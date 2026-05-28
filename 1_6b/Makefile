FC=flang
FFLAGS=-O3 -fimplicit-none -fopenmp -march=native -funroll-loops -fomit-frame-pointer
FOPT=-O3


OMP_ROOT = /usr/lib/llvm-19
OMP_LIB = -L$(OMP_ROOT)/lib -lomp
#OMP_ROOT=/opt/homebrew/opt/libomp
#OMP_LIB=-L$(OMP_ROOT)/lib -lomp
OMP_INC = -I$(OMP_ROOT)/include

all: obj bin
	$(FC) $(FFLAGS) $(OMP_INC) -c src/environment.f90 -J obj/ -o obj/environment.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/order_io.f90 -J obj/ -o obj/order_io.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/sorting.f90 -J obj/ -o obj/sorting.o
	$(FC) $(FFLAGS) $(OMP_INC) -c src/main.f90 -I obj/ -o obj/main.o
	$(FC) $(FFLAGS)  -o bin/app obj/environment.o obj/order_io.o obj/sorting.o obj/main.o $(OMP_LIB)

obj:
	mkdir -p obj

bin:
	mkdir -p bin

clean:
	rm -rf obj/* bin/* output.txt data/input_file.txt

run:
	ulimit -s unlimited && cd ./bin && ./app
	cat bin/output.txt
    LANG=ru_RU.UTF-8 cat bin/output.txt

generate:
	python3 generate_employees.py > data/input_file.txt
