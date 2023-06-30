function [scenario, egoVehicle] = ACC_04_StopnGo()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.9 (R2020b) and Automated Driving Toolbox 3.2 (R2020b).
% Generated on: 30-Nov-2020 12:52:10

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    700 0 0];
laneSpecification = lanespec(2);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [1 1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'egoCar');
waypoints = [1 1.8 0;
    700 1.8 0];
speed = 27;
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
leadCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [51 1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'leadCar');
waypoints = [51 1.8 0;
    229.5 1.8 0;
    313.5 1.8 0;
    418.5 1.8 0;
    498.5 1.8 0;
    673.5 1.8 0];
speed = [27;27;15;15;25;25];
trajectory(leadCar, waypoints, speed);

car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [40 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car1');
waypoints = [40 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car1, waypoints, speed);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [80 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car2');
waypoints = [80 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car2, waypoints, speed);

car3 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [120 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car3');
waypoints = [120 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car3, waypoints, speed);

car4 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [160 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car4');
waypoints = [160 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car4, waypoints, speed);

car5 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [200 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car5');
waypoints = [200 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car5, waypoints, speed);

car6 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [240 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car6');
waypoints = [240 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car6, waypoints, speed);

car7 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [280 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car7');
waypoints = [280 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car7, waypoints, speed);

car8 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [320 -1.8 0], ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'car8');
waypoints = [320 -1.8 0;
    700 -1.8 0];
speed = 12;
trajectory(car8, waypoints, speed);
