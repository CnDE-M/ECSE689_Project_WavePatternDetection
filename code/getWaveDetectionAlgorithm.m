% -------------
% Before run this code,
% assign "xxx_datamat" to variable "datamat"
%
% This will output variable "simulate" and "params" to save
%   "simulate" is the simulated values
%   "params" is the params in the simulating equation
disp("Start doing Waving Detection Algorithm...");
simulate=[];params=[];
ntrial=30; % size(datamat,4);
for trial=1:ntrial
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp(" ##### Trial "+string(trial));
    tic
    % ---
    % calculate simulated data by wave detection algorithm
    [simulate(:,:,:,trial),params(:,:,:,trial)]=WaveDetectionAlgorithm( datamat(:,:,:,trial) );
    toc
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    disp("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    
end

[simulate(:,:,:,trial+1),params(:,:,:,trial+1)]=WaveDetectionAlgorithm( datamat(:,:,:,trial+1) );

