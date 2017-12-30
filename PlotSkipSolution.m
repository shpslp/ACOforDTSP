function PlotSkipSolution(StaBestSol,DynBestSol,RealTour,model)
figure('Position',[240 0 480*2 360*2])
a1=subplot(2,2,1);
subplot(2,2,1)
PlotSolution(StaBestSol.Tour,model);
title('All Tour Static')
xlabel(a1,'x')
ylabel(a1,'y')

a2=subplot(2,2,2);
PlotSolution(DynBestSol.Tour,model);
title('All Tour Dynamic')
xlabel(a2,'x')
ylabel(a2,'y')

a3=subplot(2,2,3);
PlotSolution(RealTour.Sta,model);
title(['Skip Tour Static -- Visited Number', num2str(numel(RealTour.Sta))])
xlabel(a3,'x')
ylabel(a3,'y')

a4=subplot(2,2,4);
PlotSolution(RealTour.Dyn,model);
title(['Skip Tour Dynamic -- Visited Number: ', num2str(numel(RealTour.Dyn))])
xlabel(a4,'x')
ylabel(a4,'y')

saveas(gcf,[pwd '/output/CompareSkipSolution.png'])
end