% function to plot the error or percentage error in our model's theta
% output
function[] = plot_bias_th(our_data, les_data, times_to_plot)

    hold off; 

    % set colour and linestyles for plotting data 
    linestyle_vect = {['-'], ['--'], ['-.'], [':']};
    color_vect = {'k', 'k', 'k', '#00468b', '#00468b', '#00468b'};

    % count 
    k = 1;

    % loop over specified plotting times 
    for time = times_to_plot
        
        % filter data based on time to plot 
        our_curdata = our_data(our_data.time == time,:);
        les_curdata = les_data(les_data.time == time,:);

        % interpolate potential temperature profiles onto the same z levels
        our_curdata.interpolated_th = interp1(les_curdata.z, les_curdata.th, our_curdata.z);
        les_curdata.interpolated_th = interp1(our_curdata.z, our_curdata.th, les_curdata.z);
        
        % calcualte error/ percentage error in our data 
        our_curdata.bias_th = 100.*(our_curdata.th - our_curdata.interpolated_th)./our_curdata.interpolated_th;
        les_curdata.bias_th = -les_curdata.th + les_curdata.interpolated_th;

        % plot profiles of height against error 
        plot( ...
            our_curdata.bias_th, ...
            our_curdata.z, ...
            'DisplayName', strcat(string(time), 's'), ...
            'LineWidth', 2, ...
            'LineStyle', linestyle_vect{mod(k-1, length(linestyle_vect))+1}, ...
            'color', color_vect{mod(k-1, length(color_vect))+1} ...
            )

        hold on;
        k = k+1; 
    end 
    
    % axis labels, title etc
    xlabel('Percentage error of potential temperature [%]');
    ylabel('Height [m]');
    title('Profiles of percentage error in 1DBL potential temperature')
    legend(); 

end 