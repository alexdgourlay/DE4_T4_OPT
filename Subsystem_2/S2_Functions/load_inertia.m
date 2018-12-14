function J_L = load_inertia(x, p)

J_sheave = 0.5.*p(2).*pi.*p(1).^4.*p(5);
J_L = x(6) .* p(1).^2 + J_sheave;