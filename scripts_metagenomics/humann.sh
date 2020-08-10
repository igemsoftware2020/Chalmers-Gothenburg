#!/usr/bin/env bash

#SBATCH -A C3SE2020-1-8
#SBATCH -p hebbe
#SBATCH -n 20 -t 1-12:00:00

# This scripts take in 2 inputs from script_main.#!/bin/sh
# $1 is file_ID (e.g. SRR32)

module load Anaconda3
echo "Activating conda environment"
source activate /cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/main_env

#unzipping files
FILE="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_merged_filteredfastq/merged_${1}.fastq.gz"
if [ -f "$FILE" ]; then
    echo "unzipping file"
    gunzip $FILE
else
    echo "File already unzipped."
fi

input_humann="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_merged_filteredfastq/merged_${1}.fastq"
output_humann_dir="/cephyr/NOBACKUP/groups/snic2020-8-84/temp_results/"

humann2_log="/cephyr/NOBACKUP/groups/snic2020-8-84/logs/${1}_log_humann2.html"

chocophlan="/cephyr/NOBACKUP/groups/snic2020-8-84/humann2_databases/chocophlan"

echo $input_humann
echo "Running humann2"
# $ humann2 --input examples/demo.fastq --output $OUTPUT_DIR
humann2 --input $input_humann --output $output_humann_dir \
--nucleotide-database $chocophlan \
--bowtie2 "/cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/main_env/bin/" \
--metaphlan-options "--index v20_m200 --bowtie2db /cephyr/NOBACKUP/groups/snic2020-8-84/metaphlan_db/mpa_v20_m200 --bowtie2_exe /cephyr/NOBACKUP/groups/snic2020-8-84/bowtie/bowtie2-2.4.1-linux-x86_64/bowtie2/" \
--threads 20
