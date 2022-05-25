%% Clear workspace
clear all
close all
clc

%% Load data
load references_09.mat

% given parameters of the quadcopter model
m = 0.5;
L = 0.25;
k = 3e-6;
b = 1e-7;
g = 9.81;
kd = 0.25;
Ixx = 5e-3;
Iyy = 5e-3;
Izz = 1e-2;
cm = 1e4;

%% Find the equilibrium point

equi = [k*cm/m k*cm/m k*cm/m k*cm/m;
    1 0 -1 0;
    0 1 0 -1;
    1 -1 1 -1];

disp("input value $v^2$ for the rotors in equilibrium state")
u = equi\[g 0 0 0]'

disp("The equilibrium states are 0.")

% phi theta psi
% omega_x omega_y omega_z
phi = 0;
theta = 0;
psi = 0;
omega_x = 0;
omega_y = 0;
omega_z = 0;

%[x y z vx vy vz φ θ ψ ωx ωy ωz ]

jacobian = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
            0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
            0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
     0 0 0 -kd/m 0 0 k*cm/m*(sin(psi)*cos(phi)-cos(psi)*sin(phi)*sin(theta))*(u(1)+u(2)+u(3)+u(4)) k*cm/m*(cos(psi)*cos(phi)*cos(theta))*(u(1)+u(2)+u(3)+u(4)) k*cm/m*(cos(psi)*sin(phi) - sin(psi)*cos(phi)*sin(theta))*(u(1)+u(2)+u(3)+u(4)) 0 0 0 k*cm/m*(sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta)) k*cm/m*(sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta)) k*cm/m*(sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta)) k*cm/m*(sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta));
     0 0 0 0 -kd/m 0 k*cm/m*(-sin(phi)*sin(psi)*sin(theta)-cos(psi)*cos(phi))*(u(1)+u(2)+u(3)+u(4)) k*cm/m*(cos(phi)*sin(psi)*cos(theta))*(u(1)+u(2)+u(3)+u(4)) k*cm/m*(cos(phi)*cos(psi)*sin(theta)+sin(psi)*sin(phi))*(u(1)+u(2)+u(3)+u(4)) 0 0 0 k*cm/m*(cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi)) k*cm/m*(cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi)) k*cm/m*(cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi)) k*cm/m*(cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi));
     0 0 0 0 0 -kd/m k*cm/m*(-cos(theta)*sin(phi))*(u(1)+u(2)+u(3)+u(4)) k*cm/m*(-sin(theta)*cos(phi))*(u(1)+u(2)+u(3)+u(4)) 0 0 0 0 k*cm/m*(cos(theta)*cos(phi)) k*cm/m*(cos(theta)*cos(phi)) k*cm/m*(cos(theta)*cos(phi)) k*cm/m*(cos(theta)*cos(phi));
     0 0 0 0 0 0 cos(phi)*tan(theta)*omega_y-sin(phi)*tan(theta)*omega_z sin(phi)/cos(theta)^2*omega_y+cos(phi)/cos(theta)^2*omega_z 0 1 sin(phi)*tan(theta) cos(phi)*tan(theta) 0 0 0 0;
     0 0 0 0 0 0 -sin(phi)*omega_y-cos(phi)*omega_z 0 0 0 cos(phi) -sin(phi) 0 0 0 0;
     0 0 0 0 0 0 cos(phi)/cos(theta)*omega_y-sin(phi)/cos(theta)*omega_z sin(phi)*sin(theta)/cos(theta)^2*omega_y+cos(phi)*sin(theta)/cos(theta)^2*omega_z 0 0 sin(phi)/cos(theta) cos(phi)/cos(theta) 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 -(Iyy-Izz)/Ixx*omega_z -(Iyy-Izz)/Ixx*omega_y L*k*cm/Ixx 0 -L*k*cm/Ixx 0;
     0 0 0 0 0 0 0 0 0 -(Izz-Ixx)/Iyy*omega_z 0 -(Izz-Ixx)/Iyy*omega_x 0 L*k*cm/Iyy 0 -L*k*cm/Iyy;
     0 0 0 0 0 0 0 0 0 -(Ixx-Iyy)/Izz*omega_y -(Ixx-Iyy)/Izz*omega_x 0 b*cm/Izz -b*cm/Izz b*cm/Izz -b*cm/Izz];

A = jacobian(1:12,1:12);
B = jacobian(1:12,13:16);
C = [eye(3) zeros(3,9);
    zeros(3,6) eye(3) zeros(3,3)];
D = zeros(6,4);

Ts = 0.05;

%% Discretization using zero on hold (A not invertable -> pseudo inverse)
Az = expm(A*Ts);
Bz = pinv(A)*(expm(A*Ts) - eye(12))*B;
Cz = C;
Dz = D;

% G_DT_3 = tf(ss(Az,Bz,Cz,Dz,Ts))

% Alternatively (shortcut)
% G_DT_4 = c2d(G,Ts,"zoh")

Ad = Az;
Bd = Bz;
Cd = Cz;
Dd = Dz;


%% Plot step response
sys_c = ss(A,B,C,D);
sys_d = ss(Ad,Bd,Cd,Dd,Ts);

% Get system for output 2, input 3
sys_c_23 = sys_c(2,3);
sys_d_23 = sys_d(2,3);
%step(sys_c_23, sys_d_23);
%legend show;
%grid on;


%% Open Loop analysis
sys = sys_d;

% Stable
fprintf("Poles of the system");
pole(sys)

fprintf("Transmission zeros of the system");
[Z, NRK] = tzero(sys);
Z

fprintf("No transmission zeros\n\n");

% Controlability
C_M = [B Ad*Bd Ad^2*B Ad^3*Bd];
fprintf("Rank of the controlability matrix (n=12)");
rank(C_M)

% Observability
O_M = [Cd; Cd*Ad; Cd*Ad^2; Cd*Ad^3];
fprintf("Rank of the observability matrix (n=12)");
rank(O_M)

% Detetectability
% System is detectable since the system is fully observable.

% Stabilizable
% System is stabilizable since the system is fully controllable.

% Minimal
% Minimal since the system is both controlable and observable.


%% Compute matrices Nx and Nu
% Nx maps steady state y to x
% Nu maps steady state y to u

%number of states     
nx = 12;
%number of inputs
nu = 4;
%number of outputs
ny = 6;

big_A = [A-eye(nx,nx) B;
         C D];

big_Y = [zeros(nx,ny);
         eye(ny,ny)];

big_N = big_A \ big_Y;

Nx = big_N(1:nx,:);
Nu = big_N(nx+1:end,:);

%% LQR Control


Q = eye(nx,nx) * 1;
Q(1,1) = 1;
Q(2,2) = 1;
Q(3,3) = 5;

%Q(4,4) = 10;
%Q(5,5) = 10;
%Q(6,6) = 10;

R = eye(nu,nu) * 0.001;

[K, S, CLP] = dlqr(Ad,Bd,Q,R);

%%
r0 = zeros(ny,1);
r1 = r0;
r1(1) = 2;
r1(2) = 2;
r1(3)= 1;



