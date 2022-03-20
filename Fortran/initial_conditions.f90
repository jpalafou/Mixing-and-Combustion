! build initial conditions for all parameters
module IC
  use global
  use dimqua
  implicit none
  integer :: m, n = 1
  real(dp) :: mu1_temp, mu2_temp, mu3_temp, mu4_temp, mu_temp

contains
  subroutine build_ICs()
    ! define reference viscosity
    mu_ref = find_mu(T_ref,Tcrit1,Vcrit1,W1)

    ! define initial density ratio
    if (IGNITOR) then
      rho_ratio = find_rho(T_ref,1.d0,0.d0,0.d0,0.d0)/ &
      find_rho(T_ref,0.d0,1.d0,0.d0,0.d0)
    else
      rho_ratio = find_rho(T_ref,1.d0,0.d0,0.d0,0.d0)/ &
      find_rho(T_ref/h_ratio,0.d0,1.d0,0.d0,0.d0)
    end if

    ! initialize kappa bounds
    if (KCONSTANT) then
      fstar(1) = F
      K(1,1) = F
      K(ny,1) = sqrt(rho_ratio) * F
    else
      ! find index of xr
      do while (abs(x(n + 1) - xr) < abs(x(n) - xr))
        n = n + 1
      end do

      xr_ind = n

      fstar(1) = F/x(xr_ind)

      if (F > 0.d0) then
        A_yu = (1 + sqrt(1 + (4*(F**2))))/2
        A_yl = ( (1/u_ratio) + sqrt( ((1/u_ratio)**2) + &
          (4*(rho_ratio)*(F**2))) )/2
      else
        A_yu = (1 - sqrt(1 + (4*(F**2))))/2
        A_yl = ( (1/u_ratio) - sqrt( ((1/u_ratio)**2) + &
          (4*(rho_ratio)*(F**2))) )/2
      end if

      K(1,1) = A_yu/x(xr_ind)
      K(ny,1) = A_yl/x(xr_ind)
    end if

    ! loop y values
    do m = 1, ny
      ! enthalpy
      if (IGNITOR) then
        h(m,1) = 1 + ((h_max-1)*exp(-(G_ignitor*y(m)**2)))
      else
        h(m,1) = ((1 + (1/h_ratio))/2) + (((1 - (1/h_ratio))/2)*tanh(G*y(m)))
      end if

      ! x-velocity
      u(m,1) = ((1 + (1/u_ratio))/2) + (((1 - (1/u_ratio))/2)*tanh(G*y(m)))

      ! composition
      Y1(m,1) = ((Y1_yu + Y1_yl)/2) + (((Y1_yu - Y1_yl)/2)*tanh(G*y(m)))
      Y2(m,1) = ((Y2_yu + Y2_yl)/2) + (((Y2_yu - Y2_yl)/2)*tanh(G*y(m)))

      ! kappa
      if (m .ne. 1 .and. m .ne. ny) then
        K(m,1) = ((K(1,1) + K(ny,1))/2) + (((K(1,1) - K(ny,1))/2)*tanh(G*y(m)))
      end if
    end do

    call updateDomain(1)

    fstar_log(1,1) = fstar(1)
    h_log(:,1) = h(:,1)
    K_log(:,1) = K(:,1)
    mu_log(:,1) = mu(:,1)
    rho_log(:,1) = rho(:,1)
    T_log(:,1) = T(:,1)
    u_log(:,1) = u(:,1)
    wF_log(:,1) = wF(:,1)
    Y1_log(:,1) = Y1(:,1)
    Y2_log(:,1) = Y2(:,1)

  end subroutine build_ICs

end module IC
