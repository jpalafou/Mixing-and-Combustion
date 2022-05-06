% calculate eta

eta = zeros(Ny,Nx);

Ny0 = 1;
err = abs(yvector(Ny0)-0);
for i = 1:Ny
    if abs(yvector(i)-0) < err
        Ny0 = i;
        err = abs(yvector(Ny0)-0);
    end
end

for j = 1:Nx
    for i = Ny0-1:-1:1
        eta(i,j) = trapz(yvector(Ny0:-1:i),rho(Ny0:-1:i,j))/sqrt(2*xvector(j));
    end

    for i = Ny0+1:Ny
        eta(i,j) = trapz(yvector(Ny0:i),rho(Ny0:i,j))/sqrt(2*xvector(j));
    end
end