#!/usr/bin/env bash

#SBATCH -A C3SE2020-1-8
#SBATCH -p hebbe
#SBATCH -n 5 -t 0-0:15:00

module load Anaconda3
echo "Activating conda environment"
source activate /cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/main_env

echo "Running cat"
input_filteredfastq1="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_filteredfastq/${1}_1.fastq.gz"
input_filteredfastq2="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_filteredfastq/${1}_2.fastq.gz"

output_merged_filteredfastq1="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_merged_filteredfastq/${1}_merged_filtered_1.fastq.gz"
output_merged_filteredfastq2="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_merged_filteredfastq/${1}_merged_filtered_2.fastq.gz"

merged_filteredfastp_log="/cephyr/NOBACKUP/groups/snic2020-8-84/logs/${1}_log.html"

fastp -i $input_fastq1 -I $input_fastq2 -o $output_fastq1 -O $output_fastq2 -h $fastp_log --thread 6
