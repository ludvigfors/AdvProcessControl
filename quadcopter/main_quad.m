%% Clear workspace
clear all
close all
clc

%% Load data
load references_09.mat

% Given parameters of the quadcopter model
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

disp("input value v^2 for the rotors in equilibrium state")
u = equi\[g 0 0 0]'

disp("The equilibrium states are 0.")

phi = 0;
theta = 0;
psi = 0;
omega_x = 0;
omega_y = 0;
omega_z = 0;


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
Ad = expm(A*Ts);
Bd = pinv(A)*(expm(A*Ts) - eye(12))*B;
Cd = C;
Dd = D;


%% Plot step response (Verify discrete model)
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


%% Define variables

%number of states     
nx = 12;
%number of inputs
nu = 4;
%number of outputs
ny = 6;



%% 4.3 LQR Control


%% LQR Control (without integral action)

% Compute matrices Nx and Nu

big_A = [Ad-eye(nx,nx) Bd;
         Cd Dd];

big_Y = [zeros(nx,ny);
         eye(ny,ny)];

big_N = big_A \ big_Y;

Nx = big_N(1:nx,:);
Nu = big_N(nx+1:end,:);

% Define LQR matrices Q and R
Q = eye(nx,nx);
Q(1,1) = 5;
Q(2,2) = 5;
Q(3,3) = 2e6;

R = eye(nu,nu) * 1e-1;

% Compute K for system
[K, S, CLP] = dlqr(Ad,Bd,Q,R);

fprintf("Poles of system")
eig(Ad-Bd*K)


%% LQR Control (with integral action)

% Define the integrator gain Kint
Kint = 5.5;

% Constructing the Augmented system

% Define the integrators
% First 3 diagonal entries = 1 -> 3 integrators for x,y and z respectivly
int_mat = [eye(3) zeros(3);
         zeros(3) zeros(3)];


% Create the augmented system (see slides on reference tracking)
NA = [ int_mat Cd;
       zeros(nx,ny) Ad];

NB = [ Dd
       Bd];

%checking the controlabillity of the Augmented system
disp('Rank of the controllability matrix of the augmented system:');
rank(ctrb(NA,NB))


%%
% Define LQR matrices Q and R
Q = eye(nx+ny);
Q(1,1) = 500;
Q(2,2) = 500;
Q(3,3) = 10;
Q(16,16) = 10;
Q(17,17) = 10;
Q(18,18) = 10;


R = eye(nu) * 0.01;

% Compute K for augmented system
[full_K, S, CLP] = dlqr(NA,NB,Q,R);

% Get K gain for the augmented state vector (y-r error)
Ki = full_K(:,1:ny);

% Get K gain for original state x
Ks = full_K(:,ny+1:end);


%% 4.4 LQG Control

V_var = [2.5e-5;
         2.5e-5;
         2.5e-5;
         7.57e-5;
         7.57e-5;
         7.57e-5];

B1 = eye(nx);

% Covariance matrix for process noise
Qk = eye(nx);
Qk(6,6) = 500; % Increase some priority for Vz.

% Covariance matrix for measurement noise
Rk = eye(ny);

[L,P] = dlqe(Ad,B1,Cd,Qk,Rk);

fprintf("Poles of system")
eig(Ad-L*Cd)


%% 4.5 State feedback design via Pole Placement

% damping ratio
dr = 0.9;

% settling time
ts = 5;

wn = 4.6/(dr*ts);

alpha = -dr*wn;
beta = wn*sqrt(1-dr^2);

poles_desired = [alpha+beta*1j alpha-beta*1j alpha+beta*1j alpha-beta*1j];

for k=1:2
   poles_desired = [poles_desired (5+k)*alpha (5+k)*alpha];
   poles_desired = [poles_desired (5+k)*alpha (5+k)*alpha];

end

% Compute K for system
K = place(Ad,Bd,exp(Ts*poles_desired))

fprintf("Poles of controller system")
eig(Ad-Bd*K)

% Compute L for estimator

L = place(Ad',Cd', exp(Ts*10*poles_desired))'

fprintf("Poles of estimator system")
eig(Ad-L*Cd)
