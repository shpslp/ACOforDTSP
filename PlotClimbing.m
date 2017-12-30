function HP_Tour=PlotClimbing(HP_Log,BestSol,Dyn)
figure('Position', [240 0 480*2 360*2])
hold on;
mesh(HP_Log(:,BestSol.Tour))
a = 1:numel(BestSol.Tour);
HP_Tour=diag(HP_Log(:,BestSol.Tour));
plot3(a,a,HP_Tour+0.05,'LineWidth',3)
colorbar
view(-1,70);
if Dyn==1
    saveas(gcf,[pwd '/output/Climbing_Dynamic.png'])
else
    saveas(gcf,[pwd '/output/Climbing_Static.png'])
end
end