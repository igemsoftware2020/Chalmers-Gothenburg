%% Hard segment attempt 1
clf

%concentration start values
initial_concentration=[1; 0; 0; 0; 0; 0];
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

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 20 0 2]);
legend('Polyurethane','diphenylmethane','(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol','biphenyl-2,3-diol','2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate','2-oxopent-4-enoate+benzoate')
title('Hard segment ode45s')


%% Hard segment attempt 2
%clf

%concentration start values
initial_concentration=[1; 0; 0; 0; 0; 0];
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

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 20 0 2]);
legend('Polyurethane','diphenylmethane','(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol','biphenyl-2,3-diol','2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate','2-oxopent-4-enoate+benzoate')
title('Hard segment ode15s')
