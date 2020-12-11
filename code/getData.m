% reference: https://github.com/BrainDynamicsUSYD/NeuroPattToolbox
% #######################
% --- read data
%
load data
%
%%% toward
disp("Loading Towards Data...")
tic
datamat=[];datacell=[];
datacell=data.LFP.toward;
for ii=1:size(datacell,2)
    datamat(:,:,:,ii)=cell2mat(datacell(ii));
end
datamat(:,:,:,ii+1)=mean(datamat,4);
toward_datamat = datamat; 
save toward_datamat toward_datamat
toc

%%% away
disp("Loading Away Data...")
tic
datamat=[];datacell=[];
datacell=data.LFP.away;
for ii=1:size(datacell,2)
    datamat(:,:,:,ii)=cell2mat(datacell(ii));
    datamat(:,:,:,ii)=( datamat(:,:,:,ii)-min(datamat(:,:,:,ii),[],"all" )) / (max(datamat(:,:,:,ii),[],"all")-min(datamat(:,:,:,ii),[],"all"));  
end
datamat(:,:,:,ii+1)=mean(datamat,4);
away_datamat = datamat;
save away_datamat away_datamat
toc

clear data