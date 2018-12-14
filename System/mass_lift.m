function m = mass_lift(x)
m = 60.*x(4).*x(1) + (80 .* x(4) + 2000.*(x(3)./2).^2*pi)./8050;