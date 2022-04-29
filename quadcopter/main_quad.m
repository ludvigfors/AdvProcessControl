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

a = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
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