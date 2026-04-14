FC=gfortran
FFLAGS=-Wall -fopenmp -fopenmp-allocators -march=native -fimplicit-none -Wno-maybe-uninitialized -Wno-unused-function -static-libgfortran -flto
FOPT=-O3 -ftree-vectorize -fopt-info-vec

all:
	$(FC) $(FFLAGS) -c src/environment.f90 -J obj/ -o obj/environment.o
	$(FC) $(FFLAGS) $(FOPT) -c src/order_io.f90 -J obj/ -o obj/order_io.o
	$(FC) $(FFLAGS) $(FOPT) -c src/sorting.f90 -J obj/ -o obj/sorting.o
	$(FC) $(FFLAGS) $(FOPT) -c src/main.f90 -I obj/ -o obj/main.o
	$(FC) $(FFLAGS) $(FOPT) -o bin/app obj/environment.o obj/order_io.o obj/sorting.o obj/main.o

clean:
	rm -rf obj/* bin/*

run:
	cd ./bin && ./app
	cat bin/output.txt
