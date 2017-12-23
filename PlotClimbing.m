function PlotClimbing(HP_Log,BestSol)
figure
hold on;
mesh(HP_Log(:,BestSol.Tour))
a = 1:numel(BestSol.Tour);
plot3(a,a,diag(HP_Log(:,BestSol.Tour))+0.05,'LineWidth',3)
colorbar
end