%% Hard segment attempt 1
clf

%concentration start values
pet0 = 1; %initial concentration of polyurethane
mhet0 = 0; %initial concentration of diphenylmethane
cyclohexadiol0 = 0; %initial concentration of (2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol
biphenyl0 = 0; %initial concentration of biphenyl-2,3-diol
dienoate0 = 0; %initial concentration of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
enoate0 = 0; %initial concentration of 2-oxopent-4-enoate+benzoate
benzoate0 = 0; %initial concentration of benzoate



initial_concentration=[pet0; mhet0; cyclohexadiol0; biphenyl0; dienoate0; enoate0; benzoate0];
[t,C1]=ode45(@complete_michaelis_menten_hs,[0 20], initial_concentration);

figure(1)
plot(t,C1(:,1),'-r');
hold on

plot(t,C1(:,2),'-b');
hold on

plot(t,C1(:,3),'-g');
hold on

plot(t,C1(:,4),'-m');
hold on

plot(t,C1(:,5),'-c');
hold on

plot(t,C1(:,6),'-y');
hold on

plot(t,C1(:,7),'-k');
hold on

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 20 0 2]);
legend('Polyurethane','diphenylmethane','(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol','biphenyl-2,3-diol','2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate','2-oxopent-4-enoate+benzoate')
title('Hard segment ode45s')


%% Hard segment attempt 2
%clf

%concentration start values
initial_concentration=[pet0; mhet0; cyclohexadiol0; biphenyl0; dienoate0; enoate0; benzoate0];
[t,C]=ode15s(@complete_michaelis_menten_hs,[0 50], initial_concentration);

figure(2)
plot(t,C(:,1),'-r');
hold on

plot(t,C(:,2),'-b');
hold on

plot(t,C(:,3),'-g');
hold on

plot(t,C(:,4),'-m');
hold on

plot(t,C(:,5),'-c');
hold on

plot(t,C(:,6),'-y');
hold on

plot(t,C(:,7),'-k');
hold on

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 20 0 2]);
legend('Polyurethane','diphenylmethane','(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol','biphenyl-2,3-diol','2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate','2-oxopent-4-enoate','benzoate')
title('Hard segment ode15s')
