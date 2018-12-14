function m = mass_lift(x)
% This function calculates the mass of the lift based on variables 
% of subsystem 1
m = 60.*x(4).*x(1) + (80 .* x(4) + 2000.*(x(3)./2).^2*pi)./8050;