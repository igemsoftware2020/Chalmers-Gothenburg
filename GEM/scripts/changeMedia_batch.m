function [model,pos] = changeMedia_batch(model,c_source,flux)
% changeMedia_batch
%
% function that modifies the ecModel and makes it suitable for batch growth
% simulations on different carbon sources. Script designed for iML1515
% metabolic network of E. coli metabolism.
%
% model     An enzyme constrained model
% c_source (string) Rxn name for the main carbon source uptake reaction
% flux     (Optional) A cell array with measured uptake fluxes in mmol/gDwh
%
% model: a constrained ecModel
%
% usage: [model,pos] = changeMedia_batch(model,c_source,flux)
%
% Ivan Domenzain        2019-10-14

% Provide the carbon source input according to the following format: 
% c_source  = 'D-glucose exchange (reversible)'

if nargin < 3   %Limited protein    
    flux = -10;
end
pos = find(strcmp(model.rxnNames,c_source));
%first block any uptake
[rxnIDs,exchange] = getExchangeRxns(model);
%First allow any exchange (uptakes and secretions)
model.ub(exchange) = +1000; %allow any secretion
model.lb(exchange) = 0; %block all uptakes


%Block O2 and glucose production (avoids multiple solutions):
model = setParam(model, 'ub', 'EX_o2_e', 0);
%model.ub(strcmp(model.rxnNames,'D-glucose exchange (reversible)')) = 0;
model = setParam(model, 'ub', 'EX_glc__D_e', 0);
model = setParam(model, 'ub', model.rxns(pos), 0); %block secretion of C source


%Fix values as UBs:
model.lb(pos)          = flux;
model.lb(find(model.c)) = -1000;
%Allow uptake of essential components
model = setParam(model, 'lb', 'EX_o2_e', -1000); % 'o2 exchange';
%Ions
model = setParam(model, 'lb', 'EX_na1_e', -1000); % 'sodium exchange';
model = setParam(model, 'lb', 'EX_k_e', -1000); % potassium exchange';
model = setParam(model, 'lb', 'EX_zn2_e', -1000); % zinc exchange';
model = setParam(model, 'lb', 'EX_cu_e', -1000); % Cu+ exchange';
model = setParam(model, 'lb', 'EX_cu2_e', -1000); % Cu2+ exchange';
model = setParam(model, 'lb', 'EX_ni2_e', -1000); % Ni2+ exchange';
model = setParam(model, 'lb', 'EX_mn2_e', -1000); % Mn2+ exchange';
model = setParam(model, 'lb', 'EX_mg2_e', -1000); % Mg exchange';
model = setParam(model, 'lb', 'EX_cobalt2_e', -1000); % cobalt exchange';
model = setParam(model, 'lb', 'EX_ca2_e', -1000); % calcium exchange';
model = setParam(model, 'lb', 'EX_mobd_e', -1000); % Molybdate exchange';
model = setParam(model, 'lb', 'EX_fe2_e', -1000); % Fe2+ exchange';
model = setParam(model, 'lb', 'EX_fe3_e', -1000); % Fe3+ exchange';
%Others
model = setParam(model, 'lb', 'EX_pi_e', -1000); % phosphate exchange';
model = setParam(model, 'lb', 'EX_so4_e', -1000); % sulphate exchange';
model = setParam(model, 'lb', 'EX_so3_e', -1000); % sulphite exchange';
model = setParam(model, 'lb', 'EX_so2_e', -1000); % Sulfur dioxide
model = setParam(model, 'lb', 'EX_h2o_e', -1000); % Water exchange
model = setParam(model, 'lb', 'EX_h_e', -1000); % H+ exchange
%Nitrogen source
model = setParam(model, 'lb', 'EX_nh4_e', -1000); % ammonia exchange';
%Inorganic compounds
model = setParam(model, 'lb', 'EX_cl_e', -1000); % chloride exchange';
%Vitamins
model = setParam(model, 'lb', 'EX_thm_e', -1000); % thiamine exchange';
model = setParam(model, 'lb', 'EX_btn_e', -1000); % Biotin exchange';
model = setParam(model, 'lb', 'EX_thym_e', -1000); % Thymine exchange
end