#!/usr/bin/env bash

#SBATCH -A C3SE2020-1-8
#SBATCH -p hebbe
#SBATCH -n 5 -t 0-0:30:00

module load Anaconda3
echo "Activating conda environment"
source activate /cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/main_env

input_humann="/cephyr/NOBACKUP/groups/snic2020-8-84/merged_filteredfastq/${1}"
output_humann="/cephyr/NOBACKUP/groups/snic2020-8-84/humann_out"

humann2 -input input_humann -output output_humann
