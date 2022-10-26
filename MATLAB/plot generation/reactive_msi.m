close all

expath = '~/Downloads/';

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
InPath = '~/Google Drive/My Drive/Sirignano paper/resources/DataDump/reactive 3 20000000 1701/';
run ~/Desktop/Mixing-and-Combustion/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,ceil(fracs(1)*Nx))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(2)*Nx))),'LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(3)*Nx))),'LineWidth',lineWidth)
deltax1 = deltax;
deltay1 = deltay;
A1 = A;
solution_vector1_1 = A(:,ceil(fracs(1)*Nx));
solution_vector1_2 = A(:,ceil(fracs(2)*Nx));
solution_vector1_3 = A(:,ceil(fracs(3)*Nx));

% check stability criterion
disp((max(max(abs(A))) < 2/(deltay^2)) < 0.25/deltax)

%% case 2
InPath = '~/Google Drive/My Drive/Sirignano paper/resources/DataDump/reactive 3 40000000 1701/';
run ~/Desktop/Mixing-and-Combustion/MATLAB/a_ImPlot_lite.m
    
figure(1)
plot(yvector,abs(A(:,ceil(fracs(1)*Nx))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(2)*Nx))),'--','LineWidth',lineWidth)
plot(yvector,abs(A(:,ceil(fracs(3)*Nx))),'--','LineWidth',lineWidth)
deltax2 = deltax;
deltay2 = deltay;
A2 = A;
solution_vector2_1 = A(:,ceil(fracs(1)*Nx));
solution_vector2_2 = A(:,ceil(fracs(2)*Nx));
solution_vector2_3 = A(:,ceil(fracs(3)*Nx));

% check stability criterion
disp((max(max(abs(A))) < 2/(deltay^2)) < 0.25/deltax)

%% prepare plot for save
figure(1)
lgd = legend(strcat('x*=', num2str(xvector(ceil(fracs(1)*Nx)),'%.2f'), ...
    ', \Deltax = ',num2str(deltax1),', \Deltay = ',num2str(deltay1)), ... 
    strcat('x*=', num2str(xvector(ceil(fracs(2)*Nx)),'%.2f')), ...
    strcat('x*=', num2str(xvector(ceil(fracs(3)*Nx)),'%.2f')), ...
    strcat('x*=', num2str(xvector(ceil(fracs(1)*Nx)),'%.2f'), ...
    ', \Deltax = ',num2str(deltax2),', \Deltay = ',num2str(deltay2)), ...
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

%% calculate max error
differences1 = abs(solution_vector1_1 - solution_vector2_1);
max_err = max(differences1) / ...
    abs(solution_vector1_1(differences1 == max(differences1)));
fprintf('first x: the maximum local error for reaction rate is %f\n', max_err)
fprintf('first x: the maximum peak error for reaction rate is %f\n', ...
    max(differences1)/max(abs(solution_vector1_1)))
fprintf('\n')

differences2 = abs(solution_vector1_2 - solution_vector2_2);
max_err = max(differences2) / ...
    abs(solution_vector1_2(differences2 == max(differences2)));
fprintf('second x: the maximum local error for reaction rate is %f\n', max_err)
fprintf('first x: the maximum peak error for reaction rate is %f\n', ...
    max(differences2)/max(abs(solution_vector1_2)))
fprintf('\n')

differences3 = abs(solution_vector1_3 - solution_vector2_3);
max_err = max(differences3) / ...
    abs(solution_vector1_3(differences3 == max(differences3)));
fprintf('third x: the maximum local error for reaction rate is %f\n', max_err)
fprintf('first x: the maximum peak error for reaction rate is %f\n', ...
    max(differences3)/max(abs(solution_vector1_3)))
fprintf('\n')


% % overall all domain
% disp(max(max(abs(A1 - A2)/max(max(abs(A1))))))
% disp(mean(mean(abs(A1 - A2)))/max(max(abs(A1))))
% disp(mean(mean((A1 - A2).^2)))