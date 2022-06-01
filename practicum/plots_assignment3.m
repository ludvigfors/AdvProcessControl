% % This file generates the plots for section 3 of the assignment
% main.m needs to be executed first to setup the system

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
ylim([-2,2])

plot(simout_u.Time,simout_u.Data(:,1),'DisplayName',"Simple model") 
plot(out.real_simout_u.Time,out.real_simout_u.Data(:,1),'DisplayName',"Realistic model")  


% saveas(gcf,'figures/simple_realistic_comp_control',"epsc")
%% Comparison between Q(1,1) = 1.25 and Q(1,1)=0.4 for the realistic model

out_old = sim('realistic_model.slx');
Q_alt(1,1) = 0.4;
[K,~,~] = lqr(sys,Q_alt,R_alt);
out = sim('realistic_model.slx');
Q_alt(1,1) = 1.25;
[K,~,~] = lqr(sys,Q,R);

figure("Name","Comparison of optimized and retuned model")
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
plot(out_old.real_simout.Time,out_old.real_simout.Data(:,1),'DisplayName',"Q(1,1) = 1.25") 
plot(out.real_simout.Time,out.real_simout.Data(:,1),'DisplayName',"Q(1,1) = 0.4")  
subplot(2,1,2)
plot(out_old.real_simout.Time,out_old.real_simout.Data(:,2),'DisplayName',"Q(1,1) = 1.25") 
plot(out.real_simout.Time,out.real_simout.Data(:,2),'DisplayName',"Q(1,1) = 0.4") 

% saveas(gcf,'figures/realistic_tuned_comp',"epsc")

%% Plotting the effect of changing wc
 
Q_alt(1,1) = 0.4;
[K,~,~] = lqr(sys,Q_alt,R_alt);
wc_temp = Wc;
wcs = [1 2 7.5 20 200 ].*(2*pi);
res_wcs = [];
for i= 1:length(wcs)
    Wc = wcs(i);
    out = sim('realistic_model.slx');
    res_wcs = [res_wcs,out];
end
Wc = wc_temp;
Q_alt(1,1) = 1.25;
[K,~,~] = lqr(sys,Q,R);

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
    plot(res_wcs(i).real_simout.Time,res_wcs(i).real_simout.Data(:,1),'DisplayName',"\omega_c = " + num2str(wcs(i),'%.2f'))
    subplot(2,1,2)
    plot(res_wcs(i).real_simout.Time,res_wcs(i).real_simout.Data(:,2),'DisplayName',"\omega_c = " + num2str(wcs(i),'%.2f'))
end

% saveas(gcf,'figures/vary_wc',"epsc")