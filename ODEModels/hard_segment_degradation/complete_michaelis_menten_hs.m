function y=enzym(z,c);

%km values
kmPuea=10; %random value
kmBpha1=0.018;
kmBphb=0.0031; %isomer value
kmBphc=0.00046;
kmBphd=0.0046;

%enzyme total value
enzyme_concentration=0.2; %random value

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPuea=10; %check for correct value, this one is random
kcatBpha1=1.1; %at 4C, pH optimum 7.2 (there are more values available in excel sheet)
kcatBphb=0.38;
kcatBphc=115;
kcatBphd=1300;

y=[(-kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1))
    ((kcatPuea.*enzyme_concentration.*c(1))./(kmPuea+c(1)))-((kcatBpha1.*enzyme_concentration.*c(2))./(kmBpha1+c(2)))
    ((kcatBpha1.*enzyme_concentration.*c(2))./(kmBpha1+c(2)))-((kcatBphb.*enzyme_concentration.*c(3))./(kmBphb+c(3)))
    ((kcatBphb.*enzyme_concentration.*c(3))./(kmBphb+c(3)))-((kcatBphc.*enzyme_concentration.*c(4))./(kmBphc+c(4)))
    ((kcatBphc.*enzyme_concentration.*c(4))./(kmBphc+c(4)))-((kcatBphd.*enzyme_concentration.*c(5))./(kmBphd+c(5)))
    ((kcatBphd.*enzyme_concentration.*c(5))./(kmBphd+c(5)))
    ];


