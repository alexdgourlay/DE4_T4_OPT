tic
%% OPTIMISATION WITH FMINCON
%initial guess : using values from already existing system with similar
%parameters
carriersGuess = 25;
velocityGuess = 2.28;
diameterGuess = 0.01;
seatsGuess = 2;

%load guess values into array
x0 = [carriersGuess, velocityGuess, diameterGuess, seatsGuess];

% Bounds: adding lower and upper bounds to constraint the design variables
% carriers are bounded in terms of efficiency
% velocity is bounded in terms of logistics, although this will be altered in the combination of subsystems 
% diameter is bounded in terms of availability in the market
lb = [1, 1, 0.0005,2];
ub = [50, 12, 0.01,6];


%call solver to minimise
Minimisers_fmincon = fmincon(@s1_objective, x0, [],[],[],[],lb,ub,@s1_constraint)

%retrieve optimized 
MaximumCapacity_fmincon = calcCapacity(Minimisers_fmincon)

%% OPTIMISATION WITH FMINCON updated
%In this case, once the results are shown, the variable x1 should be a
%discrete variable, that is why in this updated version, the variable can
%just take the value of the optimised solution from the previous one (x1 = 19 carriers)
lb_2 = [1, 1, 0.0005,2];
ub_2 = [19, 12, 0.1,2];

Minimisers_fmincon_updated = fmincon(@s1_objective, x0, [],[],[],[],lb_2,ub_2,@s1_constraint)

%retrieve optimized 
MaximumCapacity_fmincon_updated = calcCapacity(Minimisers_fmincon_updated)

%% Finding the global minimisers for fmincon
rng default % For reproducibility
gs = GlobalSearch;
passengers = @(x)-calcCapacity(x); %calling objective function
constraints = @(x)s1_constraint(x); %calling constraint functions
problem = createOptimProblem('fmincon','x0',[25 ; 2.28; 0.01 ; 2],...
    'objective',passengers,'lb',[1 ; 1; 0.0005 ; 2],'ub',[20, 12, 0.1,2],'nonlcon',constraints);

fmincon_Global = run(gs,problem) %retreive results for global search

%% OPTIMISATION WITH GENETIC ALGORITHM
% This is the approach taken to find the minimisers and the minised
% ojective function including discrete variables.

% Bounds: adding lower and upper bounds to constraint the design variables
% carriers are bounded in terms of efficiency
% velocity is bounded in terms of logistics, although this will be altered in the combination of subsystems 
% diameter is bounded in terms of availability in the market

lb = [1, 1, 0.005,2];
ub = [200, 10, 0.01,6];

nVar = 4; % there are four variables
%call solver to minimise with genetic algorithm

Minimisers_ag = ga(@s1_objective, nVar, [],[],[],[],lb,ub,@s1_constraint,[1 4])

%retrieve optimized 
MaximumCapacity_ga = calcCapacity(Minimisers_ag)


toc