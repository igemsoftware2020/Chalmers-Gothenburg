# Kinetic models 

Here, you can find the scripts to run the *ordinary differential equation models* for degradation of the soft segment and hard segment of elastane and and *sensitivity analysis*.



## Installation
In order to run the ODE model yourself, you will need (if you do not have it already) to install the following: 
* [MATLAB](https://www.mathworks.com/products/matlab.html) (version 2016 or posterior)

and to perform the sensistivity analysis you also need 
* [R](https://cran.r-project.org/mirrors.html) and [RStudio](https://rstudio.com/products/rstudio/download/) 
* [Excel](https://www.microsoft.com/sv-se/microsoft-365/p/excel/cfq7ttc0k7dx?=&ef_id=Cj0KCQjwit_8BRCoARIsAIx3Rj6Kxg_wQ86GA1QUV6ZkWNWgHnHsFAMe0is6rlH1bSDqkH0KkkZ9du0aAjAOEALw_wcB%3aG%3as&OCID=AID2100139_SEM_Cj0KCQjwit_8BRCoARIsAIx3Rj6Kxg_wQ86GA1QUV6ZkWNWgHnHsFAMe0is6rlH1bSDqkH0KkkZ9du0aAjAOEALw_wcB%3aG%3as&lnkd=Google_O365SMB_App&gclid=Cj0KCQjwit_8BRCoARIsAIx3Rj6Kxg_wQ86GA1QUV6ZkWNWgHnHsFAMe0is6rlH1bSDqkH0KkkZ9du0aAjAOEALw_wcB&activetab=pivot%3aoverviewtab)


## Content
The folder 'hard segment degradation' contains MATLAB script to run the degradation pathway and sensitivity analysis for the hard segment. <br/>
The folder 'soft segment degradation' contains MATLAB script to run the degradation pathway and sensitivity analysis for the soft segment. <br/>
'hs_sens_analysis.csv' contains yields and k-values retrived from MATLAB scripts to plot the sensitivity analysis for the hard segment. <br/>
'ss_sens_analysis.csv' contains yields and k-values retrived from MATLAB scripts to plot the sensitivity analysis for the soft segment. <br/>
'sens_analysis_script_hs.Rmd' contains script to plot the sensitivity analysis for the hard segment in R. <br/>
'sens_analysis_script_ss.Rmd' contains script to plot the sensitivity analysis for the soft segment in R. <br/>

* Note: 
To perform sensitivty analysis you set 1 (one) parameter = k at the time, and all other parameters to a fixed value.

## Results
To see our results and discussion, please check our [wiki page!](https://2020.igem.org/Team:Chalmers-Gothenburg)

