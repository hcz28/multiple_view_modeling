clear
close all
clc
addpath(genpath('gco-v3.0'));

%% parameter setting
datapath='data09\';
lambda=0.4;
sigma=0.6;% large sigma,small smooth effect
scale=5;
%% main function
disp('Step1 : Uniform resampling...');
[images,lightVec] = unifResampling( datapath );

disp('Step2 : Initial normal estimation...');
[iniNormal] = initialNormal( images,lightVec );
normalMap(iniNormal,datapath,'Initial Normal Map');

disp('Step3 : Energy minimization via graph cuts...');
[refNormal] = normalRefine( iniNormal,lambda,sigma );
normalMap(refNormal,datapath,'Refined Normal Map');

disp('Step4 : Surface reconstruction...');
recSurf=surfReconstruct(refNormal,scale);
save([datapath 'recSurf.mat'],'recSurf');

%some parameters
%           lambda   sigma   scale
% data02      0.5     0.6     2
% data04      0.5     0.6     6
% data05      0.5     0.6     4
% data06      0.5     0.8     4
% data07      0.5     0.4     8
% data08      0.5     0.4     6
% data09      0.4     0.6     4
% data09      0.5     0.6     4