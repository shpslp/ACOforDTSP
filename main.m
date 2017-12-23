%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA103
% Project Title: Ant Colony Optimization for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clc;
clear;
close all;

%% Problem Definition

model=CreateModel();


%% ACO Parameters

par.MaxIt=300;      % Maximum Number of Iterations

par.nAnt=50;        % Number of Ants (Population Size)

par.aL = 30;      % average of length per 1 package (this value also means probability weighting of cost function)

par.Dyn = 1;     % 0 or 1 value. 0:Static(Normal TSP) 1:Dynamic

par.Q=1;

par.alpha=1;        % Phromone Exponential Weight
par.beta=1;         % Heuristic Exponential Weight
par.gamma=1;        % Priori Probability Weight

par.rho=0.1;       % Evaporation Rate

par.v=19;           % Vehicle Average Velocity




%% ACO Main Loop
[BestSol HP_Log BestCost] = acoCalc(par, model);%#ok

%% Plot The Results
PlotTimeVaring(BestSol,model,HP_Log,par.Dyn)
%PlotProb(HP_Log,BestSol.Tour,model,par.Dyn)
PlotCost(BestCost.C,BestCost.L,BestCost.D,model,par.aL)
PlotClimbing(HP_Log,BestSol)
