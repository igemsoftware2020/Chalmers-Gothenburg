# GEM files 
Here is all the material necessary to perform the GEM analysis. 

## Installation
In order to perform the GEM analysis yourself, you will need (if you do not have it already) to install the following: 
* [MATLAB](https://www.mathworks.com/products/matlab.html) (version 2016 or posterior)
* [R](https://cran.r-project.org/mirrors.html) and [RStudio](https://rstudio.com/products/rstudio/download/)
* The [Raven Toolbox](https://github.com/SysBioChalmers/RAVEN/wiki/Installation#installation)
* The [COBRA Toolbox](https://opencobra.github.io/cobratoolbox/stable/) 
* The solver [Gurobi](https://www.gurobi.com/documentation/9.0/quickstart_mac/software_installation_guid.html)

For the visualization using Escher:
* [Python3](https://www.python.org/downloads/)

## Content
The folder 'Data' contains all the data used for our analysis and to construct the network. 
The folder 'db queries' contains our scripts to query KEGG to obtain information that is later on used for the analysis of the network reconstruction simulation. 
The folder 'escher' contains the data with the results from RAVEN and COBRA that were used to visualize the metabolic map. It also contains the scripts to convert the results to .json format, required upload the data on escher. 
The folder 'parameters' contains the parametrization analysis (for more information go to the [ODE model](https://github.com/igemsoftware2020/Chalmers-Gothenburg/tree/master/ODEModels) section. 
The folder 'scripts' contains the scripts to run the network reconstruction and the different simulations we performed. Inside you can also find the folder 'visualization', which contains the R script used to analyze and visualize our results in a comprehensive manner.   


## Results
To see our results and discussion, please check our [wiki page!](https://2020.igem.org/Team:Chalmers-Gothenburg)
