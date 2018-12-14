function [c, ceq] = sys_nlcon(x, p)

% Calling subsystem 1's constraint function.
[c1, ceq1] = s1_constraint(x(1:4));

% Calling subsystem 2's constraint function.
m_lift = mass_lift(x);
[c2, ceq2] = nlcon([x(5:9), m_lift, x(2)], p);

c = [c1; c2'];
ceq = [];