fname = 'SEMS_140_RESULTS_181015_134310.dat';
fid = fopen(fname,'r');
datacell = textscan(fid, '%s', 'CommentStyle','#', 'delimiter', '\n');
fclose(fid);
A.data = datacell{1};