function PlotCompare(DynCost,StaCost,HPTour,aL,model)
figure('Position',[240 0 480*2 360*2])
a1=subplot(2,2,1);
hold on;
plot(DynCost.L,'LineWidth',2);
plot(StaCost.L,'LineWidth',2);
title('Length')
xlabel(a1,'Iteration')
ylabel(a1,'Cost[m]')
legend('Dynamic','Static')

a2=subplot(2,2,2);
hold on;
plot(aL*(model.n-DynCost.D),'LineWidth',2);
plot(aL*(model.n-StaCost.D),'LineWidth',2);
title('Delivery Failire Length')
xlabel(a2,'Iteration')
ylabel(a2,'Cost[m]')
legend('Dynamic','Static')

a3=subplot(2,2,3);
hold on;
plot(DynCost.C,'LineWidth',2);
plot(StaCost.L+(aL*(model.n-StaCost.D)),'LineWidth',2);
title('Sum of 2 Costs')
xlabel(a3,'Iteration')
ylabel(a3,'Cost[m]')
legend('Dynamic','Static')

a4=subplot(2,2,4);
hold on;
plot(sort(HPTour.Dyn,'descend'),'LineWidth',2);
plot(sort(HPTour.Sta,'descend'),'LineWidth',2);
title('Home-Probability')
xlabel(a4,'House Number Sorted in Descent')
ylabel(a4,'Probability')
legend('Dynamic','Static')

saveas(gcf,[pwd '/output/CompareCost.png'])

end