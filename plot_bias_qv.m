% function to plot error or percentage error in water vapour mixing ratio
function[] = plot_bias_qv(our_data, les_data, times_to_plot)

    hold off; 

    % set plotting styles 
    linestyle_vect = {['-'], ['--'], ['-.'], [':']};
    color_vect = {'k', 'k', 'k', '#00468b', '#00468b', '#00468b'};

    % count variable 
    k = 1;

    % loop over specified times 
    for time = times_to_plot
        
        % filter data based on time to plot 
        our_curdata = our_data(our_data.time == time,:);
        les_curdata = les_data(les_data.time == time,:);

        % interpolate qv onto les and 1dbl z levels 
        our_curdata.interpolated_qv = interp1(les_curdata.z, 1000*les_curdata.qv, our_curdata.z);
        les_curdata.interpolated_qv = interp1(our_curdata.z, our_curdata.qv, les_curdata.z);
        
        % calcualte error 
        %our_curdata.bias_qv = 100.*(our_curdata.qv - our_curdata.interpolated_qv)./our_curdata.interpolated_qv;
        our_curdata.bias_qv = our_curdata.qv - our_curdata.interpolated_qv;
        les_curdata.bias_qv = -les_curdata.qv + les_curdata.interpolated_qv;

        % plot data 
        plot( ...
            our_curdata.bias_qv, ...
            our_curdata.z, ...
            'DisplayName', strcat(string(time), 's'), ...
            'LineWidth', 2, ...
            'LineStyle', linestyle_vect{mod(k-1, length(linestyle_vect))+1}, ...
            'color', color_vect{mod(k-1, length(color_vect))+1} ...
            )
        hold on; 

        k = k+1; 
    end 
    
    % set axis title and label 
    %xlabel('Percentage error of qv [%]');
    xlabel('Error [Wm-2]');
    ylabel('Height [m]');
    %title('Profiles of percentage error in 1DBL water vapour mixing ratio')
    title('Profiles of error in 1DBL water vapour mixing ratio')
    legend(); 

end 