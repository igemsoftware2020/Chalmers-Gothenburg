function y=complete_michaelis_menten_ss_blackbox(z,c);

global k 


%value for enzyme total concentration
enzyme_concentration=0.2; %random value 

%vmax oxidorreductase (degradation of ethylene glycol)
vmaxOxidorreductase = 5.7;

%km values for enzymes
kmPet=4.6;
%kmPet = k;

kmMhet=3.9;
%kmMhet = k;

kmPegdh=2.0; %chose an average value within a range, see excel file
%kmPegdh = k;

kmOxidorreductase = 0.007; %degradation of ethylene glycol
%kmOxidorreductase = k;

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatPet=5.9;
%kcatPet = 12.4; %according to parameter oprimization
%kcatPet = k;

kcatMhet=26.8; %same for parameter opt
%kcatMhet = k;

kcatPegdh=10; %check for correct value, this one is random
%kcatPegdh = 12; %according to parameter optimization
%kcatPegdh = k;

kcatOxidorreductase = ((kmOxidorreductase + c(3))/(enzyme_concentration*c(3)))*vmaxOxidorreductase; %calculated from km and vmax (for cell metabolism)
%kcatOxidorreductase = k;

y=[(-kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1)) %PET consumption
    (kcatPet.*c(1).*enzyme_concentration)./(kmPet+c(1))- (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2)) %MHET 
    (kcatMhet.*c(2).*enzyme_concentration)./(kmMhet+c(2))+ (kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4)) - (kcatOxidorreductase.*c(3).*enzyme_concentration)./(kmOxidorreductase+c(3)) %EG 
   -(kcatPegdh.*c(4).*enzyme_concentration)./(kmPegdh+c(4)) %PEG consumption
   ];