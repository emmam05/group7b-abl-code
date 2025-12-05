% function to plot 1d global variables from first line of .dat files
% over entire simulation 

function[] = plot_global_par(indir_1dbl, plot_var, name)

    % initialise vectors to store time and ticklabels 
    data_vect = [];
    time_lab_vect = {};

    % counter 
    k=1;
    
% loop over all possible times from output file
    for time = 1200:1200:51600
        
        % set xticklabel for time 
        time_lab_vect{k} = string(floor(time/3600))+":"+string(60*((time/3600)-floor(time/(3600))));

        % set filename given ime imput
        filename_1dbl = "arm_shcu_t_"+string(time)+".dat" ;
        
        % construct file path to specified file 
        filepath_1dbl = indir_1dbl+filename_1dbl;
       
        % set plotting x label
        if plot_var == "u_star"
            plot_ylab = "u star [m/s]";
            var_ind = 1;
            title_name = "u star";
    
        elseif plot_var == "w_star"
             plot_ylab = "w star [m/s]";
             var_ind = 2;
             title_name = "w star";
    
        elseif plot_var == "l_obuk"
            plot_ylab = "Obukov Length [m]";
            var_ind = 3;
            title_name = "Obukov Length";
    
        elseif plot_var == "h_bl"
            plot_ylab = "Boundary Layer Height [m]";
            var_ind = 4; 
            title_name = "boundary layer height";
    
        elseif plot_var == "th_surf"
            plot_ylab = "Surface Temperature [K]";
            var_ind = 5; 
            title_name = "surface temperature";
    
        elseif plot_var == "wth"
            plot_ylab = "Heat Flux at the Surface [W/m2]";
            var_ind = 6; 
            title_name = "surface heat flux";
         
        elseif plot_var == "wq"
            plot_ylab = "Vapour Flux at the Surface [kg/m2]";
            var_ind = 7;
            title_name = "water vapour flux";

        elseif plot_var == "cl_h"
            plot_ylab = "Height of Cloud Base [m]";
            var_ind = 8;
            title_name = "height of cloud base";

        else 
            error("unrecognised plot_var ! ")

        end
        
        % load 1DBL data
        lines = readlines(filepath_1dbl);
       
        % store rest of data in matrix 
        data = str2double(split(lines(1)));
        data = data(~isnan(data));
        disp(data(var_ind))

        % extract appropriate data point 
        data_vect(k) = data(var_ind); 

        % add count 
        k=k+1;

    end 

    % plotting 
    plot([1200:1200:51600], data_vect, 'Linewidth', 2, 'Displayname', name);
    xticks([3600:3600:51600]);
    xticklabels(time_lab_vect(3:3:end))
    xlabel("Time since start of simulation [h:min]");
    ylabel(plot_ylab)
    title("Evolution of "+title_name);
    
end 
    