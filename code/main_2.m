% -----------
%% Step 1: load original LFP data from file "data.mat"
getData
% this produce variable "away_datamat" and "toward_datamat" to process
% assign values "datamat" and the corresponding "filename"
datamat=[]; datamat=toward_datamat; wvcfs = toward_datamat;
filename="toward-";

% -----------
%% Step 2: do wave detection algorithm on the dataset
getWaveDetectionAlgorithm;
% this produces variable "simulate" and "params"
disp("Wave Detection Algorithm: toward data...END")
%

%% Step 3: plot out Heatmap for real data and for reconstructed data
getHeatmap;
% 

%% Step 4: plot wave amplitude over time 
getWaveAmp;
% 
%% Step 5: Velocity Vector Fields
getVelocityField;
%
%% Step 6: Get Wave Patterns
getPattern;
% 
%% END: Save Data
toward_simulate_data=simulate;
toward_simulate_params=params;
toward_vfs=vfs;

save toward_vfs toward_vfs
save toward_simulate_data toward_simulate_data
save toward_simulate_params toward_simulate_params 