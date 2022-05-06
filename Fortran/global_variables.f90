! define global variables for the main code
module global
  implicit none

  ! output path
  character(len=*), parameter :: &
    OutPath = '/Users/jonathan/Documents/DataDump/out_Fortran/'

  ! define precision for real variables
  integer, parameter :: dp = selected_real_kind(15, 307)

  ! INPUTS:
  ! domain parameters
  real(dp), parameter :: Dxi = 0.00000015d0 ! mesh size in x (initial guess)
  real(dp), parameter :: Dyi = 0.01d0 ! mesh size in y (initial guess)
  real(dp), parameter :: xf = 0.1d0 ! 3.0d0 ! final position in x
  real(dp), parameter :: yu = 12.0d0 ! upper y boundary
  real(dp), parameter :: yl = -12.d0 ! lower y boundary
  integer, parameter :: nx_log = 1000 ! 1000 ! number of points in x to log

  ! most-used inputs
  real(dp) :: Da = 1500000.d0 ! non-dimensional Damkohler number, A L rho_inf^0.75 / u_inf
  real(dp) :: F = 1.0d0 ! f* = F/x*
  real(dp) :: Pr = 1.0d0 ! Prandtl number
  real(dp) :: T_ref = 300.d0 ! 300.d0 ! free stream temperature at y = yu, [K]
  real(dp) :: u_ratio = 4.0d0 ! u_{\infinity} / u_{-\infinity}
  real(dp) :: Y_O_i = 11.d0/12.d0 ! 1.d0 ! initial mass fraction of oxygen-rich stream
  real(dp) :: Y_F_i = 2.d0/3.d0 ! 1.d0 ! initial mass fraction of fuel-rich stream

  ! flags
  logical :: BUILDMAIN = .true. ! run the main loop?
  logical :: IGNITOR = .true. ! model h as an ignitor or monotonic
  logical :: KCONSTANT= .true. ! kappa is constant in the free streams or it varies as A/x

  ! stability
  real(dp) :: T_max_exp = 2500.d0 ! expected maximum temperature

  ! non-dimensional input variables
  real(dp) :: h_ratio = 1.5d0 ! h_{\infinity} / h_{-\infinity}
  real(dp) :: G = 5.d0 ! factor to ensure that the inital boundary layer thickness is smaller than the computational domain
  real(dp) :: G_ignitor = 0.1d0
  real(dp) :: h_max = 20.d0/3.d0 ! maxmimum normalized enthalpy (for ignitor)
  real(dp) :: xr = 0.15d0 ! position in x to begin a variation of A/x for kappa
  ! real(dp) :: Y1_yu = 1.d0 ! free stream composition of fluid 1 at y = yu
  ! real(dp) :: Y1_yl = 0.d0 ! free stream composition of fluid 1 at y = yl
  ! real(dp) :: Y2_yu = 0.d0 ! free stream composition of fluid 2 at y = yu
  ! real(dp) :: Y2_yl = 1.d0 ! free stream composition of fluid 2 at y = yl

  ! dimensional input variables
  ! fluid1 = O2
  ! fluid2 = C3H8
  ! fluid3 = CO2
  ! fluid4 = H20
  ! real(dp) :: cp1 = 988.d0 ! specific heat of fluid 1, [J/(kg K)]
  ! real(dp) :: cp2 = 1630.d0 ! specific heat of fluid 2, [J/(kg K)]
  real(dp) :: cp = 1309.d0 ! average specific heat of both fluids [J/(kg K)]
  real(dp) :: EA2 = 30.d0*4148.d0/0.044097d0 ! activation energy of propane in oxygen [J/kg]
  real(dp) :: nu1 = 0.2756d0 ! stoichiometric ratio of oxygen and propane
  real(dp) :: nu3 = 0.3340d0 ! stoichiometric ratio of co2 and propane
  real(dp) :: nu4 = 0.6120d0 ! stoichiometric ratio of h2o and propane
  real(dp) :: Q2 = 25.0d0 ! normalized heat term for the fuel
  real(dp) :: R2 = 188.5d0 ! gas constant for propane [J/kg K]
  real(dp) :: Tcrit1 = 154.55d0 ! critical temperature of fluid 1, [K]
  real(dp) :: Tcrit2 = 369.15d0 ! critical temperature of fluid 2, [K]
  real(dp) :: Tcrit3 = 304.15d0 ! critical temperature of fluid 3, [K]
  real(dp) :: Tcrit4 = 647.14d0 ! critical temperature of fluid 4, [K]
  real(dp) :: Vcrit1 = 0.0025d0 ! critical volume of fluid 1, [m3/kg]
  real(dp) :: Vcrit2 = 0.0045d0 ! critical volume of fluid 2, [m3/kg]
  real(dp) :: Vcrit3 = 0.0021d0 ! critical volume of fluid 3, [m3/kg]
  real(dp) :: Vcrit4 = 0.0052d0 ! critical volume of fluid 4, [m3/kg]
  real(dp) :: W1 = 0.032d0 ! molecular weight of fluid 1, [kg/mol]
  real(dp) :: W2 = 0.044d0 ! molecular weight of fluid 2, [kg/mol]
  real(dp) :: W3 = 0.044d0 ! molecular weight of fluid 3, [kg/mol]
  real(dp) :: W4 = 0.018d0 ! molecular weight of fluid 4, [kg/mol]

  ! THINGS CALCULATED AFTER THE INPUTS:
  ! logging parameters (do not edit)
  integer, parameter :: nxi = ceiling(xf/Dxi) + 1 ! number of points in x (initial guess)
  integer, parameter :: j_log = ceiling(real(nxi)/real(nx_log))
  integer, parameter :: nx = j_log*nx_log ! number of points in x
  real(dp), parameter :: Dx = xf/(nx-1)
  integer, parameter :: ny = ceiling((yu - yl)/Dyi) + 1 ! number of points in x
  real(dp), parameter :: Dy = (yu - yl)/(ny-1)

  ! flags
  logical :: BREAKLOOP = .true.
  logical :: STABLEDOMAIN = .true.

  ! scalars
  real(dp) :: A_yu ! coefficient for kappa in upper free stream
  real(dp) :: A_yl ! coefficient for kappa in lower free stream
  integer :: FILE = 1 ! file number
  real(dp) :: h_yu ! enthalpy in upper free stream
  real(dp) :: h_yl ! enthalpy in lower free stream
  integer :: i ! loop index
  integer :: j = 1 ! loop index
  integer :: j_fail ! index where calculations fail
  integer :: log_count = 2
  real(dp) :: mu_ref ! \mu at y = yu
  real(dp) :: rho_ratio ! rho_{\infinity} / rho_{-\infinity}
  real(dp) :: u_yu ! x-velocity in upper free stream
  real(dp) :: u_yl ! x-velocity in lower free stream
  integer :: xr_ind ! index for xr

  ! vectors (add 1 to nx_log to store initial value)
  real(dp) :: fstar(nx)
  real(dp) :: fstar_log(nx_log + 1,1)
  real(dp) :: ScalarSave(50,1) ! vector to save scalar values
  real(dp) :: x(nx) ! vector of x values
  real(dp) :: x_log(nx_log + 1,1)
  real(dp) :: y(ny) ! vector of y values
  real(dp) :: y_log(ny,1)

  ! arrays (add 1 to nx_log to store initial value)
  real(dp) :: h(ny,2) ! enthalpy
  real(dp) :: h_log(ny,nx_log + 1)
  real(dp) :: K(ny,2) ! kappa
  real(dp) :: K_log(ny,nx_log + 1)
  real(dp) :: mu(ny,2) ! viscosity
  real(dp) :: mu_log(ny,nx_log + 1)
  real(dp) :: rho(ny,2) ! density
  real(dp) :: rho_log(ny,nx_log + 1)
  real(dp) :: T(ny,2) ! dimenstional temperature [K]
  real(dp) :: T_log(ny,nx_log + 1)
  real(dp) :: u(ny,2) ! velocity in the x-direction
  real(dp) :: u_log(ny,nx_log + 1)
  real(dp) :: v(ny,2) ! velocity in the y-direction
  real(dp) :: v_log(ny,nx_log + 1)
  real(dp) :: wF(ny,2) ! reaction rate of fuel
  real(dp) :: wF_log(ny,nx_log + 1)
  real(dp) :: Y1(ny,2) ! mass fraction of fluid 1
  real(dp) :: Y1_log(ny,nx_log + 1)
  real(dp) :: Y2(ny,2) ! mass fraction of fluid 2
  real(dp) :: Y2_log(ny,nx_log + 1)
  real(dp) :: Y3(ny,2) ! mass fraction of fluid 3
  real(dp) :: Y3_log(ny,nx_log + 1)
  real(dp) :: Y4(ny,2) ! mass fraction of fluid 4
  real(dp) :: Y4_log(ny,nx_log + 1)

end module global
