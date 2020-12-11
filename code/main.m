% -----------
%% Step 1: load original LFP data from file "data.mat"
cd ...\ECSE-689-001\Project\codes
addpath(genpath('...\ECSE-689-001\Project\codes'))
getData
% this produce variable "away_datamat" and "toward_datamat" to process

% -----------
%% Step 2: do wave detection algorithm on the dataset
% toward
datamat=[]; datamat=toward_datamat;
getWaveDetectionAlgorithm;
toward_simulate_data=simulate;
toward_simulate_params=params;
save toward_simulate_data toward_simulate_data
save toward_simulate_params toward_simulate_params 
disp("Wave Detection Algorithm: toward data...END")
%
% away 
datamat=[]; datamat=away_datamat;
getWaveDetectionAlgorithm;
away_simulate_data=simulate;
away_simulate_params=params;
save away_simulate_data away_simulate_data
save away_simulate_params away_simulate_params
disp("Wave Detection Algorithm: away data...END")
%
%
%% Step 3: plot out Heatmap for real data and for reconstructed data
% 
% toward
load toward_simulate_data 
load toward_datamat
datamat=toward_datamat; simulate=toward_simulate_data; filename="toward-";
getHeatmap;
% 
% away
load away_simulate_data 
load away_datamat
datamat=away_datamat; simulate=away_simulate_data; filename="away-";
getHeatmap;
%
%
%% Step 4: plot wave amplitude over time 
% toward
params = toward_simulate_params; filename = 'toward';
getWaveAmp;
% 
% away
params = away_simulate_params; filename = 'away';
getWaveAmp;
%
%
%% Step 5: Velocity Vector Fields
% toward
datamat=toward_datamat; filename="toward-";
getVelocityField;
toward_vfs=vfs;
save toward_vfs toward_vfs
%
% away
datamat=away_datamat; filename="away-";
getVelocityField;
away_vfs=vfs;
save away_vfs away_vfs
%
%
%% Step 6: Get Wave Patterns
% toward
wvcfs = toward_datamat;
vfs = toward_vfs;
filename='toward';
getPatterns;
% 
% away
wvcfs = away_datamat;
vfs = away_vfs;
filename='away';
getPatterns;