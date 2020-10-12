%pFBA for the different substrates: glucose, polyurethane and
%polyethylene terephtalate. 
%AUTHOR: Leticia Castillón

%note: run script 'eColiGEM.m' first to produce the model with the
%exogenous reactions

%clc
%cd ..
%root = pwd;
%cd scripts

%initCobraToolbox % pFBA is a function from the COBRA toolbox

%convert our modified raven model (modelEco) to cobra to perform pFBA
%modelEco_cobra = ravenCobraWrapper(modelEco); 

%pFBA in glucose
modelEco_glu = setParam(modelEco_cobra, 'lb', 'EX_glc__D_e', -10); %set uptake of glucose to 10 mM/gDW·h
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pu', 0); %block uptake of pu
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pet', 0); %block uptake of pet

modelEco_glu = setParam(modelEco_glu, 'obj', biomass, 1); %maximize flux through biomass

[GeneClassesRxnClasses_glu modelIrrevFM_glu] = pFBA(modelEco_glu, 'geneoption',0, 'tol', 1e-7)

%pFBA in pu
modelEco_pu = setParam(modelEco_cobra, 'lb', 'EX_glc__D_e', 0);
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pu', -20); %set uptake of glucose to 20 mM/gDW·h
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pet', 0); 

modelEco_pu = setParam(modelEco_pu, 'obj', biomass, 1); %make sure that the objective function is biomass production

[GeneClassesRxnClasses_pu modelIrrevFM_pu] = pFBA(modelEco_pu, 'geneoption',0, 'tol', 1e-7)

%pFBA in pet
%FBA in PET
modelEco_pet = setParam(modelEco_cobra, 'lb', 'EX_glc__D_e', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pu', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pet', -6);%set uptake of pet to 6 mM/gDW·h

modelEco_pet = setParam(modelEco_pet, 'obj', biomass, 1); %make sure that the objective function is biomass production

[GeneClassesRxnClasses_pet modelIrrevFM_pet] = pFBA(modelEco_pet, 'geneoption',0, 'tol', 1e-7)


