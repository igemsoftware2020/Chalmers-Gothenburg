%% Soft segment attempt 1
clf

%concentration start values
intitial_concentration=[1; 0; 0];
[t,C]=ode45(@attempt1s,[0 4], intitial_concentration);

plot(t,C(:,1),'-r');
hold on

plot(t,C(:,2),'-b');
hold on

plot(t,C(:,3),'-g');
hold on

xlabel('Time (s)')
ylabel('Concentration (M)')
legend('PET','MHET','EG')
title('Soft segment attempt 1')

%% Soft segment attempt 2
clf

%concentration start values
intitial_concentration=[1; 0; 0; 1];
[t,C]=ode45(@attempt2s,[0 1.5], intitial_concentration);

plot(t,C(:,1),'-r');
hold on

plot(t,C(:,2),'-b');
hold on

plot(t,C(:,3),'-g');
hold on

plot(t,C(:,4),'-m');
hold on


xlabel('Time (s)')
ylabel('Concentration (M)')
legend('PET','MHET','EG','PEG')
title('Soft segment attempt 2')


%% Soft segment attempt 3
clf

%concentration start values
intitial_concentration=[1; 0; 0; 1];
[t,C]=ode15s(@complete_michaelis_menten_ss,[0 10], intitial_concentration);

plot(t,C(:,1),'-r');
hold on

plot(t,C(:,2),'-b');
hold on

plot(t,C(:,3),'-g');
hold on

plot(t,C(:,4),'-m');
hold on

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 10 0 2]);
legend('PET','MHET','EG','PEG')
title('Soft segment attempt 3')

