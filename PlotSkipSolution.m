function PlotSkipSolution(StaBestSol,DynBestSol,RealTour,model)
figure('Position',[240 0 480*2 360*2])

a1=subplot(2,4,1:2);
hold on
PlotSolution(StaBestSol.Tour,model);
PlotSolution_g(RealTour.Sta,model);
title({'All Tour Static';...
    ['Visited number: ',num2str(numel(RealTour.Sta)),'/',num2str(numel(StaBestSol.Tour))];...
    ['Tour Length: ',num2str(TourLength(StaBestSol.Tour,model))]})

a2=subplot(2,4,3:4);
hold on
PlotSolution(DynBestSol.Tour,model);
PlotSolution_g(RealTour.Dyn,model);
title({'All Tour Dynamic';...
    ['Visited number',num2str(numel(RealTour.Dyn)),'/',num2str(numel(DynBestSol.Tour))];...
    ['Tour Length: ',num2str(TourLength(DynBestSol.Tour,model))]})

a3=subplot(2,4,6:7);
hold on
PlotSolution(RealTour.Dyn,model);
PlotSolution_g(RealTour.Dyn,model);
title({'Skip Tour Dynamic';...
    ['Visited Number: ', num2str(numel(RealTour.Dyn)),'/',num2str(numel(RealTour.Dyn))];...
    ['Tour Length: ',num2str(TourLength(RealTour.Dyn,model))]})

saveas(gcf,[pwd '/output/CompareSkipSolution.png'])
end