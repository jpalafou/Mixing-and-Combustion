close all

impath = '/Users/jonathan/Documents/DataDump/MATLAB/nonreactive variable fs kappa/main/';
expath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/nonreactive variable fs kappa/main/-A/';
files = {'0.mat', '1.mat', '2.mat'};
run getPlotProperties.m
Ylim = [-5 5];

% kappa vs y
figure(1)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
ylabel('\kappa*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

% v vs y
figure(2)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
ylabel('v*')
grid on
hold on
ax = gca;
ax.LineWidth = gridlineWidth;
xlim([Ylim(1) Ylim(2)])

load(strcat(impath, '-A.mat'))
global kmax
global Nx
global xvector
global yvector

plotxchopnStar(kappa,1,5,0,fontSize,lineWidth,gridlineWidth)

plotxchopnStar(v,2,5,1,fontSize,lineWidth,gridlineWidth)

figure(1)
saveas(1,strcat(expath,'kappa.png'))

figure(2)
saveas(2,strcat(expath,'v.png'))


%% functions
%% plot n isox curves along y
function plotxchopnStar(A,fig,n,leg,fontSize,lineWidth,gridlineWidth)
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
set(0,'DefaultAxesFontSize',fontSize)
ax = gca;
ax.LineWidth = gridlineWidth;
hold on

% x vector coordinates to plot
plotInd = ceil(linspace(1,Nx,n));

LineCount = 1; % for solid dash dot pattern
for i = 1:n
    file = 1;
    while plotInd(i) > file*kmax
        file = file + 1;
    end
    j = plotInd(i) - ((file-1)*kmax);
    
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
    
    plot(yvector, A{file}(:,j), LineType, 'LineWidth', lineWidth,'Color',color(i,:))
    

    Legend{i} = strcat("x* = ", num2str(round(xvector(plotInd(i)),2)));
end

% legend
if leg
    legend(Legend,'Location','best','NumColumns',2)
end
    
% label y axis
xlabel('y*')

% grid on
grid on

end