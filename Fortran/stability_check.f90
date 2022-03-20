! module to check if the intended domain is stable
module stable
  use global
  use dimqua

  implicit none
  real(dp) :: mu_max
  real(dp) :: rho_min
  real(dp) :: u_min
  real(dp) :: a

contains
  subroutine stability_check()
    ! find maximum expected viscosity and mimum expected density and velocity
    mu_max = max(find_mu(T_max_exp,Tcrit1,Vcrit1,W1), &
    find_mu(T_max_exp,Tcrit2,Vcrit2,W2), &
    find_mu(T_max_exp,Tcrit3,Vcrit3,W3), &
    find_mu(T_max_exp,Tcrit4,Vcrit4,W4))

    rho_min = min(find_rho(T_max_exp,1.d0,0.d0,0.d0,0.d0), &
    find_rho(T_max_exp,0.d0,1.d0,0.d0,0.d0), &
    find_rho(T_max_exp,0.d0,0.d0,1.d0,0.d0), &
    find_rho(T_max_exp,0.d0,0.d0,0.d0,1.d0))

    u_min = 1.d0/u_ratio

    ! normalize
    mu_max = mu_max/find_mu(T_ref,Tcrit1,Vcrit1,W1)

    ! determine how many times larger delta_y^2 should be than delta_x_
    a = 0.5d0*u_min*(rho_min/mu_max)

    if (Dx <= a*(Dy**2)) then
      print*,'The finite difference scheme is stable.'
    else
      print*,'[Warning] The mesh size in x should be at most', a*(Dy**2)
      STABLEDOMAIN = .false.
      BREAKLOOP = .true.
    end if
    print*

  end subroutine stability_check
end module stable
