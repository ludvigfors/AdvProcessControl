%***************************************
% Inverted Pendulum
% Pole Placement
%***************************************

clear all
close all
clc

%% Defining the System Matrices
disp('System matrices:')

A = [ 0          0        1         0
      0          0        0         1
      0    -4.5231     -16.8835     0
      0     46.9609     55.3557     0];
 
B = [ 0
      0
      3.7778
      -12.3862];
  
C = [1  0  0  0
     0  1  0  0];
 
D = [0
     0];

%Creation of a state-space object
sys = ss (A,B,C,D)

%% Checking Stability
disp('Poles:')
eig (A)

%plotting the location of the poles
pzmap(sys);

%% Checking controllability

disp ('Controllability matrix');
CO = ctrb(A,B)
disp('Rank of the controllability matrix:');
rank(CO)

%% Determination of the desired closed-loop poles
dr = 0.7; %Damping ratio
ts = 2;   %Settling time

wn = 4.6/(dr*ts); %Natural frequency

alpha = -dr*wn;         %Real part of the dominant poles
beta = wn*sqrt(1-dr^2); %Imaginary part of the dominant poles
%cl_poles=[alpha+beta*i alpha-beta*i  -46 -50]' %desired closed-loop poles
cl_poles=[alpha+beta*i alpha-beta*i  10*alpha 10.1*alpha]'
%cl_poles=[alpha+beta*i alpha-beta*i  -460 -500]'


%% Ackermann's method

coeff_ec = poly (cl_poles); %Desired characteristic equation

disp('Gain of the Controller (Ackermanns method):')

% Computing K – First way
ec_A = polyvalm(coeff_ec,A); %Evaluation of the characteristic equation at A (pretty much calculate what A should be based on the desired closed loop poles)
K = [0 0 0 1]*inv(CO)*ec_A   %Ackermann’s formula

% Computing K – Second way
K = acker(A,B,cl_poles)     %Shortcut!


%% Defining the closed-loop system
% x_dot = (A - B*K)*x
% y = c*x

A_cl = A - B*K;
B_cl = [0;0;0;0];
C_cl = C;
D_cl = D;
sys_cl = ss(A_cl,B_cl,C_cl, D_cl);
sys_cl.OutputName={'z','\theta'};

disp('closed-loop poles:');
eig(A_cl)

%% Response to initial conditions

%Setting the initial conditions
x0 = [0  10*pi/180 0 0 ];

%Plotting the response of the closed-loop system to 
%the initial conditions
initial(sys_cl,x0)
grid

















