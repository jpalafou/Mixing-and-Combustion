! module to simplify the expression of conductive/advective and diffusive equations

  ! Four of our governing equations have the form
  ! \begin{equation}
  ! \rho^* u^* \pdv{a}{x^*} + \rho^* v^* \pdv{a}{y^*} + A = c\frac{\partial}{\partial y^*}(\mu^*\pdv{a}{y^*})
  ! \end{equation} where \(a\) is the explicited variable, \(A\) is some non-differential
  !  term (or 0), and \(c\) is a constant (either \(\frac{1}{Pr}\) or 1)

! uses global module
! uses realprecision module
module difapprox
  use global

  contains
    ! function to simplify the evaluation of the central differential operator
    ! in y
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function DO_CentralY(var_mp1, var_mm1, m)
      real(dp), intent(in) :: var_mp1 ! var(m+1,n)
      real(dp), intent(in) :: var_mm1
      integer, intent(in) :: m

      DO_CentralY = (var_mp1 - var_mm1)/(y(m+1) - y(m-1))
    end function DO_CentralY

    ! function to simplify the evaluation of the second central differential
    ! operator in y using a hybrid discretized mu value
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function DO_CentralY2_mu(var_mp1, var_m, var_mm1, m)
      real(dp), intent(in) :: var_mp1 ! var(m+1,n)
      real(dp), intent(in) :: var_m ! var(m,n)
      real(dp), intent(in) :: var_mm1 ! var(m-1,n)
      integer, intent(in) :: m

      DO_CentralY2_mu = (1/(2*(( ((y(m-1)-y(m))/2)+((y(m)-y(m+1))/2) )**2))) &
      *( ((mu(m+1,1) + mu(m,1))*(var_mp1 - var_m)) - &
      ((mu(m,1) + mu(m-1,1))*(var_m - var_mm1)) )
    end function DO_CentralY2_mu

    ! function to simplify the evaluation of var(m,n+1)
    ! ASSUMING COMPUTATIONS ARE FOR NORMALIZED EQUATIONS
    real(dp) function VAR_mnp1(var_m, DOY1, DOY2, A_m, c, m)
      real(dp), intent(in) :: var_m ! var(m,n)
      real(dp), intent(in) :: DOY1 ! DO_CentralY
      real(dp), intent(in) :: DOY2 ! DO_CentralY2_mu
      real(dp), intent(in) :: A_m ! A(m,n)
      real(dp), intent(in) :: c ! constant in front of DO_CentralY2_mu
      integer, intent(in) :: m

      VAR_mnp1 = var_m + ((Dx/(rho(m,1)*u(m,1)))* &
      ((c*DOY2)- (rho(m,1)*v(m,1)*DOY1) - A_m))
    end function VAR_mnp1

end module difapprox
