close all

impath = '/Users/jonathan/Documents/DataDump/MATLAB/nonreactive constant fs kappa/parameter study/uratio/';
expath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/nonreactive constant fs kappa/parameter study/uratio/';
files = {'2.mat', '4.mat', '8.mat'};
run getPlotProperties.m
Ylim = [-2 2.5];
lgd_size = 48;

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

    uratio = ScalarSave(7);
    
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
    pY1(j) = plot(yvector,Y1{end}(:,end),'LineWidth',lineWidth,'Color',col);
    pY2(j) = plot(yvector,Y2{end}(:,end),':','LineWidth',lineWidth,'Color',col);

    Legend1{j} = strcat("Y_{O}, u_\infty/u_{-\infty} = ", num2str(uratio));
    Legend2{j} = strcat("Y_{F}, u_\infty/u_{-\infty} = ", num2str(uratio));
end

figure(1)
lgd = legend('u_\infty/u_{-\infty} = 2','u_\infty/u_{-\infty} = 4','u_\infty/u_{-\infty} = 8','location','best');
lgd.FontSize = fontSize;
saveas(1,strcat(expath,'u.png'))

figure(2)
saveas(2,strcat(expath,'v.png'))

figure(3)
saveas(3,strcat(expath,'kappa.png'))

figure(4)
saveas(4,strcat(expath,'h.png'))

figure(5)
lgd1 = legend(pY1,Legend1,'location','east');
lgd1.FontSize = fontSize-32;
ah1=axes('position',get(gca,'position'),'visible','off');
lgd2 = legend(ah1,pY2,Legend2,'location','west');
lgd2.FontSize = fontSize-32;
lgd2.LineWidth = 3;
saveas(5,strcat(expath,'Y.png'))