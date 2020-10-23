%Complete ODE model including spontaneous hydrolysis of polyisocyanate and
%putative deamination (random values). 
function y=complete_michaelis_menten_hs(~,c)

global k
%km values

kmPuea=10; %random value
%kmPuea = k;

%kmBpha1=0.018;
kmBpha1 = 0.00018; %according to parameter search
%kmBpha1 = k;

kmBphb=0.0031; %isomer value
%kmBphb=k;

%kmBphc=0.00046; %same for parameter search
kmBphc = 0.0028;
%kmBphc = k;

kmBphd=0.0046;
%kmBphd = k;

kmOp4 = 0.041;
%kmOp4 = k;

kmDeaminase = 100; %we suppose very high km because the affinity should be low for our substrate
%kmDeaminase = k;

%enzyme total value
enzyme_concentration=0.2; %random value
%enzyme_concentration = k;

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPuea=10; %check for correct value, this one is random
%kcatPuea = k;

%kcatBpha1=1.1; %at 4C, pH optimum 7.2 (there are more values available in excel sheet)
kcatBpha1 = 4.6; %according to parameter opt.
%kcatBpha1 = k;

%kcatBphb=0.38;
kcatBphb = 0.9; %according to parameter opt.
%kcatBphb = k;

kcatBphc=115; %same from parameter opt.
%kcatBphc = k;

%kcatBphd=1300;
kcatBphd = 12; %according to parameter opt.
%kcatBphd = k;

kcatOp4 = 215;
%kcatOp4 = k;

kcatH2O = 10000;
%kcatH2O = k;

kcat_deaminase = 0.5; %we do not know, we are inferring a very low value because in case of working it would be due to residual activity
%kcat_deaminase = k;



y=[(-kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))   %polyurethane degradation or production of diisocyanate
    ((kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))) - ((kcatH2O*c(2)) - (kcat_deaminase*enzyme_concentration*c(2))./(kmDeaminase+c(2)))
    (((kcatH2O*c(2)) + (kcat_deaminase*enzyme_concentration*c(2)./(kmDeaminase+c(2)))))-((kcatBpha1.*enzyme_concentration.*c(3))./(kmBpha1+c(3))) %diphenylmethane consumption
    ((kcatBpha1.*enzyme_concentration.*c(3))./(kmBpha1+c(3)))-((kcatBphb.*enzyme_concentration.*c(4))./(kmBphb+c(4))) %(2R,3S)-3-phenylcyclohexa-3,5-diene-1,2-diol consumption
    ((kcatBphb.*enzyme_concentration.*c(4))./(kmBphb+c(4)))-((kcatBphc.*enzyme_concentration.*c(5))./(kmBphc+c(5))) %consumption of biphenyl-2,3-diol
    ((kcatBphc.*enzyme_concentration.*c(5))./(kmBphc+c(5)))-((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6))) %consumption of 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate
    ((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6)) - ((kcatOp4*enzyme_concentration*c(7))./(kmOp4+c(7)))) %consumption of 2-oxopent-4-enoate+benzoate
    ((kcatBphd.*enzyme_concentration.*c(6))./(kmBphd+c(6))) %accumulation of benzoate 
    ];
end