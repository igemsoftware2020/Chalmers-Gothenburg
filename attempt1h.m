function y=enzym(z,c);

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]

kcatpuea=10; %check for correct value, this one is random

kcatbpha1=1.1; %at 4C, pH optimum 7.2 (there are more values available in excel sheet)

kcatbphb=0.38;

kcatbphc=115;

kcatbphd=1300;


y=[-kcatpuea.*c(1)
    kcatpuea.*c(1)-kcatbpha1.*c(2)
    kcatbpha1.*c(2)-kcatbphb.*c(3)
    kcatbphb.*c(3)-kcatbphc.*c(4)
    kcatbphc.*c(4)-kcatbphd.*c(5)
    kcatbphd.*c(5)];


