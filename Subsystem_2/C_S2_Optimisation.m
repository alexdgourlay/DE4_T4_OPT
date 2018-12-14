addpath('./S2_Functions');
global motorX;
global p;

%% Optimisation - fmincon
% Creating Anonymous functions for the objectives and constraints
fun = @(x)s2_objective(x,p);

% Creating an array of initial guesses
x0 = [1, 200, 3, 2, 300, 3000, 7];

% No linear constraints
A = [];
b = [];
Aeq = [];
beq = [];

% Lower bounds
lb = [0, min(motorX(:,1)), min(motorX(:,2)), min(motorX(:,3)),...
            min(motorX(:,4)), 2317, 6];
% Upper bounds
ub = [2, max(motorX(:,1)), max(motorX(:,2)), max(motorX(:,3)),...
            max(motorX(:,4)), 6951, 18];

% Setting up nonlinear constraint function
nonlcon = @(x)nlcon(x, p);

% Choosing sqp algorithm
options = optimoptions('fmincon','Algorithm','sqp');

% Running optimisation
[x_fmin, fval_fmin] = fmincon(fun, x0, A, b, Aeq, beq,...
                                lb, ub, nonlcon,options);


%% Optimisation - Global Search
rng(2);
gs = GlobalSearch;

% Setting up GS problem using same conditions
problem = createOptimProblem('fmincon','x0',x0,...
    'objective',fun,'lb',lb,'ub',ub, 'nonlcon', nonlcon);

% Running Optimisation
x_gs = run(gs,problem);

fval_gs = s2_objective(x_gs, p);

%% Optimisation - ga
% Running genetic algorithm
[x_ga, fval_ga] = ga(fun,7, A, b, Aeq, beq, lb, ub, nonlcon);

