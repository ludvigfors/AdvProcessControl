% This file generates the plots for section 2 of the assignment
% main.m needs to be executed first to setup the system

%% Plotting the effect of varying Q(1,1)
Q_temp = Q;
q1s = [0.025 0.125 0.25 1.25 2.5 25 250];
res_q1s = [];
for i=1:length(q1s)
    Q_temp(1,1) = q1s(i);
    [K,~,~] = lqr(sys,Q_temp,R);
    sim('simple_model.slx');
    res_q1s = [res_q1s, simout];
end

figure("Name","Effect of varying Q(1,1)")

subplot(2,1,1)
hold on, grid on
ylabel("Position $x $ [m]","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
ylabel("Angle $\alpha $ [rad] ","Interpreter","latex")
xlabel("Time [s]","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
for i=1:length(q1s)
    subplot(2,1,1)
    plot(res_q1s(i).Time,res_q1s(i).Data(:,1),'DisplayName',"Q(1,1) = " + num2str(q1s(i)))
    subplot(2,1,2)
    plot(res_q1s(i).Time,res_q1s(i).Data(:,2),'DisplayName',"Q(1,1) = " + num2str(q1s(i)))
end
% saveas(gcf,'figures/change_q1',"epsc")

%% Plotting the effect of varying Q(2,2)
Q_temp = Q;
q2s = [0.4 2 4 8 40 400 4000];
res_q2s = [];
for i=1:length(q2s)
    Q_temp(2,2) = q2s(i);
    [K,~,~] = lqr(sys,Q_temp,R);
    sim('simple_model.slx');
    res_q2s = [res_q2s, simout];
end

figure("Name","Effect of varying Q(2,2)")
subplot(2,1,1)
hold on, grid on
ylabel("Position $x $ [m]","Interpreter","latex")
yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
ylabel("Angle $\alpha $ [rad] ","Interpreter","latex")
xlabel("Time [s]","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
for i=1:length(q2s)
    subplot(2,1,1)
    plot(res_q2s(i).Time,res_q2s(i).Data(:,1),'DisplayName',"Q(2,2) = " + num2str(q2s(i)))  
    subplot(2,1,2)
    plot(res_q2s(i).Time,res_q2s(i).Data(:,2),'DisplayName',"Q(2,2) = " + num2str(q2s(i)))  
end
% saveas(gcf,'figures/change_q2',"epsc")
%% Plotting the effect of varying R
R_temp = R;
rs = [0.00003 0.001 0.003 0.01 0.03 0.3 3];
res_rs = [];
res_rs_u = [];

x_limit = [0.5 4];
for i=1:length(rs)
    R_temp = rs(i);
    [K,~,~] = lqr(sys,Q,R_temp);
    sim('simple_model.slx');
    res_rs = [res_rs, simout];
    res_rs_u = [res_rs_u, simout_u];
end

figure("Name","Effect of varying R")
subplot(3,1,1)
hold on, grid on
xlim(x_limit)
ylabel("Position $x $ [m]","Interpreter","latex")
% yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(3,1,2)
hold on, grid on
xlim(x_limit)
ylabel("Angle $\alpha $ [rad] ","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")

subplot(3,1,3)
ylim([-2 2])
xlim(x_limit)
hold on, grid on
ylabel("Control signal $u$ [V] ","Interpreter","latex")
xlabel("Time [s]","Interpreter","latex")

for i=1:length(rs)
    subplot(3,1,1)
    plot(res_rs(i).Time,res_rs(i).Data(:,1),'DisplayName',"R = " + num2str(rs(i)))  
    subplot(3,1,2)
    plot(res_rs(i).Time,res_rs(i).Data(:,2),'DisplayName',"R = " + num2str(rs(i)))
    subplot(3,1,3)
    plot(res_rs_u(i).Time,res_rs_u(i).Data(:,1),'DisplayName',"R = " + num2str(rs(i))) 
end
% saveas(gcf,'figures/change_r',"epsc")
% saveas(gcf,'figures/change_dist_r',"epsc")
%% Testing the chosen optimal Q and R values - pzmap
figure("Name","Pole zero map")

Standard_values = ss(A-B*K,zeros(4,1),C,D);
Chosen_values = ss(A-B*K_alt,zeros(4,1),C,D);
pzplot(Standard_values,Chosen_values)
grid on
a=findobj(gca,'type','line');
set(a(3),'linewidth',2)
set(a(3),'markersize',10)
set(a(5),'linewidth',2)
set(a(5),'markersize',10)

legend show

%% Testing the chosen optimal Q and R values - Step response


sim('simple_model.slx');
simout_orig = simout;
K_temp = K;
K = K_alt;
sim('simple_model.slx');
K = K_temp;

figure("Name","Optimal Q and R values")
subplot(2,1,1)
hold on, grid on
ylabel("Position $x $ [m]","Interpreter","latex")
% yline(0.1,"--",'DisplayName',"Set point")
legend("location","southeast")
subplot(2,1,2)
hold on, grid on
ylabel("Angle $\alpha $ [rad] ","Interpreter","latex")
xlabel("Time [s]","Interpreter","latex")
yline(0,"--",'DisplayName',"Set point")
subplot(2,1,1)
plot(simout_orig.Time,simout_orig.Data(:,1),'DisplayName',"Original value")  
plot(simout.Time,simout.Data(:,1),'DisplayName',"Optimal value")  
subplot(2,1,2)
plot(simout_orig.Time,simout_orig.Data(:,2),'DisplayName',"Original value")  
plot(simout.Time,simout.Data(:,2),'DisplayName',"Optimal value") 

% saveas(gcf,'figures/step_comparison',"epsc")

%% Testing the chosen optimal Q and R values - Control output


sim('simple_model.slx');
simout_orig = simout_u;
K_temp = K;
K = K_alt;
sim('simple_model.slx');
K = K_temp;

figure("Name","Optimal Q and R values")
hold on, grid on
ylabel("Control signal $u $ [V]","Interpreter","latex")
xlabel("Time [s]","Interpreter","latex")
legend("location","southeast")

plot(simout_orig.Time,simout_orig.Data(:,1),'DisplayName',"Original value")  
plot(simout_u.Time,simout_u.Data(:,1),'DisplayName',"Optimal value")  

% saveas(gcf,'figures/control_comparison',"epsc")