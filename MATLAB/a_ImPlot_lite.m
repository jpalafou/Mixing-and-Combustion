% clear
% clc
% close all

% InPath = '/Users/jonathan/Documents/DataDump/reactive base 3/';
% filenamepref = 'out_wF';

% PLOT = true;
myylabel = '';
n = 5; % number of curves per plot
ylims = [-0.2 3.1];

run 'plot generation'/getPlotProperties.m

%% import data
fprintf('Importing data...\n')

% import scalar variables
ScalarSave = readfromfortran('out_ScalarSave.bin',50,1);

Nx = ScalarSave(1);
Ny = ScalarSave(2);
deltax = ScalarSave(3);
deltay = ScalarSave(4);
x0ind = ScalarSave(6);
F = ScalarSave(11);
ENF = ScalarSave(12);

fprintf('\tImported scalar parameters\n')

% import vectors
xvector = readfromfortran('out_x.bin',1,Nx);
yvector = readfromfortran('out_y.bin',1,Ny);
fvector = readfromfortran('out_fstar.bin',1,Nx);
fprintf('\tImported vector parameters\n')

% import arrays as list
A = readfromfortran(strcat(filenamepref,'.bin'),Ny,Nx);
fprintf('\tImported array as list\n')
fprintf('Data imported successfully!\n\n')

%% plotting
if PLOT
    plotchop(1,A(:,300:end),xvector(300:end),yvector,n,myylabel,ylims)
end