
% *********************
% Estimator design
% Example of page 168
%**********************
clc
clear all


%System matrices
A = -1;
B = 1;
C = 1;
D = 0;

%Computing the gain of the first observer
L1 = acker(A',C',-10)'
%Computing the gain of the second observer
L2 = acker(A',C',-2)'

%Initial condition of the system
x0=1

%initial condition of the observers/estimators
xest=0;
