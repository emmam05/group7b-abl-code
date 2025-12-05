% generate vertical profile of variable at time for LES data
function [] = plot_data_les(indir_les, time, plot_var, set_xlim, xlimmin, xlimmax, ylimmax, color, linestyle)    
    
    % set filename 
    filename_les = "diagnostics_ts_"+string(time)+".nc" ;
    
    % construct file path to specified file 
    filepath_les = indir_les+filename_les;

    % set vertical coord system, using zn as default 
    z_type = "zn";
    loadname = "th"; 
    plot_xlab = "Potential Temperature [K]";
    
    % set plotting value and x labels 
    if plot_var == "th"
        loadname = "theta_mean";
        plot_xlab = "Potential Temperature [K]";

    elseif plot_var == "u"
         loadname = "u_wind_mean";
         plot_xlab = "Horizontal u wind [m/s]";

    elseif plot_var == "v"
        loadname = "v_wind_mean";
        plot_xlab = "Horizontal v wind [m/s]";

    elseif plot_var == "qv"
        loadname = "vapour_mmr_mean";
        plot_xlab = "Water vapour mixing ratio [g/kg]";

    elseif plot_var == "ql"
        loadname = "liquid_mixing_ratio";
        plot_xlab = "Liquid mixing ratio [g/kg]";

    elseif plot_var == "p"
        loadname = "rho";
        plot_xlab = "Pressure [K]";
        z_type = "z";

    elseif plot_var == "rh"
        loadname = "rh_mean";
        plot_xlab = "Relative Humidity [K]";
     
    elseif plot_var == "uw"
        loadname = "uw_mean";
        plot_xlab = "Momentum Flux uw [m^2/s^2]";

    elseif plot_var == "vw"
        loadname = "vw_mean";
        plot_xlab = "Momentum Flux vw [m^2/s^2]";

    elseif plot_var == "k_m"
        loadname = "viscosity_coef_mean";
        plot_xlab = "Eddy Viscosity km [K^2]";  

    elseif plot_var == "k_h"
        loadname = "diffusion_coef_mean";
        plot_xlab = "Thermal Diffusivity kh [K^2]" ; 

    elseif plot_var == "wth"
        loadname = "wtheta_ad_mean";
        plot_xlab = "Heat Flux [W/m2]";

    elseif plot_var == "wqv"
        loadname = "wqv_ad_mean";
        plot_xlab = "Moisture Flux [kg/m2]";

    else 
        error("Unreognised plotting variable! " + ...
            "must be th, u, v, qv, ql, p, rh, uw, uv, wth, wqv, k_m or k_h!")
    end 
    
    % Load in a few selected variables 
    dtime = ncread(filepath_les, "time_series_60_60");

    % time to plot at - take end of file 
    time_ind = size(dtime,1);

    % z coordinate system is different for some variables 
    if z_type == "zn"
        z_coord = ncread(filepath_les, "zn");
    else 
        z_coord = ncread(filepath_les, "z");
    end

    % load plotting data
    plot_data = ncread(filepath_les, loadname);
    plot_vect = plot_data(:,time_ind);

    % qv hs easier to see if multiplied by 1000
    if plot_var == "qv"
        plot_vect = plot_vect*1000;
    end

    % % plot vertical profile from LES data
    plot(plot_vect, z_coord, ...
        'Color',color, ...
        'Linewidth', 2, ...
        'LineStyle', linestyle, ...
        'Displayname', 'LES') %, ...
 %        "DisplayName", "LES "+plot_var + ", time="+string(time));

    % set limits, title, legend 
    ylim([0,ylimmax]) ;
    if set_xlim 
        xlim([xlimmin,xlimmax]); 
    end 
    xlabel(plot_xlab);
    ylabel("Height [m]");
    title("Vertical profile of "+plot_var);
    %legend();
    
end 
    