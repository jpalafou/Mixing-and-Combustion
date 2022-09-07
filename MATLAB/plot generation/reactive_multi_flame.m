clear
clc
close all

n = 5;
% exPath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/reactive/multi flame/';
exPath = '/Users/jonathan/Desktop/plots/reactive/multi flame/';

run getPlotProperties.m

% load data
load('/Users/jonathan/Documents/DataDump/MATLAB/reactive/multi flame/Da 3000000 fine.mat')
j = 900;

% change to directory than contains plotchop()
cd /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/

% make plots
plotchop(1,u(:,1:j),xvector(1:j),yvector,n,'u*',[-5 8])

plotchop(2,v(:,1:j),xvector(1:j),yvector,n,'v*',[-6 8],'no legend')

plotchop(3,T(:,1:j),xvector(1:j),yvector,n,'T [K]',[-9 9],'no legend')

plotchop(4,K(:,1:j),xvector(1:j),yvector,n,'\kappa*',[-5 8],'no legend')

% plotchop(5,Y1(:,1:j),xvector(1:j),yvector,n,'Y_O',[-5 8],'no legend')
% 
% plotchop(6,Y2(:,1:j),xvector(1:j),yvector,n,'Y_F',[-5 8],'no legend')

%% begin mass fraction plot
n = 3;

Legend = cell(2*n,1);
color1 = parula(n+2);
color2 = copper(n+1);
figure(5)
set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
hold on
ax = gca;
ax.LineWidth = gridlineWidth;

plotInd = ceil(linspace(1,numel(xvector(1:j)),n));

LineCount = 1; % for solid dash dot pattern
for i = 1:2*n
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

    if i <= n
        plot(yvector, Y1(:,plotInd(i)), LineType, 'LineWidth', lineWidth,'Color',color1(i,:))
        Legend{i} = strcat("Y_O, x* = ", num2str(round(xvector(plotInd(i)),2)));
    else
        plot(yvector, Y2(:,plotInd(i - n)), LineType, 'LineWidth', lineWidth,'Color',color2(i-n+1,:))
        Legend{i} = strcat("Y_F, x* = ", num2str(round(xvector(plotInd(i - n)),2)));
    end
end

xlabel('y*')
grid on
xlim([-5 10])
lgd = legend(Legend,'Location','east');
lgd.FontSize = 56;

%% end mass fraciton plot
n = 5;

plotchop(6,abs(wF(:,100:j)),xvector(100:j),yvector,n,'\omega_F*',[-3.4 7.2])

% plotchop(8,wF_int(:,100:j),xvector(100:j),yvector,n,'\int_0^{y*} \omega_F* dy*',[-3.2 7])

% edit y labels
figure(6)
ylabel('$|\dot{\omega^*}_F|$','interpreter','latex')

% figure(8)
% ylabel('$\int_{-\infty}^{y^*} \rho^* |\dot{\omega}^*_F| dy^*$','interpreter','latex')

% save plots
saveas(1,strcat(exPath,'u.png'))
saveas(2,strcat(exPath,'v.png'))
saveas(3,strcat(exPath,'T.png'))
saveas(4,strcat(exPath,'K.png'))
saveas(5,strcat(exPath,'Y.png'))
saveas(6,strcat(exPath,'wF.png'))

cd 'plot generation'/