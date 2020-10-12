% E. COLI iML1515 GENOME SCALE MODEL USING RAVEN TOOLBOX TO ADD PET AND ELASTANE DEGRADING REACTIONS
% AUTHORS: Ellen Arnholm, Niklas Bengtsson & Leticia Castillón

clear
clc
cd ..
root = pwd;
cd scripts
% Check that RAVEN is installed & that you have a compatible solver (i.e.
% Gurobi)
%checkInstallation
% IMPORT TEMPLATE 
%load E.coli iML1515 model using CbModel (iML1515 has been written for
%COBRA)
%source http://bigg.ucsd.edu/models/iML1515
modelEco = importModel('../Data/templateModel/iML1515.xml'); %RAVEN model
modelcobra = readCbModel('../Data/templateModel/iML1515.xml'); %cobra model
%standardize met ids and correct some metNames
modelEco = correctMets_iml1515(modelEco);
%create an excel sheet for the model. Since we do not really need this for
%the addition of reactions or analysis, create a scrap folder to keep these
%kind of documents
mkdir([root '/scrap'])


% ADD REACTIONS & METABOLITES
% We want to add the reactions that we are including in our lab strain.
% This means we are going to include 9 genes & enzymes in our model. 
%Add PET metabolites (obs we are ignoring terephtalate for now)
metsToAdd.mets = {'pet', 'mhet', 'eg', 'pu', 'nadh', 'nad'};
metsToAdd.metNames = {'polyethylene terephtalate', '4-[(2-hydroxyethoxy)-carbonyl]benzoate', 'ethylene glycol', 'polyurethane', 'NADH','NAD+'};
metsToAdd.compartments = {'e','e','e', 'e', 'e', 'e'};
modelEco = addMets(modelEco, metsToAdd);
%Add exchange reaction for ethylene glycol
clear metsToAdd;
%Add rxns for degradation of PET
rxnsToAdd.rxns      = {'RXN-17825', 'RXN-17826', 'GLYCOALDREDUCT', 'ALD-CPLX','pueA-0001', 'hydrolysis', 'add-0001', 'RO5263', 'R05239', 'R033462', 'R02606','tr_eg', 'tr_2-oxopent-4-enoate'};
rxnsToAdd.equations = {'polyethylene terephtalate[e] + H2O[e] => 4-[(2-hydroxyethoxy)-carbonyl]benzoate[e]',...
'4-[(2-hydroxyethoxy)-carbonyl]benzoate[e] + H2O[e] => terephtalate[e] + ethylene glycol[e]',...
'ethylene glycol[c] + NAD+[c] <=> Glycolaldehyde[c] + NADH[c] + H+[c]',...
'Glycolaldehyde[c] + NADH[c] + H2O[c] => Glycolate C2H3O3[c] + NAD+[c] + 2 H+[c]',...
'polyurethane[e] + H2O[e] => ethylene glycol[e] + Ammonium[e] + polymethylene polyphenyl isocyanate[e]',...
'polymethylene polyphenyl isocyanate[e] + H2O[e] => 4,4-Methylenedianiline[e] + CO2[e]',...
'4,4-Methylenedianiline[e] => biphenyl[e] + Ammonium[e]',...
'biphenyl[e] + NADH[e] + H+[e] + O2[e] => cis-3-phenylcyclohexa-3,5-diene-1,2-diol[e] + NAD+[e]',...
'cis-3-phenylcyclohexa-3,5-diene-1,2-diol[e] + NAD+[e] => biphenyl-2,3-diol[e] + NADH[e] + H+[e]',...
'biphenyl-2,3-diol[e] + O2[e] => 2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate[e]',...
'2-hydroxy-6-oxo-6-phenylhexa-2,4-dienoate[e] + H2O[e] => benzoate[e] + 2-Oxopent-4-enoate[e]',...
'ethylene glycol[e] => ethylene glycol[c]',...
'2-Oxopent-4-enoate[e] => 2-Oxopent-4-enoate[c]'};
rxnsToAdd.rxnNames  = {'polyethylene terephtalate hydrolase','mono(ethyleneterephtalate) hydrolase', 'L-1,2-propanediol oxidoreductase', 'aldehyde dehydrogenase A',...
    'polyurethanase A', 'spontaneous hydrolyzation', 'putative adenosine deaminase', 'biphenyl-2,3-dioxygenase', 'cis-2,3-dihydrobiphenyl-2,3-diol dehydrogenase',...
    'biphenyl-2,3-diol 1,2-dioxygenase', '6-dioxo-6-phenylhexa-3-enoate hydrolase', 'ethylene glycol transport', '2-oxopent-4-enoate transport'};
rxnsToAdd.lb = [0,0,-1000,0,0,0,0,0,0,0,0,-1000,0];
rxnsToAdd.ub = [1000,1000,1000,1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000,1000];
rxnsToAdd.eccodes  = {'3.1.1.101','3.1.1.102','1.1.1.77','1.2.1.21', '3.1.1.3', '', '3.5.4.4.', '1.14.12.18', '1.3.1.56', '1.13.11.39', '3.7.1.8','',''};
rxnsToAdd.grRules  = {'ISF6_4831','ISF6_0224','b2799','b1241', 'pueA', '', 'add', 'DSC_08750 and DSC_08755 and DSC_09320', 'DSC_09350', 'DSC_09355', 'DSC_09385','',''};
rxnsToAdd.rxnNotes = {'PET degradation reaction added by manual curation',...
    'MET degradation reaction added by manual curation',...
'Ethylene glycol metabolism reaction added by manual curation',...
'Ethylene glycol metabolism reaction added by manual curation',...
'Putative PU degradation reaction added by manual curation',...
'Spontaneous hydrolysis',...
'Putative deamination by residual activity of native adenine deaminase',...
'First reaction of Bph cluster',...
'Second reaction of Bph cluster',...
'Third reaction of Bph cluster',...
'Fourth reaction of Bph cluster',...
'Transport reaction',...
'Transport reaction'};
modelEco = addRxns(modelEco, rxnsToAdd, 3, '', true, true);

%add sink reactions for the metabolites that accumulate
index_t = find(strcmp(modelEco.metNames, 'terephtalate')); 
index_b = find(strcmp(modelEco.metNames, 'benzoate'));

t = (modelEco.mets(index_t)); %terephtalate
b = (modelEco.mets(index_b)); %benzoate

metabolites = [t,b];

modelEco = addExchangeRxns(modelEco, 'out', metabolites);

%add exchange rxns for polyurethane (pu) and PET and NAD/NADH so that they
%can be taken from the media
modelEco = addExchangeRxns(modelEco, 'both', {'pu', 'pet', 'nad', 'nadh'});

clear rxnsToAdd index_t index_b terephtalate benzoate metabolites t b;

exportToExcelFormat(modelEco, [root '/scrap/modelEco.xlsx']);
% Store original model in scrap folder. 
save([root '/scrap/importModels.mat'],'modelEco')

%% Check functionality 
%checkRxns = find(solution); 
%balanceStructure = getElementalBalance(modelEco, modelEco.rxns(checkRxns), true, true)

%index_exchange = find(contains(modelEco.rxns,'EX'));
%consume_rxn_list = modelEco.rxns(index_exchange);
%zero = zeros([length(consume_rxn_list),1]); 
%modelEco=setParam(modelEco,'eq',consume_rxn_list,zero);
%[solution,metabolite] = consumeSomething(modelEco);

%checkRxns = find(solution);
%balanceStructure = getElementalBalance(modelEco, modelEco.rxns(checkRxns), true, true) 
%everything looks fine

%getExchangeRxns: get all the exchange reactions from a model and loop
%through them opening all exchange.

%random sampling setting biomass to optimal value 
%setParam(modelEco, 'lb', biomass, 0.876997214);
%setParam(modelEco, 'ub', biomass, 0.876997214);

%solutions_opt_Glu = randomSampling(modelEco); does not change the outcome

rxns_names_fluxes = extractfield(modelEco, 'rxns'); 
rxns_names_fluxes = vertcat(rxns_names_fluxes{:});

df_random_glu = table(rxns_names_fluxes, solutionsGlu); 

filename = 'rxns_random_glu.xlsx';
writetable(df_random_glu,filename,'Sheet',1,'Range','D1'); %export to excel

clear filename df_random rxns_names_fluxes


%%
%%Growth in anaerobic conditions
%modelEco = setParam(modelEco, 'lb', 'EX_o2_e', 0); %set lower boundary for oxygen to 0 

%sol = solveLP(modelEco, 0); %see documentation to decide second variable
%index_biomass = find(strcmp(modelEco.rxns, 'BIOMASS_Ec_iML1515_core_75p37M'));
%printFluxes(modelEco, sol.x) %print exchange rxns fluxes
%printFluxes(modelEco, sol.x,false) %to see the biomass flux
%The problem is unfeasible in anaerobic conditions

%modelEco = setParam(modelEco, 'lb', 'EX_o2_e', -1000);

%% Easy way to find biomass rxn
%index = find(contains(modelEco.rxns,'BIOMASS_Ec_iML1515_core_75p37M'));
%biomass = modelEco.rxns(index);
%%
%optGene optimization
%settings for optGene
clear i index nIter 
threshold = 3; 
%selectedRxnList = {'GLCabcpp'; 'GLCptspp'; 'HEX1'; 'PGI'; 'PFK'; 'FBA'; 'TPI'; 'GAPD'; 'PGK'; 'PGM'; 'ENO'; 'PYK'; 'LDH_D'; 'PFL'; 'ALCD2x'; 'PTAr'; 'ACKr'; 'G6PDH2r'; 'PGL'; 'GND'; 'RPI'; 'RPE'; 'TKT1'; 'TALA'; 'TKT2'; 'FUM'; 'FRD2'; 'SUCOAS'; 'AKGDH'; 'ACONTa'; 'ACONTb'; 'ICDHyr'; 'CS'; 'MDH'; 'MDH2'; 'MDH3'; 'ACALD'};
selectedRxnList = modelEco.rxns;
selectedGeneList = {};
genesByReaction  = regexp(regexprep(modelEco.grRules(ismember(modelEco.rxns, selectedRxnList)), '\or|and|\(|\)', ''), '\ ', 'split');

for i = 1:length(genesByReaction)
    selectedGeneList = union(selectedGeneList, genesByReaction{i});
end

selectedGeneList = selectedGeneList(~cellfun('isempty',selectedGeneList));
%selectedGeneList = selectedGeneList.';

%optGene

previousSolutions = cell(10,1);
contPreviousSolutions = 1; 
nIter = 0; 
while nIter < threshold
    fprintf('...Performing optGene analysis...\n')
    
    [~, ~, ~, optGeneSol] = optGene(modelEco, 'EXC_BOTH_pu', 'EX_glc__D_e', selectedGeneList, 'MaxKOs', 2, 'Generations', 100); %'R02606' production of benzoate
    
    SET_M1 = optGeneSol.geneList; 
    
    if ~isempty(SET_M1)
        previousSolutions(contPreviousSolutions) = SET_M1;
        contPreviousSolutions = contPreviousSolutions + 1; 
        %printing results
        fprintf('optGene found a knockout set of large %d composed by ', length(SET_M1));
        for j = 1:length(SET_M1) 
            if j == 1
                fprintf('%s ', SET_M1{j});
            elseif j == length(SET_M1)
                fprintf('and %s', SET_M1{j});
            else 
                fprintf(', %s ', SET_M1{j}); 
            end
        end
        fprintf('\n'); 
        fprintf('...Performing coupling analysis...\n');
        [type, maxGrowth, maxProd, minProd] = analyzeOptKnock(modelEco, optGeneSol.geneList, 'EX_BOTH_pu', biomass, 1); 
        fprintf('The solution is of type: %s\n', type);
        fprintf('The maximun growth rate after optimizacion is %.2f\n', maxGrowth);
        fprintf('The maximun and minimun production of succinate after optimization is %.2f and %.2f, respectively \n\n', minProd, maxProd);
        
    else
        if nIter == 1
            fprintf('optGene was not able to find an optGene set\n');
        else
            fprintf('optGene was not able to found additional optGene sets\n'); 
        end
        break; 
    end
    nIter = nIter + 1
    
end


%%
%%Check growht in PET
modelEco = setParam(modelEco, 'lb', 'EX_glc__D_e', 0);
modelEco = setParam(modelEco, 'lb', 'EXC_BOTH_pu', 0);
modelEco = setParam(modelEco, 'lb', 'EXC_BOTH_pet', -10); 

%perform FBA
solPET = solveLP(modelEco, 0);
printFluxes(modelEco, solPET.x, false) %print exchange rxns fluxes

%[essentialRxns, essentialRxnsIndexes]=getEssentialRxns(modelEco)%get the
%reactions that need to be non 0 so that we can see flux


%%
%%If biomass cannot be produced
%check biomass rxn: can all precursors be synthesized
index_biomass = find(strcmp(modelEco.rxns, 'BIOMASS_Ec_iML1515_core_75p37M'));

report_biomass = checkRxn(modelEco, modelEco.rxns(index_biomass))
%it only produces biomass if using 'BIOMASS_Ec_iML1515_core_75p37M'

clear index_biomass;

%%
%why does it not grow in PET

rxns = {"RXN-17825"; "RXN-17826"; 'GLYCOALDREDUCT'; 'ALD-CPLX';'pueA-0001'; 'hydrolysis'; 'add-0001'; 'RO5263'; 'R05239'; 'R033462'; 'R02606';'tr_eg'; 'tr_2-oxopent-4-enoate'};

ex_rxns = getExchangeRxns(modelEco); %get all the exchange reactions in the model. 

    %modelEco = setParam(modelEco, 'lb', ex_rxns, -1000); %open each exchange reaction and see if it carries flux
    biomass_obj = setParam(modelEco, 'obj', 2669, 1);
    [model,pos] = changeMedia_batch(biomass_obj,'polyethylene terephtalate exchange (BOTH)');

    for i =1:length(rxns)
    model = setParam(model, 'obj', rxns(i), 1);
    sol = solveLP(model, 0);
    if ~isempty(sol.x)
        fprintf('Able to find a solution for %s \n', rxns{i});
        printFluxes(model,sol.x)
    else
        fprintf('No solution found \n'); 
    end
end

%% 
pet_obj = setParam(modelEco, 'obj', 'EXC_BOTH_pet', -1);
[model,pos] = changeMedia_batch(pet_obj,'polyethylene terephtalate exchange (BOTH)');

solveLP(model)

%find if metabolite is connected 
modelEco.metNames(1878)
find(modelEco.S(1878,:))
%our pet rxn is not connected 
%gapReport(modelEco)
%maximize production of precursors one by one 
%%
[model,pos] = changeMedia_batch(modelEco,'polyethylene terephtalate exchange (BOTH)');
solPET = solveLP(model,1)
printFluxes(modelEco, solPET.x)

%find uptake bound for ammonia in e coli to have a more realistic
%simulation: buscar estudios que han hecho batch growth. 