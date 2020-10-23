%%Degradation of the soft segment 


pet0 = 1; %mM initial concentration of PET
peg0 = 1; %mM initial concentration of PEG
mhet0 = 0; %mM initial concentration of MHET
eg0 = 0; %mM initial concentration of EG


initial_concentrations=[pet0; mhet0; eg0; peg0];
[t,C]=ode45(@complete_michaelis_menten_ss_blackbox,[0 10], initial_concentrations);

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
legend('Polyethylene terephthalate','Monoethylene terephtalate','Ethylene glycol','Polyethylene glycol')
%axis([0 20 -1 10]);
%title('Degradation of the soft segment with parameters from ')
%title('Degradation of the soft segment with flux of EG diverted to the cellular metabolism')


%% Sensitivity analysis of the soft segment 

global k
%concentration start values
pet0 = 5; %mM initial concentration of PET
peg0 = 1; %mM initial concentration of PEG       
mhet0 = 0; %mM initial concentration of MHET
eg0 = 0; %mM initial concentration of EG



length_sens = 100;

k_range = logspace(-3,2,length_sens);
%k_range = linspace(0.01,100,length_sens);

conc_end = 1:length_sens;

for i = 1:length_sens
    
    global k
    k = k_range(i);
    initial_concentrations=[pet0; mhet0; eg0; peg0];
    [t,C]=ode45(@complete_michaelis_menten_ss_blackbox,[0 10], initial_concentrations);
    
    conc_end(i) = C(end,3);
    
    
end

figure(1)
plot(log10(k_range),conc_end/(pet0+peg0)); %lägg till så det blir yield

A = conc_end/(pet0+peg0);

xlabel('k range')
ylabel('Yield (conc end/pU0)')

%axis([-2 110 -0.1 1.6]);
%title('kmBphA1')
hold off