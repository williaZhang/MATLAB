function [scenario, egoVehicle] = ACC_01_ISO_TargetDiscriminationTest()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.9 (R2020b) and Automated Driving Toolbox 3.2 (R2020b).
% Generated on: 30-Nov-2020 12:50:56

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    600 0 0];
laneSpecification = lanespec(2);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [0 1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'egoCar');
waypoints = [0 1.8 0;
    600 1.8 0];
speed = 30;
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
leadCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [76 1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'leadCar');
waypoints = [76 1.8 0;
    148 1.8 0;
    186.25 1.8 0;
    600 1.8 0];
speed = [24;24;27;27];
trajectory(leadCar, waypoints, speed);

thirdCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [76 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'thirdCar');
waypoints = [76 -1.8 0;
    600 -1.8 0];
speed = 24;
trajectory(thirdCar, waypoints, speed);
