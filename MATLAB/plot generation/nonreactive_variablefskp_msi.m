close all

impath = '/Users/jonathan/Documents/DataDump/MATLAB/nonreactive variable fs kappa/mesh size independence/';
expath = '/Users/jonathan/Google Drive/My Drive/Winter 2022/research/plots/nonreactive variable fs kappa/mesh size independence/';
files = {'6000 349.mat', '12000 495.mat'};
run getPlotProperties.m
Ylim = [-1 1.5];

% kappa vs y
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('\kappa*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

i = 1;
load(strcat(impath,files{i}))
    
figure(1)
plot(yvector,kappa{1}(:,1),'LineWidth',lineWidth)
plot(yvector,kappa{1}(:,ceil(kmax/2)),'LineWidth',lineWidth)
plot(yvector,kappa{1}(:,end),'LineWidth',lineWidth)
deltax1 = deltax;

i = 2;
load(strcat(impath,files{i}))
    
figure(1)
plot(yvector,kappa{1}(:,1),'--','LineWidth',lineWidth)
plot(yvector,kappa{1}(:,ceil(kmax/2)),'--','LineWidth',lineWidth)
plot(yvector,kappa{1}(:,end),'--','LineWidth',lineWidth)
deltax2 = deltax;

figure(1)
lgd = legend(strcat('x*=0.0, \Deltax = ',num2str(deltax1)), 'x*=0.5', 'x*=1.0',...
    strcat('x*=0.0, \Deltax = ',num2str(deltax2)), 'x*=0.5', 'x*=1.0',...
    'location','best');
lgd.FontSize = 42;
saveas(1,strcat(expath,'msi_kappa.png'))