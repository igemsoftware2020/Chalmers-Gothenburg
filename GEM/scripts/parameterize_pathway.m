%parameterize_pathway

%clone ECM_yeast repository in the current directory
system('git clone --depth 1 https://github.com/SysBioChalmers/ECM_yeast.git');
system('git clone --depth 1 https://github.com/SysBioChalmers/GECKO.git');
%Get pathway data
path_data = getPathwayData('pathway_description.txt');
%parameterize pathway
cd ECM_yeast/code/parameterize_model
system('git checkout fix/model_curation');
%Get Kcats (forward and backward) for each reaction based on EC#
[Ks, Kp] = getKineticData(path_data,'escherichia coli','catalytic rate constant');
[Ks, Kp] = getKineticData(path_data,'escherichia coli','Michaelis constant');

