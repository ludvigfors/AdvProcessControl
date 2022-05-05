%% 

% Define variables
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
Ts = 0.05; % seconds, corresponding to 200Hz
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


% part C
% The control goal is about the stabilizing of the system so the rod 
% angle is zero and the carts position is at the desired position.

% We want the system to have a fast response and robust to disturbances.

%% Design LQR controller and calculate K
Q = [0.25 0 0 0;
     0 4 0 0;
     0 0 0 0;
     0 0 0 0];

Q_alt = [1.25 0 0 0;
         0 2 0 0;
         0 0 0 0;
         0 0 0 0];

R = 0.003;
R_alt = 0.003;

x_initial = [0 0 0 0]';

[K, S, CLP] = lqr(sys, Q, R);
[K_alt,~,~] = lqr(sys,Q_alt,R_alt);

% imp = [0 0.01 0 0]';
% Reg_sys = ss(A-B*K,-B*K*imp,C,D);

%% Varying Q(1,1)
Q_alt = Q;
R_alt = R;
q1s = [0.025 0.125 0.25 1.25 2.5 25 250];
res_q1s = [];
for i=1:length(q1s)
    Q_alt(1,1) = q1s(i);
    [K_alt,~,~] = lqr(sys,Q_alt,R_alt);
    sim('ip_simulink_main.slx');
    res_q1s = [res_q1s, simout];
end

%% Varying Q(2,2)
Q_alt = Q;
R_alt = R;
q2s = [0.4 2 4 8 40 400 4000];
res_q2s = [];
for i=1:length(q2s)
    Q_alt(2,2) = q2s(i);
    [K_alt,~,~] = lqr(sys,Q_alt,R_alt);
    sim('ip_simulink_main.slx');
    res_q2s = [res_q2s, simout];
end

%% Varying R
Q_alt = Q;
R_alt = R;
rs = [0.00003 0.001 0.003 0.01 0.03 0.3 3];
res_rs = [];
for i=1:length(rs)
    R_alt = rs(i);
    [K_alt,~,~] = lqr(sys,Q_alt,R_alt);
    sim('ip_simulink_main.slx');
    res_rs = [res_rs, simout];
end

%% Plotting Q(1,1)
figure("Name","Effect of varying Q(1,1)")

subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
for i=1:length(q1s)
    subplot(2,1,1)
    plot(res_q1s(i).Time,res_q1s(i).Data(:,1),'DisplayName',"Q(1,1) = " + num2str(q1s(i)))
    subplot(2,1,2)
    plot(res_q1s(i).Time,res_q1s(i).Data(:,2),'DisplayName',"Q(1,1) = " + num2str(q1s(i)))
end
% saveas(gcf,'figures/change_q1',"epsc")
%% Plotting Q(2,2)
figure("Name","Effect of varying Q(2,2)")
subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
for i=1:length(q2s)
    subplot(2,1,1)
    plot(res_q2s(i).Time,res_q2s(i).Data(:,1),'DisplayName',"Q(2,2) = " + num2str(q2s(i)))  
    subplot(2,1,2)
    plot(res_q2s(i).Time,res_q2s(i).Data(:,2),'DisplayName',"Q(2,2) = " + num2str(q2s(i)))  
end
% saveas(gcf,'figures/change_q2',"epsc")
%% Plotting R
figure("Name","Effect of varying R")
subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
for i=1:length(rs)
    subplot(2,1,1)
    plot(res_rs(i).Time,res_rs(i).Data(:,1),'DisplayName',"R = " + num2str(rs(i)))  
    subplot(2,1,2)
    plot(res_rs(i).Time,res_rs(i).Data(:,2),'DisplayName',"R = " + num2str(rs(i)))  
end
% saveas(gcf,'figures/change_r',"epsc")
%% Testing
% initial(Reg_sys,[0 15*pi/180 0 0])
% figure("Name","Pole/zero map")
% pzmap(Reg_sys)
% figure("Name","Step response")
% step(Reg_sys)
% figure("Name","Impulse response")
% impulse(Reg_sys)

%% Testing the chosen optimal Q and R values - pzmap
figure("Name","Pole zero map")

Standard_values = ss(A-B*K,zeros(4,1),C,D);
Chosen_values = ss(A-B*K_alt,zeros(4,1),C,D);
pzmap(Standard_values,Chosen_values)
grid on
a=findobj(gca,'type','line')
set(a(3),'linewidth',2)
set(a(3),'markersize',10)
set(a(5),'linewidth',2)
set(a(5),'markersize',10)
legend show

%% Testing the chosen optimal Q and R values - Step response


sim('ip_simulink_main.slx');
simout_orig = simout;
K_temp = K;
K = K_alt;
sim('ip_simulink_main.slx');
K = K_temp;

figure("Name","Optimal Q and R values")
subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
subplot(2,1,1)
plot(simout_orig.Time,simout_orig.Data(:,1),'DisplayName',"Original value")  
plot(simout.Time,simout.Data(:,1),'DisplayName',"Optimal value")  
subplot(2,1,2)
plot(simout_orig.Time,simout_orig.Data(:,2),'DisplayName',"Original value")  
plot(simout.Time,simout.Data(:,2),'DisplayName',"Optimal value") 

% saveas(gcf,'figures/step_comparison',"epsc")

%% Testing the chosen optimal Q and R values - Control output


sim('ip_simulink_main.slx');
simout_orig = simout_u;
K_temp = K;
K = K_alt;
sim('ip_simulink_main.slx');
K = K_temp;

figure("Name","Optimal Q and R values")
hold on, grid on
title("Magnitude of the control signal $u $ [V]","Interpreter","latex")
legend("location","southeast")

plot(simout_orig.Time,simout_orig.Data(:,1),'DisplayName',"Original value")  
plot(simout_u.Time,simout_u.Data(:,1),'DisplayName',"Optimal value")  

% saveas(gcf,'figures/control_comparison',"epsc")

%% Comparison between simple and realistic simulink model
K_temp = K;
K = K_alt;
sim('ip_simulink_main.slx');
out = sim('realistic_model.slx');
K = K_temp;

figure("Name","Comparison between simple and realistic model")
subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
subplot(2,1,1)
plot(simout.Time,simout.Data(:,1),'DisplayName',"Simple model")  
plot(out.real_simout.Time,out.real_simout.Data(:,1),'DisplayName',"Realistic model")  
subplot(2,1,2)
plot(simout.Time,simout.Data(:,2),'DisplayName',"Original value")  
plot(out.real_simout.Time,out.real_simout.Data(:,2),'DisplayName',"Optimal value") 

% saveas(gcf,'figures/simple_realistic_comp',"epsc")

%% Comparison between simple and realistic simulink model control signal
K_temp = K;
K = K_alt;
sim('ip_simulink_main.slx');
out = sim('realistic_model.slx');
K = K_temp;

figure("Name","Optimal Q and R values")
hold on, grid on
title("Magnitude of the control signal $u $ [V]","Interpreter","latex")
legend("location","southeast")

plot(simout_u.Time,simout_u.Data(:,1),'DisplayName',"Simple model") 
plot(out.real_simout_u.Time,out.real_simout_u.Data(:,1),'DisplayName',"Realistic model")  


% saveas(gcf,'figures/simple_realistic_comp_control',"epsc")

%% Investigation of the effect of the filter cutoff fequency

wc_temp = Wc;
wcs = [0.85 1 2 20 200 ].*(2*pi);
res_wcs = [];
for i= 1:length(wcs)
    Wc = wcs(i);
    out = sim('realistic_model.slx');
    res_wcs = [res_wcs,out];
end
Wc = wc_temp;

%% Plotting the effect of changing wc
 
figure("Name","Effect of varying wc")

subplot(2,1,1)
hold on, grid on
title("Position $x $ [m] of the cart ","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
ylim([-0.02 0.12])
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
title("Angle $\alpha $ [rad] of the rod ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
ylim([-0.03 0.05])
for i=1:length(wcs)
    subplot(2,1,1)
    plot(res_wcs(i).real_simout.Time,res_wcs(i).real_simout.Data(:,1),'DisplayName',"Wc = " + num2str(wcs(i)))
    subplot(2,1,2)
    plot(res_wcs(i).real_simout.Time,res_wcs(i).real_simout.Data(:,2),'DisplayName',"Wc = " + num2str(wcs(i)))
end

% saveas(gcf,'figures/vary_wc',"epsc")






