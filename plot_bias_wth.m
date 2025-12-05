% function to plot error or percentage error in heat flux 
function[] = plot_bias_wth(our_data, les_data, times_to_plot)

    hold off; 

    % set plotting styles 
    linestyle_vect = {['-'], ['--'], ['-.'], [':']};
    color_vect = {'k', 'k', 'k', '#00468b', '#00468b', '#00468b'};

    % count 
    k = 1;

    % loop over specified times 
    for time = times_to_plot
        
        % filter data based on time to plot 
        our_curdata = our_data(our_data.time == time,:);
        les_curdata = les_data(les_data.time == time,:);
   
        % interpolate heat flux onto 1dbl z levles and les z levels 
        our_curdata.interpolated_wth = interp1(les_curdata.z, les_curdata.wth, our_curdata.z);
        les_curdata.interpolated_wth = interp1(our_curdata.z, our_curdata.wth, les_curdata.z);
        
        % calcualte error / percentage error 
%         our_curdata.bias_wth = 100.*(our_curdata.wth - our_curdata.interpolated_wth)./our_curdata.interpolated_wth;
         our_curdata.bias_wth = our_curdata.wth - our_curdata.interpolated_wth;
        les_curdata.bias_wth = -les_curdata.wth + les_curdata.interpolated_wth;

        % plot data 
        plot( ...
            our_curdata.bias_wth, ...
            our_curdata.z, ...
            'DisplayName', strcat(string(time), 's'), ...
            'LineWidth', 2, ...
            'LineStyle', linestyle_vect{mod(k-1, length(linestyle_vect))+1}, ...
            'color', color_vect{mod(k-1, length(color_vect))+1} ...
            )

        hold on; 
        k = k+1; 
    end 
    
    % set axis labels and title 
%     xlabel('Percentage error of heat flux [%]');
    xlabel('Error [Wm-2]');
    ylabel('Height [m]');
%     title('Profiles of percentage error in 1DBL heat flux')
    title('Profiles of error in 1DBL heat flux')
    legend(); 

end 