program main
  use global
  use dimqua
  use stable
  use meshgen
  use IC
  use BC
  use export
  use difapprox
  use primarycalcs
  implicit none

  print*,'-----------------------------------'
  print*,'Mixing and Combustion Marchine Code'
  print*,'by Jonathan Palafoutas (2022)'
  print*,'-----------------------------------'
  print*

  write(*,'(A10, G20.5)') 'x_f = ', xf
  write(*,'(A10, G20.5)') 'Dx = ', Dx
  write(*,'(A10, I16)') 'n_x = ', nx
  print*

  write(*,'(A10, G20.5)') 'y_u = ', yu
  write(*,'(A10, G20.5)') 'y_l = ', yl
  write(*,'(A10, G20.5)') 'Dy = ', Dy
  write(*,'(A10, I16)') 'n_y = ', ny
  print*

  write(*,'(A17,F9.2,A2)') 'T_+inf = ', T_ref, ' K'
  write(*,'(A17,G9.2)') 'Da = ', Da
  if (IGNITOR) then
    write(*,'(A17,F9.2)') 'h_max/h_inf = ', h_max
  else
    write(*,'(A17,F9.2)') 'h_+inf/h_-inf = ', h_ratio
  end if
  print*

  write(*,'(A17,F9.2)') 'u_+inf/u_-inf = ', u_ratio
  write(*,'(A17,F9.2)') 'Pr = ', Pr
  if (KCONSTANT) then
    write(*,'(A17,F9.2)') 'f* = ', F
  else
    write(*,'(A17,F9.2,A3)') 'f* = ', F, '/x*'
  end if
  print*

  ! SETUP - - -  - -
  ! check if the proposed domain is stable
  call stability_check()

  ! generate mesh
  call meshgenxy()

  ! definte initial conditions
  call build_ICs()
  print*,'Initial conditions set up.'
  print*

  ! definte boundary conditions for second column
  call build_BCs(2)
  print*,'Boundary conditions set up.'
  print*

  ! MAIN LOOP - - -  - -
  print*, 'Beginning main loop calculations ...'
  print*

  do while (BUILDMAIN .and. j .lt. nx)
    ! print update
    if (mod(j+1,floor(real(nx)/(20.d0*xf))) == 0) then

      if (j+1 .eq. 2) then
        write(*,'(A,F5.2)') '  x* =', x(1)
      end if

      write(*,'(A,F5.2)') '  x* =', x(j+1)
    end if

    ! define boundary conditions
    call build_BCs(j+1)

    ! do calcs
    call compScheme()
    call hScheme()
    call uScheme()
    call KScheme()

    ! make sure mass fractions are not negative
      do i = 1, ny
        if ( Y1(i,2) < 0.d0 ) then
          Y1(i,2) = 0.0d0
        end if

        if ( Y2(i,2) < 0.d0 ) then
          Y2(i,2) = 0.0d0
        end if
      end do

    call updateDomain(2)
    call vScheme()

    ! log if necessary
    if (mod(j+1,j_log) == 0) then
      call update_logs(log_count)
      log_count = log_count + 1
    end if

    ! check for errors
    do i = 1, ny - 1
      ! check for nan mass fractions
      if ( ( isnan(Y1(i,2)) ) .or. ( isnan(Y2(i,2)) ) ) then
        print*, '  Mass fractions are nan at j =', j + 1
        print*, '  x* =', x(j+1)
        BUILDMAIN = .false.
        exit
      end if

      ! check if temperature exceeds expected value (diffusion stability)
      if (T(i,2) > T_max_exp) then
        if (Dx>0.5d0*(u(i,2)*(rho(i,2)/mu(i,2)))*((y(i)-y(i+1))**2)) then
          print*, '  Diffusion stability criterion violated at j =', j + 1
          print*, '  x* =', x(j+1)
          BUILDMAIN = .false.
          exit
        end if
      end if

      ! check reaction stability
      if (wF(i,2) > 1/((y(i) - y(i+1))**2)) then
        if (wF(i,2) > 2.d0*mu(i,2)/(rho(i,2)*((y(i) - y(i+1))**2))) then
          print*, '  Reaction stability criterion violated at j =', j + 1
          print*, '  x* =', x(j+1)
          BUILDMAIN = .false.
          exit
        end if
      end if

    end do

    ! reset arrays
    call reset_arrays()

    ! update counter
    j = j + 1
  end do
  print*

  ! SAVE - - -  - -
  ! scalars
  ScalarSave(1,1) = nx_log
  ScalarSave(2,1) = ny
  ScalarSave(3,1) = Dx
  ScalarSave(4,1) = Dy
  ScalarSave(5,1) = j_fail
  ScalarSave(6,1) = xr_ind
  ScalarSave(7,1) = u_ratio
  ScalarSave(8,1) = h_ratio
  ScalarSave(9,1) = Pr
  ScalarSave(10,1) = Da
  ScalarSave(11,1) = F
  ScalarSave(12,1) = 1 ! expected number of files
  ScalarSave(13,1) = nx_log + 1 ! maximum number of columns per file
  call binwritef(ScalarSave,'out_ScalarSave.bin')
  print*, 'Scalar parameters saved.'
  print*

  ! vectors
  call binwritef(fstar_log,'out_fstar.bin')
  call binwritef(x_log,'out_x.bin')
  call binwritef(y_log,'out_y.bin')
  print*, 'Vector parameters saved.'
  print*

  ! arrays
  call datadump()
  print*, 'Array parameters saved.'
  print*

end program main
