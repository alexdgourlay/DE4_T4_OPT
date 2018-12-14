function f = multiobjective(x, w, p)

m_lift = mass_lift(x);

% Objective function

f = w(1)*10000*s1_objective(x(1:4))... % weighting of subsystem 1 * scale factor * s1_objective
    + w(2)*s2_objective([x(5:9), m_lift,x(2)], p); % weighting of subsystem 2 * s2_objective
