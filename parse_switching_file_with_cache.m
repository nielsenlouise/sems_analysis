 function [ v1_ranges, v2_ranges ] = parse_switching_file_with_cache( fname )
% parses a switching file and caches the result, or does no parsing and uses
% a cached value.
% This exists because parsing takes a while and the data does not change often.
%   Inputs:  fname, name of the switching ile
%   Outputs: v1_ranges, NUM_RANGESSx2 Matrix containing datetime
%   ranges when the valve 1 is open.
%            v2_ranges, NUM_RANGESSx2 Matrix containing datetime
%   ranges when valve 2 is open.

    cached_fname = [fname '.mat'];
    % Check if cache file already exists
    if exist(cached_fname, 'file') == 2
        % If it does exist, load values from that file
        disp('Retrieving parsed switching ranges from cache...')
        load(cached_fname)
    else
        % Otherwise, parse the switching file
        disp('Parsing switching file...')
        [ v1_ranges, v2_ranges ] = parse_switching_file(fname);
        % save the values
        disp('Saving parsed switching ranges to cache...')
        save(cached_fname, 'v1_ranges', 'v2_ranges')
    end
 end