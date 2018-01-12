clc;
clear;
close all;
tic;

%% Problem Definition
N=80;   % Number of House
fix=0;  % 0/1 value. 0: generate random structure with N. 1: Use Previous Setting.

model=CreateModel(fix,N);


%% ACO Parameters

par.MaxIt=800;      % Maximum Number of Iterations

par.nAnt=50;        % Number of Ants (Population Size)

par.aL = mean(model.D(2:end,1));      % average of length per 1 package [m] (this value also means probability weighting of cost function)

par.Dyn = 0;     % 0 or 1 value. 0:Static(Normal TSP) 1:Dynamic

par.Q=1;

par.alpha=1;        % Phromone Exponential Weight
par.beta=3;         % Heuristic Exponential Weight
par.gamma=1/4;        % Priori Probability Weight

par.rho=0.1;       % Evaporation Rate

step=numel(model.P(:,1));
L=0.5*par.aL*model.n;
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
RealTour.Dyn = SkipTour(DynBestSol,HPTour.Dyn);
PlotSkipSolution(StaBestSol,DynBestSol,RealTour,model)

PlotHistogram(StaBestSol,DynBestSol,HPTour,model,par.aL)

toc;