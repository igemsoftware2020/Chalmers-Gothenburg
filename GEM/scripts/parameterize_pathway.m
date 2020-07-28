%parameterize_pathway
current = pwd;
%clone ECM_yeast repository in the current directory
system('git clone --depth 1 https://github.com/SysBioChalmers/ECM_yeast.git');
system('git clone --depth 1 https://github.com/SysBioChalmers/GECKO.git');
%Get pathway data
[path_data,model,KEGGmodel] = getPathwayData('pathway_description.txt');
path_data.model = model;
writetable(KEGGmodel,'ECM_yeast/models/KEGG_model_Scaffold.txt','delimiter','\t');
%parameterize pathway
cd ECM_yeast
ECMpath = pwd;
cd code/parameterize_model
system('git checkout fix/model_curation');
%Get Kcats (forward and backward) for each reaction based on EC#
[Ks, Kp] = getKineticData(path_data,'escherichia coli','catalytic rate constant');
[Ks, Kp] = getKineticData(path_data,'escherichia coli','Michaelis constant');
%Try to run equilibrator from MATLAB, if it doesn't work then run locally
commandStr = ['python ' ECMpath '/code/parameterize_model/getKeq.py'];
status = system(commandStr);
if status~=0
    disp('getKeq.py failed to execute from MATLAB, try to run it separately')
    disp('in a terminal, once this is done, press any key to continue')
    pause
end
movefile([ECMpath '/results/parameters'],'../../../../')


