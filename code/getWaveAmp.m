% Before run this code
% assign "params"
ntrials = size(params,4);
amp=[]; st=42; et=101; nframe=141;
f=figure();
for itrial=1:ntrials
    for j=1:nframe
        amp(j,itrial)=params(1,1,j,itrial);
    end
    
    f1=plot(st:et,amp(st:et,itrial),"Color",'#4DBEEE',"LineWidth",0.7 );
   
    hold on
end
mean_amp=mean(amp,2);
std_amp=std(amp,0,2);
plot(st:et,repelem(1,60),"--","Color","r");
plot(st:et,repelem(-1,60),"--","Color","r");
f2=errorbar(st:et,mean_amp(st:et,:),std_amp(st:et,:),"Color",'#0072BD',"LineWidth",1.5);
xlim([st,et])
xticks([st:10:et])
xticklabels(["-60","-40","-20","0","20","40","60"])
xlabel("Time(ms)")
ylim([-3,3])
ylabel("LFP relative amplitude")
legend([f1 f2],{'one trial','average'},"Location",'southeast')
hold off
saveas(f,"figures/"+'amp-'+filename+"1.svg");
close(f);