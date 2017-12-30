clc;
clear;
close all;

%% Problem Definition
N=40;   % Number of House
fix=1;  % 0/1 value. 0: generate random structure with N. 1: Use Previous Setting.

model=CreateModel(fix,N);


%% ACO Parameters

par.MaxIt=300;      % Maximum Number of Iterations

par.nAnt=50;        % Number of Ants (Population Size)

par.aL = mean(model.D(2:end,1))*1.2;      % average of length per 1 package [m] (this value also means probability weighting of cost function)

par.Dyn = 0;     % 0 or 1 value. 0:Static(Normal TSP) 1:Dynamic

par.Q=1;

par.alpha=1;        % Phromone Exponential Weight
par.beta=3;         % Heuristic Exponential Weight
par.gamma=1/4;        % Priori Probability Weight

par.rho=0.1;       % Evaporation Rate

step=numel(model.P(:,1));
L=0.4*par.aL*model.n;
par.v=L/step;           % Vehicle Average Velocity [m/min] (For considering simulation time cost, we don't use real value, but we define this velocity to deliver the final package at 22:00)



for i=1:2
    Dyn=[0 1];
    par.Dyn = Dyn(i);
    close all;
    %% ACO Main Loop
    [BestSol HP_Log BestCost] = acoCalc(par, model);%#ok
    if Dyn(i)==0
        StaCost=BestCost;
        StaHP_Log=HP_Log;
        StaBestSol=BestSol;
    elseif Dyn(i)==1
        DynCost=BestCost;
        DynHP_Log=HP_Log;
        DynBestSol=BestSol;
    end
    %% Plot The Results
%     PlotTimeVaring(BestSol,model,HP_Log,par.Dyn)
    PlotCost(BestCost.C,BestCost.L,BestCost.D,model,par.aL,par.Dyn)
    if Dyn(i)==0
        HPTour.Sta = PlotClimbing(HP_Log,BestSol,par.Dyn);
    elseif Dyn(i)==1
        HPTour.Dyn = PlotClimbing(HP_Log,BestSol,par.Dyn);
    end
    pause(1)
end
PlotCompare(DynCost,StaCost,HPTour,par.aL,model)

%% Plot the GPS Skip Tour
RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
RealTour.Dyn = SkipTour(DynBestSol,HPTour.Sta);
PlotSkipSolution(StaBestSol,DynBestSol,RealTour,model)

for i=1:1000
RealTour.Sta = SkipTour(StaBestSol,HPTour.Sta);
Cost.Sta = TourLength(RealTour.Sta,model);
RealTour.Dyn = SkipTour(DynBestSol,HPTour.Sta);
Cost.Dyn = TourLength(RealTour.Dyn,model);
h1(1,i)=Cost.Sta;
h2(1,i)=Cost.Dyn;
n1(1,i)=numel(RealTour.Sta);
n2(1,i)=numel(RealTour.Dyn);
end
figure('Position',[180 0 480*2 420*2])
f1=subplot(2,3,1);
hist1=histogram(h1)
title('Static Length Histogram')
xlabel(f1,'Length')
ylabel(f1,'freauency')

f2=subplot(2,3,2);
hist2=histogram(h2)
title('Dynamic Length Histogram')
xlabel(f2,'Length')
ylabel(f2,'freauency')

f3=subplot(2,3,3);
hist1=histogram(h1)
hold on
hist2=histogram(h2)
title('Compare Length Histogram')
xlabel(f3,'Length')
ylabel(f3,'freauency')
legend('Static','Dynamic')

f4=subplot(2,3,4);
hist3=histogram(n1)
title('Static Delivered Success Number')
xlabel(f4,'Number')
ylabel(f4,'freauency')

f5=subplot(2,3,5);
hist4=histogram(n2)
title('Dynamic Delivered Success Number')
xlabel(f5,'Number')
ylabel(f5,'freauency')

f6=subplot(2,3,6);
hist3=histogram(n1)
hold on
hist4=histogram(n2)
title('Compare Delivered Success Number')
xlabel(f6,'Number')
ylabel(f6,'freauency')
legend('Static','Dynamic')