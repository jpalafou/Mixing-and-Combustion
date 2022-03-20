close all

impath = '/Users/jonathan/Documents/DataDump/MATLAB/nonreactive constant fs kappa/parameter study/uratio/';
expath = '/Users/jonathan/Google Drive/My Drive/Winter 2022/research/plots/nonreactive constant fs kappa/parameter study/uratio/';
files = {'2.mat', '4.mat', '8.mat'};
run getPlotProperties.m
Ylim = [-2 2.5];
lgd_size = 56;

% u vs y
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('u*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

% v vs y
figure(2)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('v*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

% kappa vs y
figure(3)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('\kappa*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

% h vs y
figure(4)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('h*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

% Y1 and Y2 vs y
figure(5)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('Y_O, Y_F')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])


for j = 1:3
    load(strcat(impath,files{j}))
    
    switch j
        case 1
            col = color1;
        case 2
            col = color2;
        otherwise
            col = color3;
    end
    
    figure(1)
    plot(yvector,u{end}(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(2)
    plot(yvector,v{end}(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(3)
    plot(yvector,kappa{end}(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(4)
    plot(yvector,h{end}(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(5)
    plot(yvector,Y1{end}(:,end),'LineWidth',lineWidth,'Color',col);
    plot(yvector,Y2{end}(:,end),':','LineWidth',lineWidth,'Color',col);
end

figure(1)
saveas(1,strcat(expath,'u.png'))

figure(2)
saveas(2,strcat(expath,'v.png'))

figure(3)
saveas(3,strcat(expath,'kappa.png'))

figure(4)
lgd = legend('u_\infty/u_{-\infty} = 2','u_\infty/u_{-\infty} = 4','u_\infty/u_{-\infty} = 8','location','best');
lgd.FontSize = lgd_size;
saveas(4,strcat(expath,'h.png'))

figure(5)
lgd = legend('Y_{O}, u_\infty/u_{-\infty} = 2', ...
    'Y_{F}, u_\infty/u_{-\infty} = 2', ...
    'Y_{O}, u_\infty/u_{-\infty} = 4', ...
    'Y_{F}, u_\infty/u_{-\infty} = 4', ...
    'Y_{O}, u_\infty/u_{-\infty} = 8', ...
    'Y_{F}, u_\infty/u_{-\infty} = 8', ...
    'location','best');
lgd.FontSize = lgd_size; 
saveas(5,strcat(expath,'Y.png'))