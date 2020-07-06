function y=enzym(z,c);

%kcat values for the enzymes: pet, mhet,peg-dh,puea,deaminase [1/s]

kcatpet=5.9;

kcatmhet=26.8;

kcatpegdh=10; %check for correct value, this one is random

% kcatpuea=10; %check for correct value, this one is random

% kcatdeaminase=10; %check for correct value, this one is random


y=[-kcatpet.*c(1)
    kcatpet.*c(1)-kcatmhet.*c(2)
    kcatmhet.*c(2)+kcatpegdh.*c(4)
    -kcatpegdh.*c(4)];


