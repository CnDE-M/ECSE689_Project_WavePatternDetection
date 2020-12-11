% Before run this code, 
% assign "datamat", "simulate", and "filename"
%
ntrial=31;%size(datamat,4);
for trial=1:ntrial
    disp("### Trial "+string(trial)+"...");
    f1=plotHeatmap(datamat(:,:,:,trial));
    f2=plotHeatmap(simulate(:,:,:,trial));
    saveas(f1,"figures/"+filename+string(trial)+"-real.svg")
    saveas(f2,"figures/"+filename+string(trial)+"-simulate.svg")
    close(f1);close(f2);
end



