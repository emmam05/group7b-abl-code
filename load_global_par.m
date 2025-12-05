% function to plot 1d global variables from first line of .dat files
% over entire simulation 

function[data_vect] = load_global_par(indir_1dbl, plot_var)

    % initialise vectors to store time and ticklabels 
    data_vect = [];
    time_lab_vect = {};

    % counter 
    k=1;
    
% loop over all possible times from output file
    for time = 1200:1200:51600
        
        % set filename given ime imput
        filename_1dbl = "arm_shcu_t_"+string(time)+".dat" ;
        
        % construct file path to specified file 
        filepath_1dbl = indir_1dbl+filename_1dbl;
       
        % set plotting x label
        if plot_var == "u_star"
            var_ind = 1;
    
        elseif plot_var == "w_star"
             var_ind = 2;
    
        elseif plot_var == "l_obuk"
            var_ind = 3;
    
        elseif plot_var == "h_bl"
            var_ind = 4; 
    
        elseif plot_var == "th_surf"
            var_ind = 5; 
    
        elseif plot_var == "wth"
            var_ind = 6; 
         
        elseif plot_var == "wq"
            var_ind = 7;

        elseif plot_var == "cl_h"
            var_ind = 8;

        else 
            error("unrecognised plot_var ! ")

        end
        
        % load 1DBL data
        lines = readlines(filepath_1dbl);
       
        % store rest of data in matrix 
        data = str2double(split(lines(1)));
        data = data(~isnan(data));
        %disp(data(var_ind))

        % extract appropriate data point 
        data_vect(k) = data(var_ind); 

        % add count 
        k=k+1;

    end 
    
end 
    
