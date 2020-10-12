%FVA for the different substrates: glucose, polyurethane and
%polyethylene terephtalate. 
%AUTHOR: Leticia Castillón

clc
cd ..
root = pwd;
cd scripts

initCobraToolbox %function from COBRA toolbox

%convert our modified raven model (modelEco) to cobra to perform pFBA
%modelEco_cobra = ravenCobraWrapper(modelEco); 

biomass = 'BIOMASS_Ec_iML1515_core_75p37M'; %make it easier to call biomass rxn

%FVA in glucose
modelEco_glu = setParam(modelcobra, 'lb', 'EX_glc__D_e', -10); %set uptake of glucose to 10 mM/gDW·h
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pu', 0); %block uptake of pu
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pet', 0); %block uptake of pet

modelEco_glu = setParam(modelEco_glu, 'ub', biomass, 0.877); %set up optimized biomass from FBA
modelEco_glu = setParam(modelEco_glu, 'lb', biomass, 0.877); %set up optimized biomass from FBA

[minFlux_glu maxFlux_glu] = fluxVariability(modelEco_glu);

%FVA in pu
modelEco_pu = setParam(modelEco_cobra, 'lb', 'EX_glc__D_e', 0);
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pu', -20); %set uptake of PU to 20 mM/gDW·h
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pet', 0); 

modelEco_pu = setParam(modelEco_pu, 'lb', biomass, 0.085); %set up optimized biomass from FBA 
modelEco_pu = setParam(modelEco_pu, 'ub', biomass, 0.085); %set up optimized biomass from FBA 

[minFlux_pu maxFlux_pu] = fluxVariability(modelEco_pu);

%FVA in pet
modelEco_pet = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pu', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pet', -6);%set uptake of pet to 6 mM/gDW·h

modelEco_pet = setParam(modelEco_pet, 'ub', biomass, 0.069); %set up optimized biomass from FBA
modelEco_pet = setParam(modelEco_pet, 'lb', biomass, 0.069); %set up optimized biomass from FBA

[minFlux_pet maxFlux_pet] = fluxVariability(modelEco_pet);

