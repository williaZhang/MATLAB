%%% Exponential degradation model for estimating remaining useful life

%% Train Exponential Degradation Model
% Load training data.
load('expTrainVectors.mat')

% The training data is a cell array of column vectors. Each column vector is a degradation feature profile for a component.
% Create an exponential degradation model with default settings.
mdl = exponentialDegradationModel;

% Train the degradation model using the training data.
fit(mdl,expTrainVectors)

%% Create Exponential Degradation Model with Known Priors
% Create an exponential degradation model, and configure it with a known prior distribution.
mdl = exponentialDegradationModel('Theta',0.5,'ThetaVariance',0.003,...
                                  'Beta',0.3,'BetaVariance',0.002,...
                                  'Rho',0.1);

% The specified prior distribution parameters are stored in the Prior property of the model.
mdl.Prior

% The current posterior distribution of the model is also set to match the specified prior distribution. For example, check the posterior value of the correlation parameter.
mdl.Rho 

%% Train Exponential Degradation Model Using Tabular Data
% Load training data.
load('expTrainTables.mat')

% The training data is a cell array of tables. 
% Each table is a degradation feature profile for a component. 
% Each profile consists of life time measurements in the "Time" variable and corresponding degradation feature measurements in the "Condition" variable.

% Create a exponential degradation model with default settings.
mdl = exponentialDegradationModel;

% Train the degradation model using the training data. Specify the names of the life time and data variables.
fit(mdl,expTrainTables,"Time","Condition")

%% Predict RUL Using Exponential Degradation Model
% Load training data.
load('expTrainTables.mat')

% The training data is a cell array of tables. 
% Each table is a degradation feature profile for a component. 
% Each profile consists of life time measurements in the "Hours" variable and corresponding degradation feature measurements in the "Condition" variable.

% Create an exponential degradation model, specifying the life time variable units.
mdl = exponentialDegradationModel('LifeTimeUnit',"hours");

% Train the degradation model using the training data. Specify the names of the life time and data variables.
fit(mdl,expTrainTables,"Time","Condition")

% Load testing data, which is a run-to-failure degradation profile for a test component. The test data is a table with the same life time and data variables as the training data.
load('expTestData.mat')

% Based on knowledge of the degradation feature limits, define a threshold condition indicator value that indicates the end-of-life of a component.
threshold = 500;

% Assume that you measure the component condition indicator every hour for 150 hours. 
% Update the trained degradation model with each measurement. 
% Then, predict the remaining useful life of the component at 150 hours. 
% The RUL is the forecasted time at which the degradation feature will pass the specified threshold.
for t = 1:150 
 update(mdl,expTestData(t,:)) 
end 
estRUL = predictRUL(mdl,threshold) 

% The estimated RUL is around 137 hours, which indicates a total predicted life span of 287 hours.

%% Update Exponential Degradation Model and Predict RUL
% Load observation data.
load('expTestData.mat')

% For this example, assume that the training data is not historical data, but rather real-time observations of the component condition.

% Based on knowledge of the degradation feature limits, define a threshold condition indicator value that indicates the end-of-life of a component.
threshold = 500;

% Create an exponential degradation model arbitrary prior distribution data and a specified noise variance. Also, specify the life time and data variable names for the observation data.
mdl = exponentialDegradationModel('Theta',1,'ThetaVariance',1e6,...
                                  'Beta',1,'BetaVariance',1e6,...
                                  'NoiseVariance',0.003,...
                                  'LifeTimeVariable',"Time",'DataVariables',"Condition",...
                                  'LifeTimeUnit',"hours");

% Observe the component condition for 100 hours, updating the degradation model after each observation.
for i=1:100
    update(mdl,expTestData(i,:));
end

% After 100 hours, predict the RUL of the component using the current life time value stored in the model. Also, obtain the confidence interval associated with the estimated RUL.
estRUL = predictRUL(mdl,threshold)

% The estimated RUL is about 234 hours, which indicates a total predicted life span of 334 hours.
