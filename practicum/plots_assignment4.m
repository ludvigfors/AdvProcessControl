% This file generates the plots for section 4 of the assignment
% main.m needs to be executed first to setup the system

%% Plot the comparison between the physical and the simulink model
load StepChangeControl.mat;
load StepChangeStateData.mat;
load StepChangeStepPoints.mat;


wc_eval = 7.5*2*pi;
R_eval = 0.01;
Q_eval = [0.04 0 0 0;
         0 2 0 0;
         0 0 0 0;
         0 0 0 0];
[K, ~, ~] = lqr(sys, Q_eval, R_eval);
out = sim("realistic_model.slx");

t = StateData.time;
filtered_pos = StateData.signals(1).values(:,1);
filtered_angle = StateData.signals(1).values(:,2);
filtered_control = Control.signals(1).values();

sim_t = out.real_simout.Time;
sim_filtered_pos = out.real_simout.Data(:,1);
sim_filtered_angle = out.real_simout.Data(:,2);
sim_control = out.real_simout_u.Data();

setpoints_t = SetPoints.time;
setpoints_pos =  SetPoints.signals(1).values(:,1);
setpoints_angle =  SetPoints.signals(1).values(:,2);

figure("Name","Reaction to step changes")


subplot(3,1,1)
hold on, grid on
plot(setpoints_t, setpoints_pos, "Color", "black", "LineStyle","--","DisplayName","Set point");
plot(t, filtered_pos,"DisplayName","Physical model");
plot(sim_t,sim_filtered_pos,"DisplayName","Simulink model","Color", "blue");
legend(Location="southeast")
ylabel("Position $x $ [m]","Interpreter","latex")
xlim([0,80])
subplot(3,1,2)
hold on, grid on
plot(setpoints_t, setpoints_angle, "Color", "black", "LineStyle","--","DisplayName","Set point");
plot(t, filtered_angle,"DisplayName","Physical model");
plot(sim_t,sim_filtered_angle,"DisplayName","Simulink model","Color", "blue");
ylabel("Angle $\alpha$ [rad]","Interpreter","latex")
xlim([0,80])
subplot(3,1,3)
hold on, grid on
ylim([-5,5])
plot(t, filtered_control,"DisplayName","Physical model","Color", "red");
plot(sim_t,sim_control,"DisplayName","Simulink model","Color", "blue");
ylabel("Control signal $u$ [V]","Interpreter","latex")
xlabel("Time [s]")
xlim([0,80])
% saveas(gcf,'figures/real_step_change',"epsc")


%% load kick disturbance

load KickControl.mat
load KickStateData.mat

disturbance_time = 16.32;
limits = [5,28];

t = StateData.time;
filtered_pos = StateData.signals(1).values(:,1);
filtered_angle = StateData.signals(1).values(:,2);
filtered_control = Control.signals(1).values();

subplot(3,1,1)
hold on, grid on
plot(t, filtered_pos,"DisplayName","Physical model");
ylabel("Position $x $ [m]","Interpreter","latex")
xline(disturbance_time,"--","DisplayName","Disturbance","LineWidth",2)
xlim(limits)
subplot(3,1,2)
hold on, grid on
plot(t, filtered_angle,"DisplayName","Physical model");
xline(disturbance_time,"--","DisplayName","Disturbance","LineWidth",2)
ylabel("Angle $\alpha$ [rad]","Interpreter","latex")
xlim(limits)
subplot(3,1,3)
hold on, grid on
ylim([-5,5])
plot(t, filtered_control,"DisplayName","Physical model");
xline(disturbance_time,"--","DisplayName","Disturbance","LineWidth",2)
ylabel("Control signal $u$ [V]","Interpreter","latex")
xlabel("Time [s]")
xlim(limits)

% saveas(gcf,'figures/kick',"epsc")

%% ramp disturbance

load DisturbanceControl.mat
load DisturbanceStateData.mat

limits = [4,25];

t = StateData.time;
filtered_pos = StateData.signals(1).values(:,1);
filtered_angle = StateData.signals(1).values(:,2);
filtered_control = Control.signals(1).values();

subplot(3,1,1)
hold on, grid on
plot(t, filtered_pos,"DisplayName","Physical model");
ylabel("Position $x $ [m]","Interpreter","latex")
xlim(limits)
subplot(3,1,2)
hold on, grid on
plot(t, filtered_angle,"DisplayName","Physical model");
ylabel("Angle $\alpha$ [rad]","Interpreter","latex")
xlim(limits)
subplot(3,1,3)
hold on, grid on
ylim([-5,5])
plot(t, filtered_control,"DisplayName","Physical model");
ylabel("Control signal $u$ [V]","Interpreter","latex")
xlabel("Time [s]")
xlim(limits)

% saveas(gcf,'figures/ramp',"epsc")

%% wc variation
values = ["4" ,"5" , "6.5","10","Inf"];
prefix = "wc";
suffixStateData = "StateData.mat";
suffixControl = "Control.mat";

limits = [0 14];

subplot(3,1,1)
hold on, grid on
ylabel("Position $x $ [m]","Interpreter","latex")
xlim(limits)
legend()
subplot(3,1,2)
hold on, grid on
ylabel("Angle $\alpha$ [rad]","Interpreter","latex")
xlim(limits)
ylim([-0.1 0.1])
subplot(3,1,3)
hold on, grid on
ylim([-5,5])
ylabel("Control signal $u$ [V]","Interpreter","latex")
xlabel("Time [s]")
xlim(limits)

t = 0:Ts:40;

for i=1:length(values)
    val =  erase(values(i),".");
    
    nameStateData = prefix + val + suffixStateData;
    nameControl = prefix + val + suffixControl;

    load(nameStateData)
    load(nameControl)
    
    filtered_control = Control.signals(1).values();
    start = find(filtered_control~=0, 1, 'first');
    filtered_control = filtered_control(start:end);
    filtered_pos = StateData.signals(1).values(start:end,1);
    filtered_angle = StateData.signals(1).values(start:end,2);
    t_short = t(1:length(filtered_control));
    
    

    name = "\omega_c = " + num2str(str2double(values(i))*2*pi,'%.2f');
    subplot(3,1,1)
    plot(t_short, filtered_pos,"DisplayName",name);

    subplot(3,1,2)
    plot(t_short, filtered_angle,"DisplayName",values(i));

    subplot(3,1,3)
    plot(t_short, filtered_control,"DisplayName",values(i));
end

% saveas(gcf,'figures/real_wcs',"epsc")


