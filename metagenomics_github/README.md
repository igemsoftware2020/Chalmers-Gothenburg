Metagenomics

Installation:
In order to perform the preprocessing of fastq files, it can be good to use the following:

* A terminal (for Windows users - check out: https://ubuntu.com/)
* A computer cluster to perform big jobs - we used C3SE cluster (https://www.c3se.chalmers.se/)
* A Conda environment - an open-source package management system (https://docs.conda.io/projects/conda/en/latest/index.html)


In order to perform the metagenomic analysis, you will need (if you do not have it already) to install the following:

* R and RStudio.


Preprocessing:
Fastq files were filtered using fastp (https://github.com/OpenGene/fastp).
The bioinformatics pipeline to process the raw data was run on the cluster facilities provided by C3SE. The exact environment used to run the pipeline can be found in the folder 'Conda'.
The pipeline uses [HUMAnN2.0](https://github.com/biobakery/humann) to perform the functional profiling of the microbial communities from metagenomic sequencing data.


Analysis of pathway abundance:
The main script  is: "main_metagenomics_analysis.rmd".
This script is used to load the pathway abundance matrix which is then pivoted. This data is then normalized.

The meta data (.tsv) is loaded and processed using five separate scripts: "creating_meta1.rmd", "creating_meta2.rmd", "creating_meta3.rmd", "creating_meta4.rmd" and "creating_meta5.rmd". In these scripts, columns of interest are extracted (e.g sample id). An extra column with the name of the study where the data was retrieved from was also added here. Each of these scripts give an output file that are then merged in the main script: "main_metagenomics_analysis.rmd", which provides the final meta-file.

In the main script, the pathway abundance matrix is merged with the meta data. These are then prepared for further analysis. The merged file is used for a principal component analysis, and a plot of principal components PC1 and PC2. Furthermore, three pathways associated with plastic degradation are extracted and microbial abundance vs environment are visualized in violin plots for each extracted pathway.

In order to analyze the gene families we wrote the 'genefamilies_analysis' script. This script uses the data in the 'data' folder, concretely the meta.csv and the pmdb.xlsx file, as well as the results produced by the previous analysis, to find out which genes are present in the analyzed sample.
