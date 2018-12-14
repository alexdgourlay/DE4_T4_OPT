%Objective Function: Calculate Maximum Passenger Capacity
function capacity = calcCapacity(x)
    %variables:
    carriers = x(1); %number of carriers 
    velocity = x(2); %cable speed
    diameter = x(3); %cable diameter
    seats = x(4); %number of seats per carrier
    %objective function:
    capacity = x(1)*x(2)*x(4)*3600/1000;
end