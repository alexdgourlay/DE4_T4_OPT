% Constraint 1: Minimum Interval between Carriers 
function g1 = calcg1(x)
     %% variables
    carriers = x(1);
    velocity = x(2);
    diameter = x(3);
    seats = x(4);
    %% parameters
    L = 1000; %overall length (m)
    h = sqrt(3.)*L/3; %overall height (m)
    theta = tan(h/L); %slope
    %% constraint g1
    g1 = (L*cos(theta))/(x(1)*x(2));
end 