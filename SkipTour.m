function SkipTour=SkipTour(BestSol,HPTour)

HPReal=RouletteChoice(HPTour);
tmp=HPReal.*BestSol.Tour;
SkipTour=nonzeros(tmp)';

end