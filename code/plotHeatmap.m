function f=plotHeatmap(mat)

% input: one trial of 10*10 arrays, 141 frames in total
% example: f=plotHeatmap(simulatedata);
%     fre=500;
%     nframe = size(mat,3);
%     nsample = 0.1*2 / (1/fre);% plot from time -100ms to time 100ms
%     nfstart=(nframe+1-nsample)/2;
%     nstep = 0.002/ (1/fre);   % take a sample every 2 ms
    
    % default values of the dataset
    fre=500;    % unit in Hz
    nframe=141; % for each saccades, the recordings is a 10*10 array of 141 frames in total
    
    % parameters to sample one frame from the data
    % here I sampled all the frames from -20ms to 40ms
    nsample=30;
    nfstart=62;
    nfend=91;
    nstep=1; % sample per 2ms
    
    sampledata=[];
    sampletime=[];
    jj=0;
    for ii=nfstart:nstep:nfend
        jj=jj+1;
        sampledata(:,:,jj) = mat(:,:,ii);
        sampletime(jj) = (ii-(nframe+1)/2)/fre*1000; % unit in ms
    end

    f=figure("Position",[11.67,163,1198.67,358]);
    load mycolormap % self define the colormap
    axislabels = ["";"";"";"";"";"";"";"";"";""];
    for jj=1:nsample
        subplot(3,10,jj);
        title="";
        if rem(jj,5)==0
            title = string(sampletime(jj))+"ms";
        end
        h=heatmap(sampledata(:,:,jj),'CellLabelColor','none',"ColorbarVisible", 0, "GridVisible", 0,"ColorLimits",[0,1],...
                                 "Title", title, "Colormap", mycolormap, "FontSize", 8,...
                                 "XDisplayLabels", axislabels,"YDisplayLabels", axislabels);
        if jj==nsample
            set(h,"ColorbarVisible", 1)
        end

    end

end