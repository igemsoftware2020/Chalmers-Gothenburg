function [path_data, model,KEGGmodel] = getPathwayData(pathFile)
%getPathwayData
%
% Get a file with description of a pathway in a reaction-formulas fashion
% and create a structure with all substrates, products and EC numbers by
% rxn. This structure is needed by the ECM pipeline in order to obtain
% kinetic parameters for the given pathway (Kcats and KMs).
%
%   pathFile  (string) indicating the name of the text (tab-separated) file
%             in which the pathway is defined. The file should be stored in
%             root/GEM/Data
%
%   path_data (structure) with fields substrates, products and ECnumbers,
%             which contain rows for each reaction in the pathway. 
%   model     (structure) with a stoichiometric representation of the pathway 
%             in a RAVEN format.
%   KEGGmodel (table) Table with a KEGG format model for the provided
%              pathway, compatible with the "ECM" and "equilibrator" pipelines
% 
% Usage: path_data = getPathwayData
%
% Last modified: Ivan Domenzain 2020-07-25
%

%Open file with pathway description
pathway_table = readtable(['../Data/' pathFile],'delimiter','\t');
%initialize variables
substrates = cell(height(pathway_table),20);
products   = cell(height(pathway_table),20);
EC_numbers = cell(height(pathway_table),20);
S          = zeros(100,height(pathway_table));
metNames   = [];
mets       = [];
rxns       = [];
rxnNames   = [];
grRules    = [];
metCounts  = 1;
%Explore pathway rxn by rxn
for i=1:height(pathway_table)
    formula  = pathway_table.rxnFormula{i};
    rxns     = [rxns;pathway_table.rxnID(i)];
    rxnNames = [rxnNames;pathway_table.rxnNames(i)];
    grRules  = [grRules; pathway_table.grRules(i)];
    if contains(formula,'<=>')
        delim = '<=>';
    else
        delim = '=>';
    end
    %Split reactants and products
    formula  = strsplit(formula,delim);
    rxnSubs  = formula{1};
    rxnProds = formula{2};
    rxnSubs  = strsplit(rxnSubs,' + ');
    rxnProds = strsplit(rxnProds,' + ');
    %Get all individual substrates for rxn
    k=1;
    for j=1:length(rxnSubs)
        substrate = rxnSubs{j};
        if length(substrate)>2
            substrates{i,k} = substrate;
            index = find(strcmpi(substrate,metNames));
            if isempty(index)
                metNames = [metNames; {substrate}];
                mets = [mets; {['m_' sprintf( '%04d',metCounts)]}];
                index    = metCounts;
                metCounts = metCounts+1;
            end
            k = k+1;
            S(index,i) = -1;
        end
    end
    %Get all individual products for rxn
    k=1;
    for j=1:length(rxnProds)
        product = rxnProds{j};
        if length(product)>3
            products{i,k} = product;
            index = find(strcmpi(product,metNames));
            if isempty(index)
                metNames = [metNames; {product}];
                mets = [mets; {['m_' sprintf( '%04d',metCounts)]}];
                index     = metCounts;
                metCounts = metCounts+1;
            end
            k = k+1;
            S(index,i) = +1;
        end
    end
    %Get ECnumbers
    ECnum = pathway_table.Ecnumbers{i};
    if ~isempty(ECnum)
        ECnum = strsplit(ECnum,' ');
        for j=1:length(ECnum)
            EC_numbers{i,j} = ECnum{j};
        end
    end
end
path_data.substrates = substrates;
path_data.products   = products;
path_data.EC_numbers = EC_numbers;
for i=1:length(metNames)
    met = metNames{i};
    idx = strfind(met,'[');
    if ~isempty(idx)
    	met = met(1:(idx(end)-1));
        metNames{i} = met;
    end
end
model = struct();
S = S(1:length(metNames),:);
model.metNames  = strtrim(metNames);
model.mets      = mets;
model.rxnNames  = strtrim(rxnNames);
model.rxns      = strtrim(rxns);
model.grRules   = strtrim(grRules);
model.S         = S;
keggVariables   = {'ID','Name','ReactionFormula','KEGGIDs'};
KEGGmodel       = table(strtrim(rxns),strtrim(rxnNames),pathway_table.KEGG_formula,pathway_table.KEGG_id,'VariableNames',keggVariables);
end
