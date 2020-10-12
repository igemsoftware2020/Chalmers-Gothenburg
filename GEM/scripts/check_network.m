clear
clc
cd ..
root = pwd;
cd scripts
% Check that RAVEN is installed & that you have a compatible solver (i.e.
% Gurobi)
%checkInstallation
% IMPORT TEMPLATE 
%load E.coli iML1515 model using CbMode (iML1515 has been written for
%COBRA)
%source http://bigg.ucsd.edu/models/iML1515
modelEco_EG = importModel('../Data/templateModel/eg_growth.xml'); 

exportToExcelFormat(modelEco_EG, [root '/scrap/modelEco_EG.xlsx']);
