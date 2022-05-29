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


%% Define variables

%number of states     
nx = 12;
%number of inputs
nu = 4;
%number of outputs
ny = 6;


%% Setpoint
r0 = zeros(ny,1);
r1 = r0;
r1(1) = 1;
r1(2) = 1;
r1(3)= 1;


%% 4.3 LQR Control

%% LQR Control (without payload)

%% LQR Control (without integral action)

% Compute matrices Nx and Nu

% Nx maps steady state y to x
% Nu maps steady state y to u


big_A = [Ad-eye(nx,nx) Bd;
         Cd Dd];

big_Y = [zeros(nx,ny);
         eye(ny,ny)];

big_N = big_A \ big_Y;

Nx = big_N(1:nx,:);
Nu = big_N(nx+1:end,:);

% Define LQR matrices Q and R
Q = eye(nx,nx) * 0.001;

R = eye(nu,nu) * 0.0001;

% Compute K for system
[K, S, CLP] = dlqr(Ad,Bd,Q,R);


%% LQR Control (with integral action)

% Constructing the Augmented system

% Define the integrators
% First 3 diagonal entries = 1 -> 3 integrators for x,y and z respectivly
int_mat = [eye(3) zeros(3);
         zeros(3) zeros(3)];

% Define the integrator gain Kint
Kint = 6;

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



%% Description of design proccess

%% LQR without integral action
% First we calculated Nx and Nu based on the formulas provided in the
% slides.

% The weighting matrices Q and R where obtained after doing some research
% on common starting points of Q and R which resulted in diagonal matrices.
% After some trial and error we fitting values for Q and R.

% We calculated the gain (K) of the system using dlqr.

% The performance gives steady state errors.

%% LQR with integral action

% We first created the matrix representing the 3 integrators that
% represents the error from the refernece signal for x, y and z position.
% This

% Then we designed the augmented system (we add a new state vector 
% representing the error (y-r)).
% This resulted in matrices NA and NB.

% The Q and R started with diagonal matrices. 
% We relilzed that it is harder for the quadcopter to in x and y direction than
% in the z direction (since the quadcopter only has to increase or decrease 
% the speed of the motors to change z position). 
% So we gave the integrators for x and y position higher values in Q than z positions.
% We also relized after some trial and error that the values for the 
% angular velocities had to be set to some higher values (we set them to 10).
% The R values we set to 0.01.

% These values gave decent results. However, the system was still too slow.
% So we increased the integrator gain from 1 to 6 which increased
% performace significantly.

% We calculated the gain (K) of the augmented system using dlqr.

% The first 6 columns of K represents the gain (Ki) for the new state
% vector.

% The resting 12 columns of K represents the gain (Ks) for the original
% vector x.


%% Discussion of results
% The LQR controller with integral action performs better since it
% eliminates the steady state error (especially for the z position)


%% LQR Control (with payload)

% Define the integrator gain Kint
Kint = 5.5;

%% Discussion 0 vs 0.1 kg payload
% For the system with integral action, there was no noticable difference 
% detween 0 and 0.1 kg payload.

% For the system without integral action, 
% the steady state error of the z position increased from
% -25 with 0 kg payload to -30 with 0.1 kg payload.
% This makes sence since the payload is increasing the weight and
% thus the quadcopter has to fight gravity more.

% For the system with integral action, the system became unstable.
% however if we decrased the integrator gain from 6 to 5.5, it worked
% better.

% The system without integral action seems to be more robust to outside 
% disturbances (e.g the payload). If we have increased disturbance for the
% system with integral action, the integrator gain has to be decreased
% which makes the system slower (but more robust to disturbances).

% The fundamental difference between the fullstate feedback controller and 
% the integral controller is that the integral controller adds integrators
% and computes the input signal to the plant based on not just the 
% difference of the state from the desired state but also uses the error 
% of the output signal signal from the reference. This leads to 
% elimination of steady state error.


%% 4.4 LQG Control

V_var = [2.5e-5;
         2.5e-5;
         2.5e-5;
         7.57e-5;
         7.57e-5;
         7.57e-5];

B1 = eye(nx);

Qk = eye(nx);
Qk(6,6) = 500; % Increase some priority for Vz.

Rk = eye(ny);

[M,P] = dlqe(Ad,B1,Cd,Qk,Rk);

L=Ad*M;

%% Discussion of Kalman Filter

% 5.961 sec without payload - no kalman
% 6.128 sec without payload - kalman

% Adding a kalman filter increases the avergage time a 
% little bit but the system becomes more robust to noise.
% Both systems clear all checkpoints.



% 5.972 sec with payload - no kalman
% 6.136 ith payload - kalman

% No real difference in performance when adding payload.


%% 4.5 State feedback design via Pole Placement

% Compute K for system
G = rand(4,5);

eig1 = [ -3 1; 
        -1 -3];
eig2 = [-2 -1; 
         1 -2];
eig_1 = -1;

Lambda = blkdiag(eig1,eig2,eig_1);

% Solve sylvester equation for MIMO systems
X = lyap(Ad,-Lambda,-Bd*G);
K = G/X;


%% Compute L
G_e = rand(6,1);
eig1 = -2;

Lambda_e = blkdiag(eig1);

% Solve sylvester equation for MIMO systems
X1 = lyap(Ad',-Lambda_e,-Cd'*G_e);
L = (G_e/X1)';

% Alternative way to calculate L
cl_poles = [-2,-3,-4,-5,-6,-7,-8,-9,-10, -11, -12, -13];
L_alt = place(Ad',Cd',cl_poles)';

