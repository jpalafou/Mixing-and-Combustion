clear
clc
close all

n = 5;
exPath = '/Users/jonathan/Google Drive/My Drive/Spring 2022/199 research/plots/reactive/main/';

run getPlotProperties.m

% load data
load('/Users/jonathan/Documents/DataDump/MATLAB/reactive/main/base3.mat')

% change to directory than contains plotchop()
cd /Users/jonathan/Documents/GitHub/Mixing-and-Combustion-2.0/MATLAB/

% make plots
plotchop(1,u,xvector,yvector,n,'u*',[-4 7],'no legend')

plotchop(2,v,xvector,yvector,n,'v*',[-4 7],'no legend')

plotchop(3,T,xvector,yvector,n,'T [K]',[-7.5 8],'no legend')

plotchop(4,K,xvector,yvector,n,'\kappa*',[-4 8])

plotchop(5,Y1,xvector,yvector,n,'Y_O',[-3 8],'no legend')

plotchop(6,Y2,xvector,yvector,n,'Y_F',[-4 3],'no legend')

plotchop(7,wF(:,300:end),xvector(300:end),yvector,n,'\omega_F*',[-0.5,3.2])

plotchop(8,wF_int(:,300:end),xvector(300:end),yvector,n,'\int_0^{y*} \omega_F* dy*',[-0.5,3.2])

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