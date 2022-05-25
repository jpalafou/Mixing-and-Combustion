clear
clc
close all

j1 = 401;
j2 = 601;
n = 5;
LegendFontSize = 64;
exPath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/nonreactive similarity/';

run getPlotProperties.m

% make plots

%% constant kappa

% load data
load('/Users/jonathan/Documents/DataDump/MATLAB/nonreactive constant fs kappa/similarity/base 25.mat')

% change to directory than contains plotchop()
cd /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/

%% u vs y constant kappa
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('u*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-2 2.5])
ylim([0.2 1.001])

plot(yvector,u(:,j1),'LineWidth',lineWidth)
plot(yvector,u(:,j2),'--','LineWidth',lineWidth)
lgd = legend(strcat('x* = ',num2str(xvector(j1))),...
    strcat('x* = ',num2str(xvector(j2))),...
    'location','best');
lgd.FontSize = fontSize;

%% u vs eta constant kappa
figure(2)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('\eta')
ylabel('u*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-0.75 0.75])
ylim([0.2 1.001])

plot(eta(:,j1),u(:,j1),'LineWidth',lineWidth)
plot(eta(:,j2),u(:,j2),'--','LineWidth',lineWidth)

%% h vs y constant kappa
figure(3)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('h*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-2 2.])

plot(yvector,h(:,j1),'LineWidth',lineWidth)
plot(yvector,h(:,j2),'--','LineWidth',lineWidth)

%% h vs eta constant kappa
figure(4)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('\eta')
ylabel('h*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-0.75 0.75])

plot(eta(:,j1),h(:,j1),'LineWidth',lineWidth)
plot(eta(:,j2),h(:,j2),'--','LineWidth',lineWidth)

%% variable kappa
% load data
load('/Users/jonathan/Documents/DataDump/MATLAB/nonreactive variable fs kappa/similarity/base 25.mat')

% change to directory than contains plotchop()
cd /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/

%% u vs y variable kappa
figure(5)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('u*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-7 8])
ylim([0.2 1.001])

plot(yvector,u(:,j1),'LineWidth',lineWidth)
plot(yvector,u(:,j2),'--','LineWidth',lineWidth)
lgd = legend(strcat('x* = ',num2str(xvector(j1))),...
    strcat('x* = ',num2str(xvector(j2))),...
    'location','best');
lgd.FontSize = fontSize;

%% u vs eta variable kappa
figure(6)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('\eta')
ylabel('u*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-2 2])
ylim([0.2 1.001])

plot(eta(:,j1),u(:,j1),'LineWidth',lineWidth)
plot(eta(:,j2),u(:,j2),'--','LineWidth',lineWidth)

%% h vs y variable kappa
figure(7)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('y*')
ylabel('h*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-7 8])

plot(yvector,h(:,j1),'LineWidth',lineWidth)
plot(yvector,h(:,j2),'--','LineWidth',lineWidth)

%% h vs eta variable kappa
figure(8)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
xlabel('\eta')
ylabel('h*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([-2 2])

plot(eta(:,j1),h(:,j1),'LineWidth',lineWidth)
plot(eta(:,j2),h(:,j2),'--','LineWidth',lineWidth)

%% save plots
saveas(1,strcat(exPath,'constant K u y.png'))
saveas(2,strcat(exPath,'constant K u eta.png'))
saveas(3,strcat(exPath,'constant K h y.png'))
saveas(4,strcat(exPath,'constant K h eta.png'))
saveas(5,strcat(exPath,'variable K u y.png'))
saveas(6,strcat(exPath,'variable K u eta.png'))
saveas(7,strcat(exPath,'variable K h y.png'))
saveas(8,strcat(exPath,'variable K h eta.png'))

cd 'plot generation'/