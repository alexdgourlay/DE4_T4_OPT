% Constraint 2: Equalibrium Equation
function g2 = calg2(x)
    %% variables
    carriers = x(1);
    velocity = x(2);
    diameter = x(3);
    seats = x(4);
    %% parameters
    L = 1000; %overall length (m)
    h = sqrt(3.)*L/3; %overall height (m)
    theta = tan(h/L); %slope
    rho = 8050; %density of steel (kg/m^3)
    E = 200*10.^9; %Young's Modulus of steel (kg/ms^2)
    g = 9.8;
    qs = 392 + 20*g; %load of seat (N)
    qp = 784; %load of passenger (N)
    delta = 0.2; %deflection (m)
    k = delta*pi*E/(L*4); %constant 
    %% constraint g2
    g2 = x(4)*0.5*(x(1) + 1)*L*(qs + qp) - x(3).^2*(k*(cos(theta)*h + sin(theta)*L) + L*pi*rho*g*0.5);
end

