function [simulatedata,params]=WaveDetectionAlgorithm(mat)
    
    % input: one trial of 10*10 arrays, 141 frames in total
    % example: simulatedata,params=WaveDetectionAlgorithm(datamat(:,:,:,1));

    % Fit the standard two dimensional wave equation by lsqcurvefit
    % https://ww2.mathworks.cn/help/optim/ug/nonlinear-curve-fitting-with-lsqcurvefit.html

    % parameters
    nframes=size(mat,3);
    fre=500;
    ntimes=([1:141]-71)/fre*1000; % unit in ms

    %%%%%%%%%% first fit the equation for each timestamp
    params=[]; % pars = [a,kx,ky,w,phi]
    simulatedata=[];
    for frame = 1:nframes

        % --- equations
        t=ntimes(frame);
        % pars = [a,kx,ky,w,phi]
        %  =[x,y]
        predicted = @(pars,xdata)pars(1)*sin(pars(2)*xdata(:,1)+pars(3)*xdata(:,2)-pars(4)*t+pars(5));

        % --- data
        n=0;
        % input values: xdata (location)
        for cc=1:10
            for rr=1:10
                n=n+1;
                xdata(n,:)=[rr,cc];
            end
        end

        % output values: ydata
        ydata = reshape(mat(:,:,frame),[100,1]); % by reshape(), the data is first from top to bottom, 
                                                 % then from left to right

        % --- fit methods
        pars0=[mean(ydata),2*pi/20,2*pi/20,-2*pi/20,pi];
        options = optimoptions('lsqcurvefit',"MaxFunctionEvaluations",1e5, "FunctionTolerance",5e-5,"MaxIterations",1500);
        ahat = lsqcurvefit(predicted, pars0, xdata, ydata, [],[], options);

        params(:,:,frame) = ahat;
        
        
        % --- get predicted values
        smdata=[];
        for ii =1:size(xdata,1)
            % smdata(ii,:)=predicted(pars0, predicted);
            smdata(ii,:)=ahat(1)*sin( ahat(2)*xdata(ii,1)+ahat(3)*xdata(ii,2)-ahat(4)*t+ahat(5) );
        end 
        simulatedata(:,:,frame)=reshape(smdata,[10,10]);
    end   
    
    
end