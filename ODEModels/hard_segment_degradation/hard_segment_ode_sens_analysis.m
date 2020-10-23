%%Degradation of the hard segment

%initial concentrations
pU0 = 1; %initial concentration of polyurethane
diaminophenylmethane0 = 0; %initial concentration of intermediary 
diphenylmethane0 = 0; %initial concentration of diphenylmethane
cyclohexadiol0 = 0; %initial concentration of (2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol
biphenyl0 = 0; %initial concentration of biphenyl-2,3-diol
dienoate0 = 0; %initial concentration of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
enoate0 = 0; %initial concentration of 2-oxopent-4-enoate+benzoate
benzoate0 = 0; %initial concentration of benzoate

%concentration start values
initial_concentration=[pU0; diaminophenylmethane0; diphenylmethane0; cyclohexadiol0; biphenyl0; dienoate0; enoate0; benzoate0];
[t,C]=ode15s(@complete_michaelis_menten_hs,[0 100], initial_concentration);


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

plot(t,C(:,8),'-c');
hold on

xlabel('Time (s)')
ylabel('Concentration (M)')
axis([0 20 0 2]);
legend('Polyurethane','diaminophenylmethane','diphenylmethane','(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol','biphenyl-2,3-diol','2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate','2-oxopent-4-enoate','benzoate')
%title('Hard segment ode15s')


%% Sensitivity analysis of the hard segment 
%clf            
global k
%initial concentrations
pU0 = 5; %initial concentration of polyurethane
diaminophenylmethane0 = 0; %initial concentration of intermediary 
diphenylmethane0 = 0; %initial concentration of diphenylmethane
cyclohexadiol0 = 0; %initial concentration of (2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol
biphenyl0 = 0; %initial concentration of biphenyl-2,3-diol
dienoate0 = 0; %initial concentration of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
enoate0 = 0; %initial concentration of 2-oxopent-4-enoate+benzoate
benzoate0 = 0; %initial concentration of benzoate


length_sens = 100;

k_range = logspace(-3,2,length_sens);

conc_end = 1:length_sens;

for i = 1:length_sens
    
    %global k
    k = k_range(i);
    initial_concentration=[pU0; diaminophenylmethane0; diphenylmethane0; cyclohexadiol0; biphenyl0; dienoate0; enoate0; benzoate0];
    [t,C]=ode15s(@complete_michaelis_menten_hs,[0 100], initial_concentration);
    
    conc_end(i) = C(end,8);
    
    
end

figure(1)
plot(k_range,conc_end/pU0);

A = conc_end/pU0;

xlabel('k range')
ylabel('Yield (conc end/pU0)')
%axis([-2 110 -0.1 1.6]);
%title('kmBphA1')
hold off

