function y=enzym(z,c);

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]
kcatpet=5.9;
kcatmhet=26.8;
kcatpegdh=10; %check for correct value, this one is random

%km values for enzymes
kmpet=4.6;
kmmhet=3.9;
kmpegdh=2.0; %chose an average value within a range, see excel file

%value for enzyme total concentration
enzyme_concentration=0.2; %random value 

y=[(-kcatpet.*c(1).*enzyme_concentration)./(kmpet+c(1))
    (kcatpet.*c(1).*enzyme_concentration)./(kmpet+c(1))- (kcatmhet.*c(2).*enzyme_concentration)./(kmmhet+c(2))
    (kcatmhet.*c(2).*enzyme_concentration)./(kmmhet+c(2))+ (kcatpegdh.*c(4).*enzyme_concentration)./(kmpegdh+c(4))
   -(kcatpegdh.*c(4).*enzyme_concentration)./(kmpegdh+c(4))];