function y=enzym(z,c);

%km values
kmPuea=10; %random value
kmBpha1=0.018;
kmBphb=0.0031; %isomer value
kmBphc=0.00046;
kmBphd=0.0046;
kmOp4 = 0.041;
kmDeaminase = 

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

y=[(-kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))   %polyurethane degradation
    ((kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1)))-((kcatBpha1.*enzyme_concentration.*c(2))./(kmBpha1+c(2))) %diphenylmethane consumption
    ((kcatBpha1.*enzyme_concentration.*c(2))./(kmBpha1+c(2)))-((kcatBphb.*enzyme_concentration.*c(3))./(kmBphb+c(3))) %(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol consumption
    ((kcatBphb.*enzyme_concentration.*c(3))./(kmBphb+c(3)))-((kcatBphc.*enzyme_concentration.*c(4))./(kmBphc+c(4))) %consumption of biphenyl-2,3-diol
    ((kcatBphc.*enzyme_concentration.*c(4))./(kmBphc+c(4)))-((kcatBphd.*enzyme_concentration.*c(5))./(kmBphd+c(5))) %consumption of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
    ((kcatBphd.*enzyme_concentration.*c(5))./(kmBphd+c(5)) - ((kcatOp4*enzyme_concentration*c(6))./(kmOp4+c(6)))) %consumption of 2-oxopent-4-enoate+benzoate
    ((kcatBphd.*enzyme_concentration.*c(5))./(kmBphd+c(5))) %accumulation of benzoate 
    ];


