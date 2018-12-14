clear;clc;
addpath('../Subsystem_1');
addpath('../Subsystem_2');
addpath('../Subsystem_2/S2_Functions');

%% Setting up handles
% Parameters for subsystem 2 
p = [2, 7860, 0.5, 25, 0.3, 0.92];

% Initial guesses
x0 = [20, 2.28, 0.01, 2, 1, 200, 3, 2, 300];

A = [];
b = [];
Aeq = [];
beq = [];

% Lower and Upper Bounds, copied from subsystem scripts
lb = [15,1,0.0005,2,0.1,2.1,2.60,1.8,875];
ub = [50,12,0.01,6,2,1401,5.6,4.3,3585];

%% Optimize with a weighted sum
options = optimset('Algorithm','sqp');
n = 30;     % Number of Pareto points to produce
wsweights = linspace(0.7, 1, n);
xws = zeros(n,9); 
fws = zeros(n,3); % 1st col V, 2nd col F, 3rd col weighted obj
for i = 1:n
    w = [wsweights(i), 1-wsweights(i)];
    fun = @(x)multiobjective(x,w,p);
    [xopt,fopt] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,@(x)sys_nlcon(x,p),options);
    xws(i,:) = xopt; 
    fws(i,3) = fopt;
    fws(i,1) = -s1_objective(xws(i,1:4));
    fws(i,2) = s2_objective([xws(i,5:9), mass_lift(xws(i,:)),xws(i,2)],p);
end

%% Plot Pareto frontiers
capacity = fws(:,1)';
energy = fws(:,2)';
scatter(capacity, energy);
set(gca,'Xdir','reverse');
xlabel('Capacity'); ylabel('Energy Consumption');
title('Pareto Set');

a = wsweights'; 
dx = -20; dy = 0; % displacement so the text does not overlay the data points

for i = 1:length(capacity)-1
    if abs(capacity(i)-capacity(i+1))> 0.3
    text(capacity(i)+dx, energy(i)-dy,...
        sprintf('w_{1}=%.2f,w_{2}=%.2f', a(i), 1-a(i)),'FontSize', 8 );
    end
end
