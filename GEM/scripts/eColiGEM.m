% E. COLI iML1515 GENOME SCALE MODEL USING RAVEN TOOLBOX TO ADD PET AND ELASTANE DEGRADING REACTIONS
% AUTHORS: Ellen Arnholm, Niklas Bengtsson & Leticia Castillón

clear
clc
cd ..
root = pwd;
cd scripts
% Check that RAVEN is installed & that you have a compatible solver (i.e.
% Gurobi)
checkInstallation
% IMPORT TEMPLATE 
%load E.coli iML1515 model using CbMode (iML1515 has been written for
%COBRA)
%source http://bigg.ucsd.edu/models/iML1515
modelEco = importModel('../Data/templateModel/iML1515.xml'); 
%standardize met ids and correct some metNames
modelEco = correctMets_iml1515(modelEco);
%create an excel sheet for the model. Since we do not really need this for
%the addition of reactions or analysis, create a scrap folder to keep these
%kind of documents
mkdir([root '/scrap'])
exportToExcelFormat(modelEco, [root 'scrap/modelEco.xlsx']);
% Store original model in scrap folder. 
save([root '/scrap/importModels.mat'])

% ADD REACTIONS & METABOLITES
% We want to add the reactions that we are including in our lab strain.
% This means we are going to include 9 genes & enzymes in our model. 

%Add PET metabolites (obs we are ignoring terephtalate for now)
metsToAdd.mets = {'pet', 'mhet', 'eg'};
metsToAdd.metNames = {'polyethylene terephtalate', '4-[(2-hydroxyethoxy)-carbonyl]benzoate', 'ethylene glycol'};
metsToAdd.compartments = {'e','e','e'};
metsToAdd.lb = [0,0,0,0];
metsToAdd.ub = [1000,1000,1000,1000];

modelEco = addMets(modelEco, metsToAdd);

%Add exchange reaction for ethylene glycol and water
modelEco = addExchangeRxns(modelEco, 'in', {'eg'});

clear metsToAdd;
%
%Add rxns for degradation of PET
rxnsToAdd.rxns      = {'RXN-17825', 'RXN-17826', 'GLYCOALDREDUCT', 'ALD-CPLX'};
rxnsToAdd.equations = {'ethylene terephtalate(n)[e] + H2O[e] => 4-[(2-hydroxyethoxy)-carbonyl]benzoate[e]',...
'4-[(2-hydroxyethoxy)-carbonyl]benzoate[e] + H2O[e] => terephtalate[e] + ethylene gycol[e]',...
'ethylene glycol[c] + NAD+[c] <=> glycolaldehyde[c] + NADH[c] + H+[c]',...
'glycolaldehyde[c] + NAD+[c] + H2O[c]  => glycolate[c] + NAD+[c] + 2H+[c]'};
rxnsToAdd.rxnNames  = {'polyethylene terephtalate hydrolase ','mono(ethyleneterephtalate) hydrolase', 'L-1,2-propanediol oxidoreductase', 'aldehyde dehydrogenase A'};
rxnsToAdd.lb = [0,0,-1000,0];
rxnsToAdd.ub = [1000,1000,1000,1000];
rxnsToAdd.eccodes  = {'3.1.1.101','3.1.1.102','1.1.1.77','1.2.1.21'};
rxnsToAdd.grRules  = {'ISF6_4831','ISF6_0224','b2799','b1241'};
rxnsToAdd.rxnNotes = {'PET degradation reaction added by manual curation',...
    'MET degradation reaction added by manual curation',...
'Ethylene glycol metabolism reaction added by manual curation',...
'Ethylene glycol metabolism reaction added by manual curation'};

modelEco = addRxns(modelEco, rxnsToAdd, 3, '', true, true);
 
clear rxnsToAdd;

 

