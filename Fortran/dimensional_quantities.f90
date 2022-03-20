! module to find dimensinal parameters as a function of temperature, composition, etc.
module dimqua
  use global
  implicit none

  contains
    ! function to find viscosity for a particular fluid as a function of T
    real(dp) function find_mu(T,Tcrit,Vcrit,W)
      real(dp), intent(in) :: T
      real(dp), intent(in) :: Tcrit
      real(dp), intent(in) :: Vcrit
      real(dp), intent(in) :: W
      real(dp) :: VcritConvert ! unit converted Vcrit
      real(dp) :: WConvert ! unit converted W

      ! initiate constants and variables for equations
      real(dp) :: A = 1.16145d0
      real(dp) :: B = 0.14874d0
      real(dp) :: C = 0.52487d0
      real(dp) :: D = 0.77320d0
      real(dp) :: E = 2.16178d0
      real(dp) :: F = 2.43787d0
      real(dp) :: G = -0.0006435d0
      real(dp) :: H = 7.27371d0
      real(dp) :: S = 18.0323d0
      real(dp) :: Wcon = -0.76830d0
      real(dp) :: epsOverK
      real(dp) :: Tstar
      real(dp) :: omegastar

      ! convert Vcrit to [cm3/mol]
      VcritConvert = Vcrit*(100.d0**3)*W

      ! convert W to [g/mol]
      WConvert = W*1000.d0

      ! use equations that I don't understand
      epsOverK = Tcrit/1.2593d0
      Tstar = T/epsOverK

      omegastar = (A/(Tstar**B)) &
            + (C/exp(D*Tstar))  &
            + (E/exp(F*Tstar))  &
            + (G*(Tstar**B)*sin((S*(Tstar**Wcon))-H))

      find_mu = (0.0000407850d0)*((WConvert*T)**(1.d0/2.d0))/&
      ((VcritConvert**(2.d0/3.d0))*omegastar)

      ! this value should be in g/(cm*s), so we convert to kg/(m*s)
      find_mu = find_mu*0.1d0

    end function find_mu

    ! function to find the combined mu for mixed fluids
    real(dp) function comb_mu(Y1,mu1,Y2,mu2,Y3,mu3,Y4,mu4)
      real(dp), intent(in) :: Y1
      real(dp), intent(in) :: mu1
      real(dp), intent(in) :: Y2
      real(dp), intent(in) :: mu2
      real(dp), intent(in) :: Y3
      real(dp), intent(in) :: mu3
      real(dp), intent(in) :: Y4
      real(dp), intent(in) :: mu4

      comb_mu = (Y1*mu1) + (Y2*mu2) + (Y3*mu3) + (Y4*mu4) ! [kg/(m s)]
    end function comb_mu

    ! function to find normalized \mu
    real(dp) function find_mu_norm(mu)
      real(dp), intent(in) :: mu
      find_mu_norm = mu/mu_ref
    end function find_mu_norm

    ! find temperature of mixed fluids as a function of normalized enthalpy
    ! * pure composition of free stream assumption
    real(dp) function find_T(h)
      real(dp), intent(in) :: h ! normalized enthalpy

      find_T = T_ref*h ! [K]
    end function find_T

    ! find normalizd density of mixed fluids based on temperature and composition
    ! * pure composition of free stream assumption
    real(dp) function find_rho(T,Y1,Y2,Y3,Y4)
      real(dp), intent(in) :: T
      real(dp), intent(in) :: Y1
      real(dp), intent(in) :: Y2
      real(dp), intent(in) :: Y3
      real(dp), intent(in) :: Y4
      real(dp) :: MolWeightComb

      MolWeightComb = 1.d0/((Y1/W1) + (Y2/W2) + (Y3/W3) + (Y4/W4))

      find_rho = (T_ref/T)*(MolWeightComb/W1) ! [Dimensionless]
    end function find_rho

    ! reaction rate of fuel
    real(dp) function find_wF(rho,Y1,Y2,h)
      real(dp), intent(in) :: rho
      real(dp), intent(in) :: Y1
      real(dp), intent(in) :: Y2
      real(dp), intent(in) :: h

      ! Y2 is abs(Y2)
      if ( Y2 > 1e-9 ) then
        find_wF = -(rho**0.75d0)*(Y1**1.65d0) &
        *(Y2**0.1d0)*exp(log(Da)-(EA2/(R2*T_ref*h)))
      else
        find_wF = 0.d0
      end if
    end function find_wF

    ! subroutine to update values of dimensional arrays
    subroutine updateDomain(n)
      real(dp) :: mu1_temp
      real(dp) :: mu2_temp
      real(dp) :: mu3_temp
      real(dp) :: mu4_temp
      real(dp) :: mu_temp
      integer :: m
      integer, intent(in) :: n

      do m = 1, ny
        ! VERY IMPORTANT UPDATES
        T(m,n) = find_T(h(m,n))

        mu1_temp = find_mu(T(m,n),Tcrit1,Vcrit1,W1)
        mu2_temp = find_mu(T(m,n),Tcrit2,Vcrit2,W2)
        mu3_temp = find_mu(T(m,n),Tcrit3,Vcrit3,W3)
        mu4_temp = find_mu(T(m,n),Tcrit4,Vcrit4,W4)
        mu_temp = comb_mu(Y1(m,n),mu1_temp,Y2(m,n),mu2_temp, &
          Y3(m,n),mu3_temp,Y4(m,n),mu4_temp)
        mu(m,n) = mu_temp/mu_ref

        rho(m,n) = find_rho(T(m,n),Y1(m,n),Y2(m,n), &
        Y3(m,n),Y4(m,n))

        wF(m,n) = find_wF(rho(m,n),Y1(m,n),Y2(m,n),h(m,n))
      end do
    end subroutine updateDomain

end module dimqua
