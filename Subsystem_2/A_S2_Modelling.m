clear(), clc; 
addpath('./S2_Functions');

%% Loading in Motor Data and Assigning to range space
data = readtable('OPT_SiemensCatalogue.xlsx');
Y = table2array(data(:,'J'));
x_Trated = table2array(data(:, 'T'));
x_Tb = table2array(data(:, 'T_b_T_rated'));
x_Tl = table2array(data(:, 'T_lr_T_rated'));
x_nrated = table2array(data(:, 'n'));

global motorX;
motorX = [x_Trated, x_Tb, x_Tl, x_nrated];

%% Visualising Motor Inertia against torque and rated n
[xq,yq] = meshgrid(linspace(min(x_Trated), max(x_Trated), 30),...
                    linspace(min(x_nrated), max(x_nrated), 30));
            
[gridX, gridY, gridZ] = griddata(x_Trated, x_nrated,Y, xq, yq, 'linear');

mesh(gridX, gridY, gridZ);
hold on
plot3(x_Trated, x_nrated,Y, 'o');
xlabel('$t_{rated}$', 'Interpreter','latex', 'FontSize', 15); 
ylabel('$n_{rated}$', 'Interpreter','latex', 'FontSize', 15);
zlabel('$J$', 'Interpreter','latex', 'FontSize', 15);

%% Generating a normalised model for Rsquared assessment
rng(2);

N = length(motorX);
slice_idx = round(0.85*N);
idxs = randperm(N);

% Array of the train indeces
train_idxs = idxs(1:slice_idx);
% Array of the test indeces
test_idxs = idxs(slice_idx + 1:end);

% Normalization of train data sets
[xTorque_Train,PS_xTorque_Train] = mapstd(motorX(train_idxs,:)');
[yInertia_Train,PS_yInertia_Train] = mapstd(Y(train_idxs)');

% Normalization of test data sets
xTorque_Test = mapstd('apply', motorX(test_idxs,:)', PS_xTorque_Train);
yInertia_Test = mapstd('apply', Y(test_idxs)', PS_yInertia_Train);

% Train Model
Betas_Train = mvregress(xTorque_Train', yInertia_Train');

% Finding the R^2 value
Rsq = 1 - norm(yInertia_Test' - xTorque_Test' * Betas_Train)^2 ...
                        / norm(yInertia_Test' - mean(yInertia_Test))^2;

%% Set Betas as Global for Use in Optimisation
global betas;
betas = Betas_Train;
