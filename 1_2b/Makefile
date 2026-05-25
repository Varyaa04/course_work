FC = flang
FFLAGS_BASE = -fimplicit-none -O3 -march=native -fvectorize -fstack-arrays
#openmp флаги с версией 5.1 (поддержка align в allocate)
OMP_FLAGS = -fopenmp -fopenmp-version=51
#оптимизационные флаги
OPT_FLAGS = -funroll-loops -ftree-vectorize
#полные флаги
FFLAGS = $(FFLAGS_BASE) $(OMP_FLAGS) $(OPT_FLAGS)

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


obj:
	mkdir -p obj

bin:
	mkdir -p bin

clean:
	rm -rf obj/* bin/* output.txt

run:
	cd ./bin && ./app
	cat bin/output.txt
