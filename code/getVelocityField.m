%% Calculate velocity vector fields using optical flow estimation
% before run this code
% assign "datamat" and "filename"
disp('Calculating velocity vector fields...')
tic
vfs=[];
vfs=getvf(datamat);
toc
%% Plot out images
for itrial=1:30 %size(vfs,4)
    disp("### Trial "+string(itrial)+"...");
    f1=plotVelocityField(datamat(:,:,:,itrial),vfs(:,:,:,itrial));
    f2=plotVelocityField(simulate(:,:,:,itrial),vfs(:,:,:,itrial));
    saveas(f1,"figures/"+"vfs-"+filename+string(itrial)+"-real.svg")
    saveas(f2,"figures/"+"vfs-"+filename+string(itrial)+"-simulate.svg")
    close(f1);close(f2);
end

function vfs=getvf(wvcfs)
% calculate velocity vector field

    params.opAlpha=0.1;
    params.opBeta=10;
    params.useAmplitude=1;

    % Pre-allocate velocity field variables
    vfs = zeros(size(wvcfs));
    vfs = vfs(:,:,1:end-1,:);
    meanCSteps = zeros(size(wvcfs,4), 1);

    % Calculate velocity fields for every trial, and same average number of
    % steps to converge
    for itrial = 1:size(wvcfs,4)
        [vx, vy, csteps] = opticalFlow(wvcfs(:,:,:,itrial), [], ...
            params.opAlpha, params.opBeta, ~params.useAmplitude);
        vfs(:,:,:,itrial) = vx + 1i*vy;
        meanCSteps(itrial) = mean(csteps);
        fprintf('Processed trial %i\n', itrial)
    end
end

% % --- draw velocity vector fields
% Vx=data.OF.toward.Vx;
% Vy=data.OF.toward.Vy;
% Vxmax=[];Vymax=[];vfs=[];
% for itrial=1:size(Vx,2)
%     Vxmat(:,:,:,itrial)=cell2mat(Vx(itrial));
%     Vymat(:,:,:,itrial)=cell2mat(Vy(itrial));
%     vfs(:,:,:,itrial) = Vxmat(:,:,:,itrial) + 1i*Vymat(:,:,:,itrial);
% end
