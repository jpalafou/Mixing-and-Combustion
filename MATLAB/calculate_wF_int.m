% calculate /int{wF}

wF_int = zeros(Ny,Nx);

Ny0 = 1;
err = abs(yvector(Ny0)-0);
for i = 1:Ny
    if abs(yvector(i)-0) < err
        Ny0 = i;
        err = abs(yvector(Ny0)-0);
    end
end

for j_ind = 1:Nx
    for i = Ny0-1:-1:1
        wF_int(i,j_ind) = trapz(yvector(Ny0:-1:i),wF(Ny0:-1:i,j_ind));
    end

    for i = Ny0+1:Ny
        wF_int(i,j_ind) = trapz(yvector(Ny0:i),wF(Ny0:i,j_ind));
    end
end