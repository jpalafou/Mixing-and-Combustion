close all

expath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/reactive/mesh size independence/';

% filenamepref = 'out_T';
% savename = 'msi_T.png';
% Ylab = 'T [K]';
% Ylim = [-8 8];
% loc = 'northwest';
% fracs = [1e-3 0.5 1];

filenamepref = 'out_wF';
savename = 'msi_wF.png';
Ylab = '$|\dot{\omega^*}_F|$';
Ylim = [0 3.6];
loc = 'best';
fracs = [0.5 0.75 1];

run getPlotProperties.m

% kappa vs y
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
if Ylab(1) == '$'
    ylabel(Ylab,'interpreter','latex')
else
    ylabel(Ylab)
end
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])


%% case 1
InPath = '/Users/jonathan/Documents/DataDump/reactive 3 20000000 1701/';
run /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,ceil(fracs(1)*Nx))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(2)*Nx))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(3)*Nx))),'LineWidth',lineWidth)
deltax1 = deltax;

%% case 2
InPath = '/Users/jonathan/Documents/DataDump/reactive 3 40000000 1701/';
run /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,ceil(fracs(1)*Nx))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(2)*Nx))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(3)*Nx))),'--','LineWidth',lineWidth)
deltax2 = deltax;

%% prepare plot for save
figure(1)
lgd = legend(strcat('x*=', num2str(xvector(ceil(fracs(1)*Nx)),'%.2f'), ...
    ', \Deltax = ',num2str(deltax1)), ... 
    strcat('x*=', num2str(xvector(ceil(fracs(2)*Nx)),'%.2f')), ...
    strcat('x*=', num2str(xvector(ceil(fracs(3)*Nx)),'%.2f')), ...
    strcat('x*=', num2str(xvector(ceil(fracs(1)*Nx)),'%.2f'), ...
    ', \Deltax = ',num2str(deltax2)), ...
    strcat('x*=', num2str(xvector(ceil(fracs(2)*Nx)),'%.2f')), ...
    strcat('x*=', num2str(xvector(ceil(fracs(3)*Nx)),'%.2f')), ...
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