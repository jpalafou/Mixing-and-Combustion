FC=gfortran
FFLAGS=-O3 -Wall -Wextra -frecursive
SRC=global_variables.f90 dimensional_quantities.f90 stability_check.f90 mesh_gen.f90 initial_conditions.f90 boundary_conditions.f90 export.f90 difference_approximations.f90 primary_calculations.f90 main.f90
OBJ=${SRC:.f90=.o}

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

main: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

clean:
	rm *.o *.mod main
