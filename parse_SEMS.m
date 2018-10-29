fname = 'SEMS_140_RESULTS_181015_134310.dat';
fid = fopen(fname,'r');
% Read in file as a 1xN vector
datacell = textscan(fid, '%f', 'CommentStyle','#', 'Delimiter', ': \t' );
fclose(fid);

data = datacell{1};

% There are 71 columns in the data file. However, we split each of the 
% two date columns into 3 columns, which gives us 75.  
NUM_COLS = 75;
disp(['Scanned ', num2str(size(data,1) / NUM_COLS), ' rows of data.']);

if mod(size(data, 1), NUM_COLS) ~= 0
    disp('Error! Data has an unexpected number of columns. ')
    disp('Please update NUM_COLS in parse_SEMS and try again.')
end

