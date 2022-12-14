function [featureTable,outputTable] = generateFeatures(inputData)
%DIAGNOSTICFEATURES recreates results in Diagnostic Feature Designer.
%
% Input:
%  inputData: A table or a cell array of tables/matrices containing the
%  data as those imported into the app.
%
% Output:
%  featureTable: A table containing all features and condition variables.
%  outputTable: A table containing the computation results.
%
% This function computes features:
%  ch1_stats/Col1_CrestFactor
%  ch1_stats/Col1_Kurtosis
%  ch1_stats/Col1_RMS
%  ch1_stats/Col1_Std
%  ch2_stats/Col1_Mean
%  ch2_stats/Col1_RMS
%  ch2_stats/Col1_Skewness
%  ch2_stats/Col1_Std
%  ch3_stats/Col1_CrestFactor
%  ch3_stats/Col1_SINAD
%  ch3_stats/Col1_SNR
%  ch3_stats/Col1_THD
%
% Organization of the function:
% 1. Compute signals/spectra/features
% 2. Extract computed features into a table
%
% Modify the function to add or remove data processing, feature generation
% or ranking operations.

% Auto-generated by MATLAB on 18-Feb-2021 14:19:33

% Create output ensemble.
outputEnsemble = workspaceEnsemble(inputData,'DataVariables',["ch1";"ch2";"ch3"],'ConditionVariables',"label");

% Reset the ensemble to read from the beginning of the ensemble.
reset(outputEnsemble);

% Append new signal or feature names to DataVariables.
outputEnsemble.DataVariables = unique([outputEnsemble.DataVariables;"ch1_stats";"ch2_stats";"ch3_stats"],'stable');

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = ["ch1","ch2","ch3"];

% Loop through all ensemble members to read and write data.
while hasdata(outputEnsemble)
    % Read one member.
    member = read(outputEnsemble);
    
    % Get all input variables.
    ch1 = readMemberData(member,"ch1","Col1");
    ch2 = readMemberData(member,"ch2","Col1");
    ch3 = readMemberData(member,"ch3","Col1");
    
    % Initialize a table to store results.
    memberResult = table;
    
    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = ch1.Col1;
        Col1_CrestFactor = peak2rms(inputSignal);
        Col1_Kurtosis = kurtosis(inputSignal);
        Col1_RMS = rms(inputSignal,'omitnan');
        Col1_Std = std(inputSignal,'omitnan');
        
        % Concatenate signal features.
        featureValues = [Col1_CrestFactor,Col1_Kurtosis,Col1_RMS,Col1_Std];
        
        % Package computed features into a table.
        featureNames = ["Col1_CrestFactor","Col1_Kurtosis","Col1_RMS","Col1_Std"];
        ch1_stats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,4);
        featureNames = ["Col1_CrestFactor","Col1_Kurtosis","Col1_RMS","Col1_Std"];
        ch1_stats = array2table(featureValues,'VariableNames',featureNames);
    end
    
    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({ch1_stats},'VariableNames',"ch1_stats")]; %#ok<AGROW>
    
    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = ch2.Col1;
        Col1_Mean = mean(inputSignal,'omitnan');
        Col1_RMS = rms(inputSignal,'omitnan');
        Col1_Skewness = skewness(inputSignal);
        Col1_Std = std(inputSignal,'omitnan');
        
        % Concatenate signal features.
        featureValues = [Col1_Mean,Col1_RMS,Col1_Skewness,Col1_Std];
        
        % Package computed features into a table.
        featureNames = ["Col1_Mean","Col1_RMS","Col1_Skewness","Col1_Std"];
        ch2_stats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,4);
        featureNames = ["Col1_Mean","Col1_RMS","Col1_Skewness","Col1_Std"];
        ch2_stats = array2table(featureValues,'VariableNames',featureNames);
    end
    
    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({ch2_stats},'VariableNames',"ch2_stats")]; %#ok<AGROW>
    
    %% SignalFeatures
    try
        % Compute signal features.
        inputSignal = ch3.Col1;
        Col1_CrestFactor = peak2rms(inputSignal);
        Col1_SINAD = sinad(inputSignal);
        Col1_SNR = snr(inputSignal);
        Col1_THD = thd(inputSignal);
        
        % Concatenate signal features.
        featureValues = [Col1_CrestFactor,Col1_SINAD,Col1_SNR,Col1_THD];
        
        % Package computed features into a table.
        featureNames = ["Col1_CrestFactor","Col1_SINAD","Col1_SNR","Col1_THD"];
        ch3_stats = array2table(featureValues,'VariableNames',featureNames);
    catch
        % Package computed features into a table.
        featureValues = NaN(1,4);
        featureNames = ["Col1_CrestFactor","Col1_SINAD","Col1_SNR","Col1_THD"];
        ch3_stats = array2table(featureValues,'VariableNames',featureNames);
    end
    
    % Append computed results to the member table.
    memberResult = [memberResult, ...
        table({ch3_stats},'VariableNames',"ch3_stats")]; %#ok<AGROW>
    
    %% Write all the results for the current member to the ensemble.
    writeToLastMemberRead(outputEnsemble,memberResult)
end

% Gather all features into a table.
featureTable = readFeatureTable(outputEnsemble);

% Set SelectedVariables to select variables to read from the ensemble.
outputEnsemble.SelectedVariables = unique([outputEnsemble.DataVariables;outputEnsemble.ConditionVariables;outputEnsemble.IndependentVariables],'stable');

% Gather results into a table.
outputTable = readall(outputEnsemble);
end