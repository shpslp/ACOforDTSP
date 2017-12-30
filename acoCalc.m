function [BestSol HP_Log BestCost] = acoCalc(par, model)%#ok
%% Initialization

eta=1./model.D;                   % Heuristic Information Matrix

nVar = model.n;
tau0=10*par.Q/(nVar*mean(model.D(:)));	% Initial Phromone
tau=tau0*ones(nVar,nVar);         % Phromone Matrix

BestCost.C=zeros(par.MaxIt,1);    % Array to Hold Best Cost Values
BestCost.L=zeros(par.MaxIt,1);
BestCost.D=zeros(par.MaxIt,1);

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];
empty_ant.Lcost=[];
empty_ant.Dcost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,par.nAnt,1);

% Best Ant
BestSol.Cost=inf;

% Parameter Setting
MaxIt = par.MaxIt;
nAnt = par.nAnt;
aL = par.aL;
Dyn = par.Dyn;
Q = par.Q;
alpha = par.alpha;
beta = par.beta;
gamma = par.gamma;
rho = par.rho;
v = par.v;


for it=1:MaxIt    
    % Move Ants
    for k=1:nAnt
        
        ant(k).Tour=[1 randi([2 nVar])];
        
        for l=2:nVar
            
            i=ant(k).Tour(end);
            
            % Get log of visited time and visited time home-probablity 
            HP_Log = TourLog(ant(k).Tour,model,v); 
            
            % Decision Making Process
            P=tau(i,:).^alpha.*eta(i,:).^beta.* HP_Log(end,:).^(Dyn*gamma);
            
            P(ant(k).Tour)=0;   % ommit the visited house
                      
            P=P/sum(P);
            
            j=RouletteWheelSelection(P);
            
            ant(k).Tour=[ant(k).Tour j];
            
        end
        
        % Evaluate Tour
        ant(k).Cost=CostFunction(HP_Log,ant(k).Tour,model,aL,Dyn);
        ant(k).Lcost=TourLength(ant(k).Tour,model);
        ant(k).Dcost=ExpectedDelivery(HP_Log,ant(k).Tour);
        
        % Update Best Cost
        if ant(k).Cost<BestSol.Cost
            BestSol=ant(k);
        end
        
    end
    
    % Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        
        tour=[tour tour(1)]; %#ok
        
        for l=1:nVar
            
            i=tour(l);
            j=tour(l+1);
            
            tau(i,j)=tau(i,j)+Q/ant(k).Cost;
            
        end
        
    end
    
    % Evaporation
    tau=(1-rho)*tau;
    
    % Store Best Cost
    BestCost.C(it)=BestSol.Cost;
    BestCost.L(it)=BestSol.Lcost;
    BestCost.D(it)=BestSol.Dcost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Length Cost = ' num2str(BestCost.L(it)) ': Best Cost = ' num2str(BestCost.C(it))]);
    
    % Plot Solution
    figure(1);
    PlotSolution(BestSol.Tour,model);
    pause(0.01);
end
close all;
figure('Position', [720 480 480 360]);
PlotSolution(BestSol.Tour,model);
if Dyn==0
    saveas(gcf,[pwd '/output/Tour_Static.png'])
elseif Dyn==1
    saveas(gcf,[pwd '/output/Tour_Dynamic.png'])
end
end