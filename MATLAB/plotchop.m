function plotchop(figurenumber,A,xvector,yvector,n,myylabel,ylims,makeleg)
    global lineWidth
    global fontSize
    global gridlineWidth
    
    % check dimension mismatch
    [ny_A, nx_A] = size(A);
    if numel(xvector) ~= nx_A
        disp('[ERROR] dimension mismatch, x')
        return
    end
    if numel(yvector) ~= ny_A
        disp('[ERROR] dimension mismatch, y')
        return
    end
    
    % initialize legend
    Legend = cell(n,1);
    
    % initialize colors
    color = parula(n+2);
    
    % initialize plot
    figure(figurenumber)
    set(gcf, 'Position', get(0, 'Screensize'),'DefaultAxesFontSize',fontSize)
    hold on
    ax = gca;
    ax.LineWidth = gridlineWidth;
    
    % x vector coordinates to plot
    plotInd = ceil(linspace(1,numel(xvector),n));
    
    LineCount = 1; % for solid dash dot pattern
    for i = 1:n
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

        plot(yvector, A(:,plotInd(i)), LineType, 'LineWidth', lineWidth,'Color',color(i,:))

        Legend{i} = strcat("x* = ", num2str(round(xvector(plotInd(i)),2)));
    end
    
    % legend
    if nargin <= 7
        legend(Legend,'Location','best')
    end
    
    % label x axis
    xlabel('y*')
    
    % grid on
    grid on
    
    % y label
    if nargin > 5
        ylabel(myylabel)
    end
    
    % x bounds
    if nargin > 6
        xlim(ylims)
    end
end