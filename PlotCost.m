function PlotCost(BestCost,BestLcost,BestDcost,model,aL)
figure;
hold on;
plot(BestCost,'LineWidth',2);
plot(BestLcost,'LineWidth',2);
plot(aL*(model.n-BestDcost),'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
legend('Cost','Total Length','Wasted Length');
grid on;
end