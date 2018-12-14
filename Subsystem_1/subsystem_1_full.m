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
%call solver to minimise

Minimisers_ag = ga(@s1_objective, nVar, [],[],[],[],lb,ub,@s1_constraint,[1 4])

%retrieve optimized 
MaximumCapacity_ga = calcCapacity(Minimisers_ag)

%% FUNCTIONS
%Objective Function: Calculate Maximum Passenger Capacity
function capacity = calcCapacity(x)
    %variables:
    carriers = x(1); %number of carriers 
    velocity = x(2); %cable speed
    diameter = x(3); %cable diameter
    seats = x(4); %number of seats per carrier
    %objective function:
    capacity = x(1)*x(2)*x(4)*3600/1000;
end
%objective function in negative null form
function obj = s1_objective(x)
    obj = -calcCapacity(x);
end

% Constraint 1: Minimum Interval between Carriers 
function g1 = calcg1(x)
     %% variables
    carriers = x(1);
    velocity = x(2);
    diameter = x(3);
    seats = x(4);
    %% parameters
    L = 1000; %overall length (m)
    h = sqrt(3.)*L/3; %overall height (m)
    theta = tan(h/L); %slope
    %% constraint g1
    g1 = (L*cos(theta))/(x(1)*x(2));
end 
% Constraint 2: Equalibrium Equation
function g2 = calg2(x)
    %% variables
    carriers = x(1);
    velocity = x(2);
    diameter = x(3);
    seats = x(4);
    %% parameters
    L = 1000; %overall length (m)
    h = sqrt(3.)*L/3; %overall height (m)
    theta = tan(h/L); %slope
    rho = 8050; %density of steel (kg/m^3)
    E = 200*10.^9; %Young's Modulus of steel (kg/ms^2)
    g = 9.8;
    qs = 392 + 20*g; %load of seat (N)
    qp = 784; %load of passenger (N)
    delta = 0.2; %deflection (m)
    k = delta*pi*E/(L*4); %constant 
    %% constraint g2
    g2 = x(4)*0.5*(x(1) + 1)*L*(qs + qp) - x(3).^2*(k*(cos(theta)*h + sin(theta)*L) + L*pi*rho*g*0.5);
end

%collecting the nonlinear equalities and inequalities for fmincon
function [c, ceq] = s1_constraint(x)
    %parameters:
    N = 2500*9.8; %load of towers
    L = 1000; %length of lane
    %constraints:
    c = [calcg1(x) - 5; calg2(x) - N*L];
    ceq = [];
end



