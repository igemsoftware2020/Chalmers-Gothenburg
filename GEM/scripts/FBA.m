%FBA for the different substrates: glucose, polyurethane and
%polyethylene terephtalate. 
%AUTHOR: Leticia Castillón

clc
cd ..
root = pwd;
cd scripts

biomass = 'BIOMASS_Ec_iML1515_core_75p37M'; %make it easier to call biomass rxn


%FBA in glucose
modelEco_glu = setParam(modelEco, 'lb', 'EX_glc__D_e', -10); %set uptake of glucose to 10 mM/gDW·h
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pu', 0); %block uptake of pu
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pet', 0); %block uptake of pet

modelEco_glu = setParam(modelEco_glu, 'obj', biomass, 1); %maximize flux through biomass

solGlu = solveLP(modelEco_glu, 0); %FBA

%printFluxes(modelEco_glu, solGlu.x) %print exchange fluxes
%printFluxes(modelEco_glu, solGlu.x, false) %print all fluxes

%export flux distribution 
fluxes_glu = extractfield(solGlu, 'x'); %extract the fluxes from the FBA
fluxes_glu = fluxes_glu.'; %transpose
rxns_names = extractfield(modelEco, 'rxns'); %extract rxn id
rxns_names = vertcat(rxns_names{:});
df_rxns_fluxes = table(rxns_names, fluxes_glu); %data frame with rxn id and fluxes

filename = 'flux_distribution_fba_glucose.xlsx'; 
writetable(df_rxns_fluxes,filename,'Sheet',1,'Range','D1') %export to excel flux distribution fba + rxn id

clear fluxes_glu rxns_names df_rxns_fluxes filename 

%FBA in polyurethane
modelEco_pu = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pu', -20); %set uptake of glucose to 20 mM/gDW·h
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pet', 0); 

modelEco_glu = setParam(modelEco_pu, 'obj', biomass, 1); %make sure that the objective function is biomass production

solPU = solveLP(modelEco_pu, 0); %FBA

%printFluxes(modelEco, solPU.x) %print exchange rxns fluxes
%printFluxes(modelEco, solPU.x,false) %print all fluxes

%export flux distribution 
fluxes_pu = extractfield(solPU, 'x'); %extract the fluxes from the FBA
fluxes_pu = fluxes_pu.'; %transpose
rxns_names = extractfield(modelEco, 'rxns'); 
rxns_names = vertcat(rxns_names{:});
df_rxns_pu = table(rxns_names, fluxes_pu);

filename = 'flux_distribution_fba_pu.xlsx';
writetable(df_rxns_pu,filename,'Sheet',1,'Range','D1') %export to excel FBA results

clear fluxes_pu rxns_names df_rxns_pu filename

%FBA in PET
modelEco_pet = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pu', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pet', -6);%set uptake of pet to 6 mM/gDW·h

modelEco_pet = setParam(modelEco_pet, 'obj', biomass, 1); %make sure that the objective function is biomass production

solPET = solveLP(modelEco_pet, 0); %FBA

%printFluxes(modelEco, solPET.x) %print exchange rxns fluxes
%printFluxes(modelEco, solPET.x,false) %print all fluxes

%export flux distribution 
fluxes_pet = extractfield(solPET, 'x'); %extract the fluxes from the FBA
fluxes_pet = fluxes_pet.'; %transpose
rxns_names = extractfield(modelEco, 'rxns'); 
rxns_names = vertcat(rxns_names{:});
df_rxns_pet = table(rxns_names, fluxes_pet);

filename = 'flux_distribution_fba_pet.xlsx';
writetable(df_rxns_pet,filename,'Sheet',1,'Range','D1') %export to excel FBA results

