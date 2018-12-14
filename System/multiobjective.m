function f = multiobjective(x, w, p)

m_lift = mass_lift(x);
f = w(1)*10000*s1_objective(x(1:4)) + w(2)*s2_objective([x(5:9), m_lift,x(2)], p);
