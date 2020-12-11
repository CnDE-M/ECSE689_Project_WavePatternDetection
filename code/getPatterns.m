%% Find all patterns present
% Before run this code
% assign variable "wvcfs = toward_datamat", "vfs = toward_vfs;" "filename"

disp('Identifying all patterns in velocity fields...')
tic

% #####################################################
% PARAMS is a structure containing optional user settings:
%   params.minDurationSteps is the minimum duration (in time steps) of a 
%       pattern for it to be detected (default 1).
%   params.maxTimeGapSteps gives the maximum duration in time steps between
%       critical points (or synchrony/plane waves) for them to be counted
%       as the same pattern (default 0).
fs=500; % unit in Hz sample frequency
params=[];
params.minDurationSecs = 0.02; % Minimum duration of a pattern for it to be stored (in seconds, default 0)
params.maxTimeGapSecs = 0.005; % Maximum duration between critical points (or synchrony/plane waves) for them to be counted as the same pattern (in seconds, default 0)
params.downsampleScale = 1; % no downsampling
params.maxTimeGapSteps = floor(params.maxTimeGapSecs * fs / params.downsampleScale);
params.minDurationSteps = max(1, round(params.minDurationSecs * fs / params.downsampleScale));

%   params.planeWaveThreshold gives the minimum order parameter for
%       activity to be considered a plane wave (must be between 0 and 1,
%       close to 1 indicates plane wave activity, default 1).
%   params.synchronyThreshold gives the maximum mean vector magnitude below
%       which all activity is considered synchony (default is two standard
%       deviations below the mean).
params.planeWaveThreshold = 0.85;% Minimum order parameter for a plane wave to be detected (default 0.85)
params.synchronyThreshold = 0.85;% Maximum velocity field magnitude for synchrony to be detected (default 0.85)

%   params.minEdgeDistance gives the minimum number of indices from the arrays
%       edge for critical points to be considered.
%   params.minCritRadius gives the minimum spatial radius for a critical
%       point to occupy for it to be counted, quantified by the winding
%       number and divergence/curl (default 1).
%   params.maxDisplacement gives the maximum number of grid spaces between
%       between critical points in consecutive patterns for them to be
%       counted as the same patterns (default 0.5).
params.maxDisplacement = 1; % Maxiumum displacement between critical points between time steps for them to be counted as the same pattern (measured in grid spaces, default 1)
params.minCritRadius = 1;
params.minEdgeDistance = 1; % Minimum distance from the edge of the system (in grid spaces)

%   params.combineNodeFocus is a boolean flag indicating that nodes and
%       foci should be treated as identical critical points, instead of
%       being split into sources/saddles and spirals (default false).
%   params.combineStableUnstable is a boolean flag indicating that stable
%       and unstable nodes and foci should be treated as identical critical
%       points types, instead of being split into sources and sinks
%       (default false).
combineNodeFocus = false;
combineStableUnstable = false;

% PARAMS can also be output, to keep track of any default values used.
% #####################################################

% Set up pattern structures
ntrials = size(wvcfs,4);
clear allPatts allLocs
allPatts = cell(1,ntrials);
allLocs = allPatts;
% Loop over all repetitions to find patterns
for itrial = 1:ntrials
    thiscf=[];
    thisvf = vfs(:,:,:,itrial);
    [patterns, patternTypes, patternColNames, pattLocs] = ...
        findAllPatterns(real(thisvf), imag(thisvf), params, ...
        angle(wvcfs(:,:,:,itrial)));
    allPatts{itrial} = patterns;
    allLocs{itrial} = pattLocs;
end
f=figure("Position",[3,86,1148,531]);
plotPatternLocs(allLocs, patternTypes, 141, ntrials)%  "ntrials", 1, "nspacebins",[], "smoothScale",[], "useContours",true)
saveas(gca, "figures/pattern-"+filename+".svg")
close
toc;