% calculate /int{wF}

wF_int = zeros(Ny,Nx);

for j_ind = 1:Nx
    for i = Ny-1:-1:1
        wF_int(i,j_ind) = trapz(yvector(Ny:-1:i),rho(Ny:-1:i,j_ind).*abs(wF(Ny:-1:i,j_ind)));
    end
end