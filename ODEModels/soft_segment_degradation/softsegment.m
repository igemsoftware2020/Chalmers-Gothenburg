%% Soft segment attempt 1
clf

%concentration start values
ca=[1; 0; 0];
[t,C]=ode45(@complete_michaelis_menten_ss,[0 4], ca);

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

%% Soft segment attempt 2 & complete michaelis menten
clf

%concentration start values
pet0 = 5; %mM initial concentration of PET
peg0 = 1; %mM initial concentration of PEG
mhet0 = 0; %mM initial concentration of MHET
eg0 = 0; %mM initial concentration of EG


initial_concentrations=[pet0; mhet0; eg0; peg0];
[t,C]=ode45(@complete_michaelis_menten_ss,[0 10], initial_concentrations);

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
title('Degradation of the soft segment with flux of EG diverted to the cellular metabolism')

