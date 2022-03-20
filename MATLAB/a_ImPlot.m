clear
clc
close all

filenamepref = 'out_T';
myylabel = '';
n = 5; % number of curves per plot

PLOT = true;

InPath = '/Users/jonathan/Documents/DataDump/out_Fortran/';
global Nx
global Ny
global ENF
global kmax
global xvector
global yvector

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
kmax = ScalarSave(13);

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
    plotxchopnStar(A,1,n)
    ylabel(myylabel)
end

%% functions

%% plot n isox curves along y
function plotxchopnStar(A,fig,n)
global Nx
global kmax
global xvector
global yvector
LW = 4.0; % line width

% initialize legend
Legend = cell(n,1);

% initial colors
% color = parula(n);
color = parula(n+2);

% initialize plot
figure(fig)
set(0,'DefaultAxesFontSize',56)
hold on

% x vector coordinates to plot
plotInd = ceil(linspace(1,Nx,n));

LineCount = 1; % for solid dash dot pattern
for i = 1:n
    
    % for line type
    if LineCount == 1
        LineType = '-';
        LineCount = LineCount + 1;
    elseif LineCount == 2
        LineType = '--';
        LineCount = LineCount + 1;
    else
        LineType = ':';
        LineCount = 1;
    end
    
    plot(yvector, A(:,plotInd(i)), LineType, 'LineWidth', LW,'Color',color(i,:))
    
    Legend{i} = strcat("x* = ", num2str(round(xvector(plotInd(i)),2)));
end

% legend
legend(Legend,'Location','best','NumColumns',2)

% label y axis
xlabel('y*')

% grid on
grid on

end