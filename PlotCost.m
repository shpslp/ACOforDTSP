function PlotCost(BestCost,BestLcost,BestDcost,model,aL,Dyn)
figure('Position', [240 480 480 360])
hold on;
if Dyn==1
    plot(BestCost,'LineWidth',2);
else
    plot(BestLcost+aL*(model.n-BestDcost),'LineWidth',2);
end
plot(BestLcost,'LineWidth',2);
plot(aL*(model.n-BestDcost),'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
legend('Cost','Total Length','Wasted Length');
grid on;
if Dyn==1
    saveas(gcf,[pwd '/output/Cost_Dynamic.png'])
else
    saveas(gcf,[pwd '/output/Cost_Static.png'])
end
end