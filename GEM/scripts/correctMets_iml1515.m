function newModel = correctMets_iml1515(model)
%correctMets
%
% Standardization of met ids and correction of some conflicting metNames
% for the iML1515 metabolic model.
%
% Usage: model = correctMets(model)
% Last edited: Ivan Domenzain 2020-07-23

newMets  = [];
newModel = model;
disp('Transforming met ids into unique identifiers')
for i=1:length(model.mets)
    newStr = ['m_' sprintf( '%04d',i)];
    newMets = [newMets; {newStr}];
end
newModel.mets = newMets;
%It seems that metNames for water are defined as: "H2O H2O", lets correct
%them
idx = find(strcmpi(newModel.metNames,'H2O H2O'));
if ~isempty(idx)
    for i=idx
        newModel.metNames(i) = {'H2O'};
    end
end
%let's do the same for O2 and CO2
idx = find(strcmpi(newModel.metNames,'O2 O2'));
if ~isempty(idx)
    for i=idx
        newModel.metNames(i) = {'O2'};
    end
end
idx = find(strcmpi(newModel.metNames,'CO2 CO2'));
if ~isempty(idx)
    for i=idx
        newModel.metNames(i) = {'CO2'};
    end
end
end