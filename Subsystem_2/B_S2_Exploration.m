addpath('./S2_Functions');
global motorX;

% Fixed parameters to be used in objective equation e.g. 
% !Not Variables!
global p;
p = [2,... %radius of sheave
    7860,... %density of steel
    0.5,... %coefficient of friction
    25,... %pressure angle
    0.3,... %thickness of gears
    0.92]; %K_HT

% Nominal variable values for use in DOE
x = [1,... %radius of drive cog
    500,... %torque of motor
    3,... % Tb
    2,... %Tl
    300,... %n_rated 
    3000,... %mass_lift
    7]; %v_lift

%% Second Order DOE, changing r_drivecog and t_rated
meshZ = @(x1, x2)param_objective(x1, x2, x(3), x(4), x(5), x(6), x(7), p);
fs = fmesh(meshZ, [0.1, 2, min(motorX(:,1)), max(motorX(:,1))]);

% Plot Features
fs.FaceColor = 'cyan';
set(gca,'Xdir','reverse','Ydir','reverse')
xlabel('$r_{drive cog}$', 'Interpreter','latex', 'FontSize', 15); 
ylabel('$t_{rated}$', 'Interpreter','latex', 'FontSize', 15);
zlabel('$Energy$', 'Interpreter','latex', 'FontSize', 15);

%% First Order DOE, changing each variable individually.
% Setting up anonymouse equations
x1_r_drivecog = @(x1) param_objective(x1, x(2), x(3), x(4), x(5), x(6), x(7), p);
x2_t_motor = @(x2) param_objective(x(1), x2, x(3), x(4), x(5), x(6), x(7), p);
x3_T_b = @(x3) param_objective(x(1), x(2), x3, x(4), x(5), x(6), x(7), p);
x4_T_l = @(x4) param_objective(x(1), x(2), x(3), x4, x(5), x(6), x(7), p);
x5_n_rated = @(x5) param_objective(x(1), x(2), x(3), x(4), x5, x(6), x(7), p);
x6_m_lift = @(x6) param_objective(x(1), x(2), x(3), x(4), x(5), x6, x(7), p);
x7_v_lift = @(x7) param_objective(x(1), x(2), x(3), x(4), x(5), x(6), x7, p);

figure('Position', [200 200 1600 300]);
fontSize = 15;

subplot(1,7,1);
fplot(x1_r_drivecog, [0.2 2]);
title('$r_{drive cog}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,2);
fplot(x2_t_motor, [min(motorX(:,1)) max(motorX(:,1))]);
title('$\tau_{drive cog}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,3);
fplot(x3_T_b, [min(motorX(:,2)) max(motorX(:,2))]);
title('$T_{b}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,4);
fplot(x4_T_l, [min(motorX(:,2)) max(motorX(:,2))]);
title('$T_{l}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,5);
fplot(x5_n_rated, [min(motorX(:,2)) max(motorX(:,2))]);
title('$n_{rated}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,6);
fplot(x6_m_lift, [0 5000]);
title('$m_{lift}$', 'Interpreter','latex', 'FontSize', fontSize);

subplot(1,7,7);
fplot(x7_v_lift, [0 10]);
title('$v_{lift}$', 'Interpreter','latex', 'FontSize', fontSize);
