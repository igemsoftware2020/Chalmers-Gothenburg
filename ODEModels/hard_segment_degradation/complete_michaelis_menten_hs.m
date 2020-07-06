function y=enzym(z,c);

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatpuea=10; %check for correct value, this one is random
kcatbpha1=1.1; %at 4C, pH optimum 7.2 (there are more values available in excel sheet)
kcatbphb=0.38;
kcatbphc=115;
kcatbphd=1300;

%km values
kmpuea=10; %random value
kmbpha1=0.018;
kmbphb=0.0031; %isomer value
kmbphc=0.00046;
kmbphd=0.0046;

%enzyme total value
enzyme_concentration=0.2; %random value

y=[(-kcatpuea.*enzyme_concentration.*c(1))./(kmpuea+c(1))
    ((kcatpuea.*enzyme_concentration.*c(1))./(kmpuea+c(1)))-((kcatbpha1.*enzyme_concentration.*c(2))./(kmbpha1+c(2)))
    ((kcatbpha1.*enzyme_concentration.*c(2))./(kmbpha1+c(2)))-((kcatbphb.*enzyme_concentration.*c(3))./(kmbphb+c(3)))
    ((kcatbphb.*enzyme_concentration.*c(3))./(kmbphb+c(3)))-((kcatbphc.*enzyme_concentration.*c(4))./(kmbphc+c(4)))
    ((kcatbphc.*enzyme_concentration.*c(4))./(kmbphc+c(4)))-((kcatbphd.*enzyme_concentration.*c(5))./(kmbphd+c(5)))
    ((kcatbphd.*enzyme_concentration.*c(5))./(kmbphd+c(5)))
    ];


