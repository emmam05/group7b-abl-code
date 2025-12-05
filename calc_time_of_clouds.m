% function to take bl_h and h_cl, linearly interpolate between times to
% make a 'best guess' of time of cloud formation 

function[time_clouds] = calc_time_of_clouds(bl_h, h_cl)
    
    % vector of times input vectors are evaluated at 
    time = 1200:1200:51600;

    % length of interpolated vector (longer = more precise)
    newlength = length(time)*5; 

    % vector of new times, post interpolattion 
    newtimes = interp1(linspace(0,1,length(time)), time, linspace(0,1,newlength-1));

    % aboslute height difference between h_bl and cl_h 
    bl_h = interp1(linspace(0,1,length(bl_h)), bl_h, linspace(0,1,newlength-1));
    h_cl = interp1(linspace(0,1,length(h_cl)), h_cl, linspace(0,1,newlength-1));
    abs_height_diff = abs(bl_h - h_cl);

    % interpolate differences 
    time_clouds = newtimes(abs_height_diff==min(abs_height_diff));
    
end 