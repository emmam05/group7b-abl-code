% function to calcualte cloud base height using bolton 1980

function[zcl] = calc_cloud_base_romps(qv, T, rh, p)

    %% constants
    % specific heat capacity of dry air 
    cva = 719;
    % gas constant of dry air 
    Ra = 287.04; 
    % SHC of dry air at constant pressure 
    cpa = cva + Ra;
    
    % specific heat capacity of water vapour at constant volume 
    cvv = 1418; 
    % gas constant of water vapour 
    Rv = 461; 
    % SHC of water vapour at constant pressure 
    cpv = cvv + Rv; 
    
    % gravitational constant
    g = 9.81; 
    
    % unsure 
    cvl = 4119; 
    
    % diff between specific internal energy of water vapour and liquid at
    % triple point 
    E0v = 2.374*10^6;
    
    % triple point temperature, K
    Ttrip = 273.16;

    %% calcualte cloud base

    % weighted specific heat capacity
    cpm = (1-qv/1000)*cpa + qv/1000*cpv;

    % weighted gas constant 
    Rm = (1-qv/1000)*Ra + (qv/1000)*Rv;
    
      % absolute temp 
      T = T*(100000/p)^(-Rm/cpm);

    % constants 
    a = cpm/Rm + (cvl - cpv)/Rv; 
    b = -(E0v-(cvv-cvl)*Ttrip)/(Rv*T);
    c = b/a;

    % temperature at LCL 
    tlcl = T*c*(lambertw(-1, c*exp(c)*rh^(1/a)))^-1;

    % calcualte LCL height 
    zcl = (cpm/g)*(T-tlcl);
        
end 