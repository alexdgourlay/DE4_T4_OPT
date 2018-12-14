function J_M = motor_inertia(x, p)

global betas
J_drivecog = 0.5.*p(2).*pi.*x(1).^4.*p(5);
J_motor = betas(1).* x(2) + betas(2).*x(3) + betas(3).*x(4) + betas(4).*x(5);
J_M = J_motor + J_drivecog;

