! a module to write data to a binary file
module export
  use global
  implicit none

  contains
    subroutine binwritef(A,filename)
      character(len=*), intent(in) :: filename
      real(dp), intent(in) :: A(:,:)

      open(unit=100,file=OutPath//filename,status='replace',access='stream',&
      form='unformatted')
      write(100)A
    end subroutine binwritef

    subroutine datadump()
      ! file names as character arrays
      character filename_h*25
      character filename_K*25
      character filename_mu*25
      character filename_rho*25
      character filename_T*25
      character filename_u*25
      character filename_v*25
      character filename_wF*25
      character filename_Y1*25
      character filename_Y2*25
      character filename_Y3*25
      character filename_Y4*25

      ! assign file names and file number to filenames
      write(filename_h, '(A)') 'out_h.bin'
      write(filename_K, '(A)') 'out_K.bin'
      write(filename_mu, '(A)') 'out_mu.bin'
      write(filename_rho, '(A)') 'out_rho.bin'
      write(filename_T, '(A)') 'out_T.bin'
      write(filename_u, '(A)') 'out_u.bin'
      write(filename_v, '(A)') 'out_v.bin'
      write(filename_wF, '(A)') 'out_wF.bin'
      write(filename_Y1, '(A)') 'out_Y1.bin'
      write(filename_Y2, '(A)') 'out_Y2.bin'
      write(filename_Y3, '(A)') 'out_Y3.bin'
      write(filename_Y4, '(A)') 'out_Y4.bin'

      ! save files
      call binwritef(h_log,filename_h)
      call binwritef(K_log,filename_K)
      call binwritef(mu_log,filename_mu)
      call binwritef(rho_log,filename_rho)
      call binwritef(T_log,filename_T)
      call binwritef(u_log,filename_u)
      call binwritef(v_log,filename_v)
      call binwritef(Y1_log,filename_Y1)
      call binwritef(Y2_log,filename_Y2)
      call binwritef(Y3_log,filename_Y3)
      call binwritef(Y4_log,filename_Y4)
      call binwritef(wF_log,filename_wF)
    end subroutine datadump

    subroutine reset_arrays()
      h(:,1) = h(:,2)
      h(:,2) = 0.d0

      K(:,1) = K(:,2)
      K(:,2) = 0.d0

      mu(:,1) = mu(:,2)
      mu(:,2) = 0.d0

      rho(:,1) = rho(:,2)
      rho(:,2) = 0.d0

      T(:,1) = T(:,2)
      T(:,2) = 0.d0

      u(:,1) = u(:,2)
      u(:,2) = 0.d0

      v(:,1) = v(:,2)
      v(:,2) = 0.d0

      wF(:,1) = wF(:,2)
      wF(:,2) = 0.d0

      Y1(:,1) = Y1(:,2)
      Y1(:,2) = 0.d0

      Y2(:,1) = Y2(:,2)
      Y2(:,2) = 0.d0

      Y3(:,1) = Y3(:,2)
      Y3(:,2) = 0.d0

      Y4(:,1) = Y4(:,2)
      Y4(:,2) = 0.d0
    end subroutine reset_arrays

    subroutine update_logs(n)
      integer, intent(in) :: n

      h_log(:,n) = h(:,2)
      K_log(:,n) = K(:,2)
      mu_log(:,n) = mu(:,2)
      rho_log(:,n) = rho(:,2)
      T_log(:,n) = T(:,2)
      u_log(:,n) = u(:,2)
      v_log(:,n) = v(:,2)
      wF_log(:,n) = wF(:,2)
      x_log(n,1) = x(j+1)
      fstar_log(n,1) = fstar(j+1)
      Y1_log(:,n) = Y1(:,2)
      Y2_log(:,n) = Y2(:,2)
      Y3_log(:,n) = Y3(:,2)
      Y4_log(:,n) = Y4(:,2)

    end subroutine update_logs

end module export
