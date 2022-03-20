! module to find quantities of interest while stepping in the x direction
! uses global module
! uses realprecision module
! uses dimensions module
! uses CleanScheme module
! uses properites module
module primarycalcs
  use global
  use difapprox
  implicit none
  integer :: m
  real(dp) :: DOY1_Temp, DOY2_Temp, A_m_temp, c_temp
  real(dp) :: va, vb, vc, vd ! differential placeholders for v

  contains
    subroutine compScheme()
      ! solve for composition Y1 and Y2 in the next x position along all y
      do m = 2, (ny - 1)
        ! Y1 (oxygen)
        DOY1_Temp = DO_CentralY(Y1(m+1,1), Y1(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(Y1(m+1,1), Y1(m,1), Y1(m-1,1), m)
        A_m_temp = -rho(m,1)*wF(m,1)/nu1 ! coarse reaction
        c_temp = 1/Pr ! c = 1/Pr

        Y1(m,2) = VAR_mnp1(Y1(m,1), DOY1_Temp, DOY2_Temp, A_m_temp, c_temp, &
        m)

        ! Y2 (propane)
        DOY1_Temp = DO_CentralY(Y2(m+1,1), Y2(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(Y2(m+1,1), Y2(m,1), Y2(m-1,1), m)
        A_m_temp = 0 ! no reacton
        A_m_temp = -rho(m,1)*wF(m,1) ! coarse reaction
        c_temp = 1/Pr ! c = 1/Pr

        Y2(m,2) = VAR_mnp1(Y2(m,1), DOY1_Temp, DOY2_Temp, A_m_temp, c_temp, &
        m)

        ! Y3 (carbon dioxide)
        DOY1_Temp = DO_CentralY(Y3(m+1,1), Y3(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(Y3(m+1,1), Y3(m,1), Y3(m-1,1), m)
        A_m_temp = rho(m,1)*wF(m,1)/nu3 ! coarse reaction
        c_temp = 1/Pr ! c = 1/Pr

        Y3(m,2) = VAR_mnp1(Y3(m,1), DOY1_Temp, DOY2_Temp, A_m_temp, c_temp, &
        m)

        ! Y4 (water)
        DOY1_Temp = DO_CentralY(Y4(m+1,1), Y4(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(Y4(m+1,1), Y4(m,1), Y4(m-1,1), m)
        A_m_temp = rho(m,1)*wF(m,1)/nu4 ! coarse reaction
        c_temp = 1/Pr ! c = 1/Pr

        Y4(m,2) = VAR_mnp1(Y4(m,1), DOY1_Temp, DOY2_Temp, A_m_temp, c_temp, &
        m)

      end do
    end subroutine compScheme

    subroutine hScheme()
      ! solve for enthalpy in the next x position along all y
      do m = 2, (ny - 1)
        ! solve for h
        DOY1_Temp = DO_CentralY(h(m+1,1), h(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(h(m+1,1), h(m,1), &
        h(m-1,1), m)
        A_m_temp = rho(m,1)*Q2*wF(m,1) ! coarse reaction
        c_temp = 1/Pr ! c = 1/Pr

        h(m,2) = VAR_mnp1(h(m,1), DOY1_Temp, &
        DOY2_Temp, A_m_temp, c_temp, m)
      end do
    end subroutine hScheme

    subroutine uScheme()
      ! solve for u in the next x position along all y
      do m = 2, (ny - 1)
        DOY1_Temp = DO_CentralY(u(m+1,1), u(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(u(m+1,1), u(m,1), u(m-1,1), &
        m)
        A_m_temp = 0 ! A = 0,
        c_temp = 1 ! c = 1

        u(m,2) = VAR_mnp1(u(m,1), DOY1_Temp, DOY2_Temp, A_m_temp, &
        c_temp, m)
      end do
    end subroutine uScheme

    subroutine vScheme()
      ! solve for v in the next x position along all y
      ! we already know v at y = 0

      ! first travel upward from y = 0
      do m = ceiling(real(ny)/2.d0), 2, -1
        ! Dy terms should be preceded by a - because we are travelling upward
        va = u(m-1,2)*(rho(m-1,2)-rho(m-1,1))/Dx

        vb = rho(m-1,2)*(u(m-1,2)-u(m-1,1))/Dx

        vc = v(m,2)*(rho(m,2)-rho(m-1,2))/(y(m)-y(m-1))

        vd = rho(m-1,2)*K(m-1,2)

        v(m-1,2) = v(m,2) + ((y(m)-y(m-1))*(va+vb+vc+vd)/rho(m-1,2))
      end do

      ! then travel downward from y = 0
      do m = ceiling(real(ny)/2.d0), (ny - 1)
        va = u(m+1,2)*(rho(m+1,2)-rho(m+1,1))/Dx

        vb = rho(m+1,2)*(u(m+1,2)-u(m+1,1))/Dx

        vc = -v(m,2)*(rho(m,2)-rho(m+1,2))/(y(m+1)-y(m))

        vd = rho(m+1,2)*K(m+1,2)

        v(m+1,2) = v(m,2) + (-(y(m+1)-y(m))*(va+vb+vc+vd)/rho(m+1,2))
      end do
    end subroutine vScheme

    subroutine KScheme()
      do m = 2, (ny - 1)
        DOY1_Temp = DO_CentralY(K(m+1,1), K(m-1,1), m)
        DOY2_Temp = DO_CentralY2_mu(K(m+1,1), K(m,1), &
        K(m-1,1), m)
        A_m_temp = (rho(m,1)*(K(m,1)**2)) &
        - ((fstar(j+1)**2))
        c_temp = 1 ! c = 1

        K(m,2) = VAR_mnp1(K(m,1), DOY1_Temp, DOY2_Temp, &
        A_m_temp, c_temp, m)
      end do
    end subroutine KScheme

end module primarycalcs
