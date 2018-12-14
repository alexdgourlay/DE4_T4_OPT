function [c, ceq] = nlcon(x, p)

c = [x(6) - x(2)./x(1),...
    (motor_inertia(x, p) + load_inertia(x,p).*x(7)./x(1))./ (x(4).*x(2) - x(6).*p(1)) - 30,...
    (motor_inertia(x, p) + load_inertia(x,p).*x(7)./x(1))./ (x(3).*x(2) + x(6).*p(1)) - 100];

ceq = [];





