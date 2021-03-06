% This file creates the sets up the variables and the system for the 
% later assignments and performs some analysis on the open loop properties
%% Define variables
Rm = 2.6; % Omh
Km = 0.00767; % Nm/A
Kb = Km; % V/(rad/s)
Kg = 3.7; % Ratio
M = 0.455; % Kg
l = 0.305; % m
m = 0.210; % Kg
r = 0.635e-2; % m
g = 9.81; % m/s^2

% Define simulation variables
Ts = 0.005; % seconds, corresponding to 200Hz
Wc = 2*2*pi; % rad/s, cutoff frequency of low pass filter

% Define State Space matrices
A = [0 0 1 0;
     0 0 0 1;
     0 -m*g/M (-Kg^2*Km*Kb)/(M*Rm*r^2) 0;
     0 (M+m)*g/(M*l) (Kg^2*Km*Kb)/(M*Rm*r^2*l) 0];

B = [0;
     0;
     (Km*Kg)/(M*Rm*r);
     (-Km*Kg)/(r*Rm*M*l)];

C = [1 0 0 0;
     0 1 0 0];

D = [0;
     0];

% Generate model
sys = ss(A,B,C,D);
x_initial = [0 0 0 0]';
%% Open Loop analysis

% Stable
disp("Poles of the system");
pole(sys)

disp("Transmission zeros of the system");
[Z, NRK] = tzero(sys);
Z

fprintf("No transmission zeros");

% Controlability
C_M = [B A*B A^2*B A^3*B];
disp("Rank of the controlability matrix (n=4)");
rank(C_M)


% Observability
O_M = [C; C*A; C*A^2; C*A^3];
disp("Rank of the observability matrix (n=4)");
rank(O_M)

% Detetectability
% System is detectable since the system is fully observable.

% Stabilizable
% System is stabilizable since the system is fully controllable.

% Minimal
% Minimal since the system is both controlable and observable.

%% Design LQR controller and calculate K
Q = [0.25 0 0 0;
     0 4 0 0;
     0 0 0 0;
     0 0 0 0];
R = 0.003;
[K, ~, ~] = lqr(sys, Q, R);
% alternative, tuned version
Q_alt = [1.25 0 0 0;
         0 2 0 0;
         0 0 0 0;
         0 0 0 0];
R_alt = 0.01;
[K_alt,~,~] = lqr(sys,Q_alt,R_alt);







