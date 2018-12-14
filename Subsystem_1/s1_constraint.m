%collecting the nonlinear equalities and inequalities for fmincon
function [c, ceq] = s1_constraint(x)
    %parameters:
    N = 2500*9.8; %load of towers
    L = 1000; %length of lane
    %constraints:
    c = [calcg1(x) - 5; calg2(x) - N*L];
    ceq = [];
end
