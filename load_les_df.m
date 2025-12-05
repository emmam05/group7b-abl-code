% generate vertical profile of variable at time for LES data
function [data_table] = load_les_df(indir_les)    
    
    % initialise 
    data_table = table;
    data_arr = [];

    % set column names 
    columns = {'zn', 'z', 'p', 'u', 'v', 'th', 'qv', 'rh', 'uw', 'vw', 'wth', 'k_m', 'k_h', 'lclf'};

    % set times to loop over
    time_vect = 1200:1200:51600; 

    for time = time_vect  
    
        % initialise k
        k = 1; 
    
        % set filename 
        filename_les = "diagnostics_ts_"+string(time)+".nc" ;
        
        % construct file path to specified file 
        filepath_les = indir_les+filename_les;

        % Load in a few selected variables 
        dtime = ncread(filepath_les, "time_series_60_60");
        
        % time to plot at - take end of file 
        time_ind = size(dtime,1);
        
        c = 1 ;
        data_arr = []; 

        for column = columns
    
          % convert out of cell format 
            column = cell2mat(column); 

            % set loadname for current column 

            if column == "th"
                loadname = "theta_mean";
        
            elseif column == "u"
                 loadname = "u_wind_mean";
        
            elseif column == "v"
                loadname = "v_wind_mean";
        
            elseif column == "qv"
                loadname = "vapour_mmr_mean";
        
            elseif column == "p"
                loadname = "prefn";
        
            elseif column == "rh"
                loadname = "rh_mean";
             
            elseif column == "uw"
                loadname = "uw_mean";
        
            elseif column == "vw"
                loadname = "vw_mean";
        
            elseif column == "k_m"
                loadname = "viscosity_coef_mean";  
        
            elseif column == "k_h"
                loadname = "diffusion_coef_mean";
        
            elseif column == "wth"
                loadname = "wtheta_ad_mean";
        
            elseif column == "wqv";
                loadname = "wqv_ad_mean";

            elseif column == "lclf";
                loadname = "liquid_cloud_fraction";

            elseif column == "z"
                 loadname = "z";

             elseif column == "zn"
                 loadname = "zn";
        
            else 
                error("Unreognised plotting variable! " + ...
                    "must be th, u, v, qv, ql, p, rh, uw, uv, wth, wqv, k_m or k_h!")
            end 
            
           
            % load plotting data
            curdata = ncread(filepath_les, loadname);

            if not(column == "zn" || column == "z")
                curdata = curdata(:,time_ind); 
            end 
    
            % make column of data frame 
             data_arr(:,c) = curdata;
             
            c=c+1; 
            
        end 

        % store data in a table, adding time column and column names 
        data_arr = array2table(data_arr, 'VariableNames', columns);
        data_arr.time = repelem([time], height(data_arr))' ;
        data_table = [data_table; data_arr];

    end 
   
end 
