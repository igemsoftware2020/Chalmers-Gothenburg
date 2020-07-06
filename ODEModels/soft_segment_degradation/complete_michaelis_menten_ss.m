function y=enzym(z,c);

%value for enzyme total concentration
enzyme_concentration=0.2; %random value 

%km values for enzymes
kmPet=4.6;
kmMhet=3.9;
kmPegdh=2.0; %chose an average value within a range, see excel file

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPet=5.9;
kcatMhet=26.8;
kcatPegdh=10; %check for correct value, this one is random

y=[(-kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1))
    (kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1))- (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2))
    (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2))+ (kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4)) 
   -(kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4))
   ];