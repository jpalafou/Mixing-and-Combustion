! define boundary conditions for all parameters
module BC
  use global
  use dimqua
  implicit none

contains
  ! define boundayr conditions
  subroutine build_BCs(j)
    integer, intent(in) :: j
    ! constant boundar conditions
    h(1,2) = h(1,1)
    h(ny,2) = h(ny,1)

    u(1,2) = u(1,1)
    u(ny,2) = u(ny,1)

    Y1(1,2) = Y1(1,1)
    Y1(ny,2) = Y1(ny,1)

    Y2(1,2) = Y2(1,1)
    Y2(ny,2) = Y2(ny,1)

    ! boundary conditions as a function of x
    if (x(j) > xr .and. .not. KCONSTANT) then
      fstar(j) = F/x(j)
      K(1,2) = A_yu/x(j)
      K(ny,2) = A_yl/x(j)
    else
      fstar(j) = fstar(j-1)
      K(1,2) = K(1,1)
      K(ny,2) = K(ny,1)
    end if

  end subroutine build_BCs

end module BC
