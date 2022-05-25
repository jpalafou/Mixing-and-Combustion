clear
clc
close all

n = 5;
exPath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/reactive/main/';

run getPlotProperties.m

% load data
load('/Users/jonathan/Documents/DataDump/MATLAB/reactive/main/base5.mat')

% change to directory than contains plotchop()
cd /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/

j = 1000;
% make plots
plotchop(1,u(:,1:j),xvector(1:j),yvector,n,'u*',[-4 7])

plotchop(2,v(:,1:j),xvector(1:j),yvector,n,'v*',[-4 7],'no legend')

plotchop(3,T(:,1:j),xvector(1:j),yvector,n,'T [K]',[-7.5 8],'no legend')

plotchop(4,K(:,1:j),xvector(1:j),yvector,n,'\kappa*',[-4 8],'no legend')

plotchop(5,Y1(:,1:j),xvector(1:j),yvector,n,'Y_O',[-3 8],'no legend')

plotchop(6,Y2(:,1:j),xvector(1:j),yvector,n,'Y_F',[-4 3],'no legend')

plotchop(7,abs(wF(:,300:j)),xvector(300:j),yvector,n,'\omega_F*',[-0.5,3.2])

plotchop(8,wF_int(:,300:j),xvector(300:j),yvector,n,'\int_0^{y*} \omega_F* dy*',[-0.5,3.2])

% edit y labels
figure(7)
ylabel('$|\dot{\omega^*}_F|$','interpreter','latex')

figure(8)
ylabel('$\int_{-\infty}^{y^*} \rho^* |\dot{\omega}^*_F| dy^*$','interpreter','latex')

% save plots
saveas(1,strcat(exPath,'u.png'))
saveas(2,strcat(exPath,'v.png'))
saveas(3,strcat(exPath,'T.png'))
saveas(4,strcat(exPath,'K.png'))
saveas(5,strcat(exPath,'Y_O.png'))
saveas(6,strcat(exPath,'Y_F.png'))
saveas(7,strcat(exPath,'wF.png'))
saveas(8,strcat(exPath,'wF_int.png'))

cd 'plot generation'/