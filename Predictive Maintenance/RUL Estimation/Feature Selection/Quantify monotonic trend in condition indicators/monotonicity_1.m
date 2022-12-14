%%% Quantify monotonic trend in condition indicators

%% Monotonicity of Data in Cell Array of Matrices
% In this example, consider the lifetime data of 10 identical machines with the following 6 potential prognostic parameters−constant, linear, quadratic, cubic, logarithmic, and periodic. 
% The data set machineDataCellArray.mat contains C, which is a 1x10 cell array of matrices where each element of the cell array is a matrix that contains the lifetime data of a machine. 
% For each matrix in the cell array, the first column contains the time while the other columns contain the data variables.

% Load the lifetime data and visualize it against time.
load('machineDataCellArray.mat','C')
display(C)

figure
for k = 1:length(C)
    plot(C{k}(:,1), C{k}(:,2:end));
    hold on;
end

% Observe the 6 different condition indicators–constant, linear, quadratic, cubic, logarithmic, and periodic–for all 10 machines on the plot.

% Visualize the monotonicity of the potential prognostic features.
figure
monotonicity(C)

% From the histogram plot, observe that the features Var2, Var4 and Var5 rank better than the others. 
% Hence, these features are more appropriate for remaining useful life predictions since they are the best indicators of machine health.

%% Monotonicity of Data in Cell Array of Tables
% In this example, consider the lifetime data of 10 identical machines with the following 6 potential prognostic parameters−constant, linear, quadratic, cubic, logarithmic, and periodic. 
% The data set machineDataTable.mat contains T, which is a 1x10 cell array of tables where each element of the cell array contains a table of lifetime data for a machine.

% Load and display the data.
load('machineDataTable.mat','T');
display(T)

head(T{1},2)

% Note that every table in the cell array contains the lifetime variable 'Time' and the data variables 'Constant', 'Linear', 'Quadratic', 'Cubic', 'Logarithmic', and 'Periodic'.

% Compute monotonicity using Spearman's rank correlation method with Time as the lifetime variable.
Y = monotonicity(T,'Time','Method','rank')

% From the resulting table of monotonicity values, observe that the linear, cubic, and logarithmic features have values closer to 1. 
% Hence, these three features are more appropriate for predicting remaining useful life since they are the best indicators of machine health.

%% Visualize Monotonicity of Lifetime Data in Ensemble Datastore
% Consider the lifetime data of 4 machines. Each machine has 4 fault codes for the potential condition indicators−voltage, current, and power. 
% monotonicityEnsemble.zip is a collection of 4 files where every file contains a timetable of lifetime data for each machine − tbl1.mat, tbl2.mat, tbl3.mat, and tbl4.mat. 
% You can also use files containing data for multiple machines. 
% For each timetable, the organization of the data is as follows:

figure
imshow("VisualizeMonotonicityOfLifetimeDataExample_01.png")

% When you perform calculations on tall arrays, MATLAB® uses either a parallel pool (default if you have Parallel Computing Toolbox™) or the local MATLAB session. 
% To run the example using the local MATLAB session, change the global execution environment by using the mapreducer function.
mapreducer(0)

% Extract the compressed files, read the data in the timetables, and create a fileEnsembleDatastore object using the timetable data. 
% For more information on creating a file ensemble datastore, see fileEnsembleDatastore.
unzip monotonicityEnsemble.zip;
ens = fileEnsembleDatastore(pwd,'.mat');
ens.DataVariables = {'Voltage','Current','Power','FaultCode','Machine'};
% Make sure that the function for reading data is on path
addpath(fullfile(matlabroot,'examples','predmaint','main')) 
ens.ReadFcn = @readtable_data;
ens.SelectedVariables = {'Voltage','Current','Power','FaultCode','Machine'};

% Visualize the monotonicity of the potential prognostic features with 'Machine' as the member variable and group the lifetime data by 'FaultCode'. 
% Grouping the lifetime data ensures that monotonicity calculates the metric for each fault code separately.
monotonicity(ens,'MemberVariable','Machine','GroupBy','FaultCode');

% monotonicity returns a histogram plot with the features ranked by their monotonicity values. 
% A higher monotonicity value indicates a more suitable prognostic parameter. 
% For instance, the candidate feature Current has the highest monotonic trend for machines with FaultCode 1.
rmpath(fullfile(matlabroot,'examples','predmaint','main')) % Reset path