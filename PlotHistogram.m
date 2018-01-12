function PlotHistogram(StaBestSol,DynBestSol,HPTour,model,aL)
it=2000
for i=1:it
RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
Cost.Sta = TourLength(RealTour.Sta,model);
RealTour.Dyn = SkipTour(DynBestSol,HPTour.Dyn);
Cost.Dyn = TourLength(RealTour.Dyn,model);
h1(1,i)=Cost.Sta;
h2(1,i)=Cost.Dyn;
n1(1,i)=numel(RealTour.Sta);
n2(1,i)=numel(RealTour.Dyn);
end
figure('Position',[180 0 480*2 540*2])
% f1=subplot(2,3,1);
% hist1=histogram(h1);
% title('Static Length Histogram')
% xlabel(f1,'Length')
% ylabel(f1,'freauency')
% 
% f2=subplot(2,3,2);
% hist2=histogram(h2);
% title('Dynamic Length Histogram')
% xlabel(f2,'Length')
% ylabel(f2,'freauency')

f3=subplot(2,3,2);
% hist1=histogram(h1);
bar(StaBestSol.Lcost,200,1000);
hold on
hist2=histogram(h2);
title('Compare Length Histogram')
xlabel(f3,'Length')
ylabel(f3,'freauency')
legend('Static','Dynamic')

f4=subplot(2,3,4);
hist3=histogram(n1);
title('Static Delivered Success Number')
xlabel(f4,'Number')
ylabel(f4,'freauency')

f5=subplot(2,3,5);
hist4=histogram(n2);
title('Dynamic Delivered Success Number')
xlabel(f5,'Number')
ylabel(f5,'freauency')

f6=subplot(2,3,6);
hist3=histogram(n1);
hold on
hist4=histogram(n2);
title('Compare Delivered Success Number')
xlabel(f6,'Number')
ylabel(f6,'freauency')
legend('Static','Dynamic')

saveas(gcf,[pwd '/output/CompareHistogram.png'])

% %% 
% for i=1:2000
% RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
% Cost.Sta = RealCostFunction(RealTour.Sta,model,aL);
% RealTour.Dyn = SkipTour(DynBestSol,HPTour.Sta);
% Cost.Dyn = RealCostFunction(RealTour.Dyn,model,aL);
% h(1,i)=Cost.Dyn/Cost.Sta;
% end
% M=mean(h);
% V=var(h);
% S=skewness(h);
% figure
% hist = histogram(h);
% title({'Ratio  Dynamic/Static Cost ';strcat('Mean: ',num2str(M),' Variance: ',num2str(V),' Skewness: ',num2str(S))})
% hist.Normalization = 'probability';
% 

end