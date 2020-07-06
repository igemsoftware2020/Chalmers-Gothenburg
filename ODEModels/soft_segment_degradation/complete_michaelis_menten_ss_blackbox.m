function y=enzym(z,c);

%value for enzyme total concentration
enzyme_concentration=0.2; %random value 

%vmax oxidorreductase (degradation of ethylene glycol)
vmaxOxidorreductase = 5.7;

%km values for enzymes
kmPet=4.6;
kmMhet=3.9;
kmPegdh=2.0; %chose an average value within a range, see excel file
kmOxidorreductase = 0.007; %degradation of ethylene glycol

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPet=5.9;
kcatMhet=26.8;
kcatPegdh=10; %check for correct value, this one is random
kcatOxidorreductase = ((kmOxidorreductase + c(3))/(enzyme_concentration*c(3)))*vmaxOxidorreductase; %calculated from km and vmax


y=[(-kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1))
    (kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1))- (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2))
    (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2))+ (kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4)) - (kcatOxidorreductase.*c(3).*enzyme_concentration)./(kmOxidorreductase+c(3))
   -(kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4))
   ];