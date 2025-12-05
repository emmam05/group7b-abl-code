% function to load table of data

function [full_table] = load_complete_df(indir_1dbl)

    % initialise data 
    full_table = [];
    for time = 1200:1200:51600
    
        % set filename given ime imput
        filename_1dbl = "arm_shcu_t_"+string(time)+".dat" ;
        
        % construct file path to specified file 
        filepath_1dbl = indir_1dbl+filename_1dbl;
        
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

        % add time column
        df.time = repmat(time, height(df), 1);

        % append current time to data frame 
        full_table = [full_table; df];

    end 
 
