! discretize domain into a mesh of x and y values
module meshgen
  use global
  implicit none
  integer :: m, n

contains
  subroutine meshgenxy()
    do m = 2, nx
      x(m) = x(m-1) + Dx
    end do

    y(1) = yu
    do n = 2, ny
      y(n) = y(n-1) - Dy
    end do

    y_log(:,1) = y

  end subroutine meshgenxy

end module meshgen
