%Random Sampling of the solution space for the different substrates: glucose, polyurethane and
%polyethylene terephtalate. 
%AUTHOR: Leticia Castillón

%random sampling in glucose
modelEco_glu = setParam(modelEco, 'lb', 'EX_glc__D_e', -10); %set uptake of glucose to 10 mM/gDW·h
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pu', 0); %block uptake of pu
modelEco_glu = setParam(modelEco_glu, 'lb', 'EXC_BOTH_pet', 0); %block uptake of pet

%do not specify an objective function for random sampling

solutionsRandomGlu = randomSampling(modelEco_glu,10000);

rxns_names = extractfield(modelEco, 'rxns'); 
rxns_names = vertcat(rxns_names{:});

df_rxns_fluxes = table(rxns_names, solutionsRandomGlu);

filename = 'randomSolutionsGlu.xlsx'; %solutions random sampling + rxn_ids
writetable(df_rxns_fluxes,filename,'Sheet',1,'Range','D1') %export to excel

%random sampling in polyurethane
modelEco_pu = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pu', -20); %set uptake of glucose to 20 mM/gDW·h
modelEco_pu = setParam(modelEco_pu, 'lb', 'EXC_BOTH_pet', 0); 

%do not specify an objective function for random sampling

solutionsRandomPU = randomSampling(modelEco_pu, 10000)
%%
df  _rxns_fluxes = table(rxns_names, solutionsRandomPU);


filename = 'randomSolutionsPu.xlsx'; %solutions random sampling + rxn_ids
writetable(df_rxns_fluxes,filename,'Sheet',1,'Range','D1') %export to excel

%random sampling in pet
modelEco_pet = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pu', 0);
modelEco_pet = setParam(modelEco_pet, 'lb', 'EXC_BOTH_pet', -6);%set uptake of pet to 6 mM/gDW·h

solutionsRandomPET = randomSampling(modelEco_pet, 10000);

rxns_names = extractfield(modelEco, 'rxns'); 
rxns_names = vertcat(rxns_names{:});
df_rxns_pet = table(rxns_names, solutionsRandomPET);

filename = 'randomSolutionsPET.xlsx';
writetable(df_rxns_pet,filename,'Sheet',1,'Range','D1') %export to excel FBA results

%generate a vector of Z scores between the two sets of random flux
%distributions

Z_glu_pu = getFluxZ(solutionsRandomGlu, solutionsRandomPU);
Z_glu_pet = getFluxZ(solutionsRandomGlu, solutionsRandomPET);
