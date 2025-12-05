% generate vertical profile plot of variable at time from 1dbl output 
function [] = plot_data_1dbl(indir_1dbl, time, plot_var, set_xlim, xlimmin, xlimmax, ylimmax, show_displayname, displayname, linestyle, color)    
    
    % set filename given ime imput
    filename_1dbl = "arm_shcu_t_"+string(time)+".dat" ;
    
    % construct file path to specified file 
    filepath_1dbl = indir_1dbl+filename_1dbl;

    % set vertical coord system, using zn as default 
    z_type = "z";
    plot_xlab = "Potential Temperature [K]";
    
    % set plotting x label
    if plot_var == "th"
        plot_xlab = "Potential Temperature [K]";
        z_type = "z";

    elseif plot_var == "u"
         plot_xlab = "Horizontal u wind [m/s]";
         z_type = "zn";

    elseif plot_var == "v"
        plot_xlab = "Horizontal v wind [m/s]";
        z_type = "zn";

    elseif plot_var == "qv"
        plot_xlab = "Water vapour mixing ratio [g/kg]";

    elseif plot_var == "ql"
        plot_xlab = "Liquid mixing ratio [g/kg]";

    elseif plot_var == "p"
        plot_xlab = "Pressure [K]";

    elseif plot_var == "rh"
        plot_xlab = "Relative Humidity [K]";
     
    elseif plot_var == "uw"
        plot_xlab = "Momentum Flux uw [m^2/s^2]";

    elseif plot_var == "vw"
        plot_xlab = "Momentum Flux vw [m^2/s^2]";

    elseif plot_var == "k_m"
        plot_xlab = "Eddy Viscosity km [K^2]";  

    elseif plot_var == "k_h"
        plot_xlab = "Thermal Diffusivity kh [K^2]" ; 

    elseif plot_var == "wth"
        plot_xlab = "Heat flux [W/m2]";

    % elseif plot_var == "wqv"
    %     plot_xlab = "Moisture flux [kg/m2]";

    else 
        error("Unreognised plotting variable! " + ...
            "must be th, u, v, qv, ql, p, rh, uw, uv, k_m or k_h!")
    end 
    
    % load 1DBL data
    lines = readlines(filepath_1dbl);
   
    % store rest of data in matrix 
    data_lines = lines(2:end);
    % end up with an array of strings, where each string is a row of the data
    % frame 
    data_lines = data_lines(~startsWith(strtrim(data_lines), '*') & strlength(strtrim(data_lines)) > 0);
    % strtrim removes white space at start and end of line 
    % one line in the file starts with a * so we remove this line 
    % and remove any empty lines too (found only at the bottom ofthe file)
    
    % convert data into toable so it can be used 
    data = str2double(split(data_lines));
    data = data(:, all(~isnan(data)));
    
    % create a table (MATLAB's version of Pandas DF)
    columns = {'zn', 'z', 'p', 'u', 'v', 'th', 'qv', 'ql', 'rh', 'uw', 'vw', 'wth', 'k_m', 'k_h', 'c_vis'};
    df = array2table(data(:, 1:15), 'VariableNames', columns);
    
    % zn height (m),z height (m), pressure (Pascals), u (m/s), v(m/s), Potential Temperature (K), vapour mixing
    %ratio (g/Kg), liquid mixing ratio, relative humidity,momentum uw fluxes, momentum vw fluxes, Sensible heat flux (buoyancy flux?), 
    % KM (momentum diffusivity/ eddy viscosity), KH (heat diffusivity) , cvis (turbulence coefficient).
    
    % head(df) % use to check that columns are aligned correctly !!! 

    % plot data from tabl, qv is easier to see if multiplied by 1000
    if show_displayname 
        plot(df, plot_var, z_type, ...
            'Linewidth',2, ...
            "DisplayName", "1DBL "+plot_var+" time="+string(time)+" "+displayname, ...
            'LineStyle', linestyle,...
            'Color', color );
            %             "DisplayName", "1DBL "+plot_var+", time="+string(time)+" "+displayname, ...
         %);
    else 
        plot(df, plot_var, z_type, ...
            'Linewidth',2, ...
            'LineStyle', linestyle,...
            'Color', color, ...
            'DisplayName', '1DBL');    
        %"DisplayName", "time="+string(time)+"s", ...);
    end

    % set limits, title and legend
    if set_xlim 
        xlim([xlimmin,xlimmax]); 
    end 
    xlabel(plot_xlab);
    ylabel("Height [m]");
    title("Vertical profile of "+plot_var);
    %legend();
    
end 
    