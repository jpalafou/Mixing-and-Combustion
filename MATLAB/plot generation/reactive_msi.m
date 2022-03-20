close all

expath = '/Users/jonathan/Google Drive/My Drive/Winter 2022/research/plots/reactive/mesh size independence/';

filenamepref = 'out_T';
savename = 'msi_T.png';
Ylab = 'T [K]';
Ylim = [-8 8];
loc = 'northwest';
inds = [1, ceil(kmax/2), kmax];

% filenamepref = 'out_wF';
% savename = 'msi_wF.png';
% Ylab = '\omega*_2';
% Ylim = [0 5];
% loc = 'best';
% inds = [ceil(kmax/2), ceil(3*kmax/4), kmax];

run getPlotProperties.m

% kappa vs y
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel(Ylab)
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])


%% case 1
InPath = '/Users/jonathan/Documents/DataDump/reactive 3 1001000 451/';
run /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,inds(1))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,inds(2))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,end)),'LineWidth',lineWidth)
deltax1 = deltax;

%% case 2
InPath = '/Users/jonathan/Documents/DataDump/reactive 3 2001000 451/';
run /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,inds(1))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,inds(2))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,end)),'--','LineWidth',lineWidth)
deltax2 = deltax;

%% prepare plot for save
figure(1)
lgd = legend(strcat('x*=0.0, \Deltax = ',num2str(deltax1)), ... 
    'x*=1.5', ...
    'x*=3.0', ...
    strcat('x*=0.0, \Deltax = ',num2str(deltax2)), ...
    'x*=1.5', ...
    'x*=3.0', ...
    'location',loc);
% lgd = legend(strcat('x*=1.5, \Deltax = ',num2str(deltax1)), ... 
%     'x*=2.25', ...
%     'x*=3.0', ...
%     strcat('x*=1.5, \Deltax = ',num2str(deltax2)), ...
%     'x*=2.25', ...
%     'x*=3.0', ...
%     'location',loc);
lgd.FontSize = 36;
saveas(1,strcat(expath,savename))