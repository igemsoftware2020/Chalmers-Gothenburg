%Complete ODE model including spontaneous hydrolysis of polyisocyanate and
%putative deamination (random values). 

function y=enzym(z,c);

%km values
kmPuea=10; %random value
kmBpha1=0.018;
kmBphb=0.0031; %isomer value
kmBphc=0.00046;
kmBphd=0.0046;
kmOp4 = 0.041;
kmDeaminase = 100; %we suppose very high km because the affinity should be low for our substrate

%enzyme total value
enzyme_concentration=0.2; %random value

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPuea=10; %check for correct value, this one is random
kcatBpha1=1.1; %at 4C, pH optimum 7.2 (there are more values available in excel sheet)
kcatBphb=0.38;
kcatBphc=115;
kcatBphd=1300;
kcatOp4 = 215;
kcatH2O = 10000; 
kcat_deaminase = 0.5; %we do not know, we are inferring a very low value because in case of working it would be due to residual activity

y=[(-kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))   %polyurethane degradation or production of diisocyanate
    ((kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))) - ((kcatH2O*c(2)) - (kcat_deaminase*enzyme_concentration*c(2))./(kmDeaminase+c(2)))
    (((kcatH2O*c(2)) + (kcat_deaminase*enzyme_concentration*c(2)./(kmDeaminase+c(2)))))-((kcatBpha1.*enzyme_concentration.*c(3))./(kmBpha1+c(3))) %diphenylmethane consumption
    ((kcatBpha1.*enzyme_concentration.*c(3))./(kmBpha1+c(3)))-((kcatBphb.*enzyme_concentration.*c(4))./(kmBphb+c(4))) %(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol consumption
    ((kcatBphb.*enzyme_concentration.*c(4))./(kmBphb+c(4)))-((kcatBphc.*enzyme_concentration.*c(5))./(kmBphc+c(5))) %consumption of biphenyl-2,3-diol
    ((kcatBphc.*enzyme_concentration.*c(5))./(kmBphc+c(5)))-((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6))) %consumption of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
    ((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6)) - ((kcatOp4*enzyme_concentration*c(7))./(kmOp4+c(7)))) %consumption of 2-oxopent-4-enoate+benzoate
    ((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6))) %accumulation of benzoate 
    ];


