function f = s2_objective(x, p)
% Gear Ratio Formula
R = p(1)./x(1);

% Efficiency
Hs = (R+1).*sqrt(1 - cos(p(4)).^2) - sin(p(4));
Ht = (R+1)./R.*sqrt(1 - cos(p(4)).^2) - sin(p(4));
eff_trans = 1 - (p(3)./2.*cos(p(4)))*((Hs.^2)+(Ht.^2))./(Hs + Ht); 

eff_sys = eff_trans .* p(6);

% Inerita of Gears
J_L = load_inertia(x, p);
J_M = motor_inertia(x, p);

% Angular Velocity of Motor
angV_motor = x(7)./ x(1);

% display([eff_sys J_L J_M]);

% OBJECTIVE FUNCTION for ENERGY
f = ((J_M + J_L./R.^2).*(angV_motor.*R).^2)./eff_sys;
end


