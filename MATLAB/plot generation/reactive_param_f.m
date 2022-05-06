close all

impath = '/Users/jonathan/Documents/DataDump/MATLAB/reactive/parameter study/f/';
expath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/reactive/parameter study/f/';
files = {'0.mat', '1.mat', '2.mat'};
run getPlotProperties.m
Ylim = [-15 21];
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

% K vs y
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

% wf vs y
figure(6)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('|\omega*_F|')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-1.5 10])


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
    plot(yvector,u(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(2)
    plot(yvector,v(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(3)
    plot(yvector,K(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(4)
    plot(yvector,h(:,end),'LineWidth',lineWidth,'Color',col)
    
    figure(5)
    plot(yvector,Y1(:,end),'LineWidth',lineWidth,'Color',col);
    plot(yvector,Y2(:,end),':','LineWidth',lineWidth,'Color',col);
    
    figure(6)
    plot(yvector,abs(wF(:,end-5)),'LineWidth',lineWidth,'Color',col)
    
end

figure(1)
saveas(1,strcat(expath,'u.png'))

figure(2)
saveas(2,strcat(expath,'v.png'))

figure(3)
saveas(3,strcat(expath,'K.png'))

figure(4)
lgd = legend('f* = 0','f* = 1','f* = 2','location','best');
lgd.FontSize = lgd_size; 
saveas(4,strcat(expath,'h.png'))

figure(5)
lgd = legend('Y_{O}, f* = 0', ...
    'Y_{F}, f* = 0', ...
    'Y_{O}, f* = 1', ...
    'Y_{F}, f* = 1', ...
    'Y_{O}, f* = 2', ...
    'Y_{F}, f* = 2', ...
    'location','best');
lgd.FontSize = lgd_size; 
saveas(5,strcat(expath,'Y.png'))

figure(6)
saveas(6,strcat(expath,'wF.png'))
