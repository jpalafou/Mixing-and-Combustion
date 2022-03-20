clear
clc

InPath = '/Users/jonathan/Documents/DataDump/out_Fortran/';

%% import data
fprintf('Importing data...\n')

% import scalar variables
global kmax
global Ny
global ENF

ScalarSave = readfromfortran('out_ScalarSave.bin',50,1);

Nx = ScalarSave(1);
Ny = ScalarSave(2);
deltax = ScalarSave(3);
deltay = ScalarSave(4);
x0ind = ScalarSave(6);
F = ScalarSave(11);
ENF = ScalarSave(12);
kmax = ScalarSave(13);

fprintf('\tImported scalar parameters\n')

% import vectors
xvector = readfromfortran('out_x.bin',1,Nx);
yvector = readfromfortran('out_y.bin',1,Ny);
fvector = readfromfortran('out_fstar.bin',1,Nx);
fprintf('\tImported vector parameters\n')

%% import arrays as lists

h = readfromfortran('out_h.bin',Ny,Nx);
mu = readfromfortran('out_mu.bin',Ny,Nx);
K = readfromfortran('out_K.bin',Ny,Nx);
rho = readfromfortran('out_rho.bin',Ny,Nx);
T = readfromfortran('out_T.bin',Ny,Nx);
u = readfromfortran('out_u.bin',Ny,Nx);
v = readfromfortran('out_v.bin',Ny,Nx);
wF = readfromfortran('out_wF.bin',Ny,Nx);
Y1 = readfromfortran('out_Y1.bin',Ny,Nx);
Y2 = readfromfortran('out_Y2.bin',Ny,Nx);
Y3 = readfromfortran('out_Y3.bin',Ny,Nx);
Y4 = readfromfortran('out_Y4.bin',Ny,Nx);
fprintf('\tImported scalar parameters\n')
fprintf('Done!\n')
