#!/usr/bin/env bash

#SBATCH -A C3SE2020-1-8
#SBATCH -p hebbe
#SBATCH -n 6 -t 0-8:30:00

module load Anaconda3
echo "Activating conda environment"
source activate /cephyr/NOBACKUP/groups/snic2020-8-84/conda/envs/main_env

echo "Running sample ${1}"
input_fastq1="/cephyr/NOBACKUP/groups/snic2020-8-84/fastqfiles/${1}_1.fastq"
input_fastq2="/cephyr/NOBACKUP/groups/snic2020-8-84/fastqfiles/${1}_2.fastq"

output_fastq1="$TMPDIR/${1}_filtered_1.fastq"
output_fastq2="$TMPDIR/${1}_filtered_2.fastq"

fastp_log="/cephyr/NOBACKUP/groups/snic2020-8-84/logs/${1}_log.html"

echo "Copying original .fastq files to TMPDIR"
cp $input_fastq1 $TMPDIR
cp $input_fastq2 $TMPDIR

echo "Running fastp"
fastp -i $TMPDIR/${1}_1.fastq -I $TMPDIR/${1}_2.fastq -o $output_fastq1 -O $output_fastq2 -h $fastp_log --thread 6

echo "Zipping original .fastq files"
gzip $input_fastq1
gzip $input_fastq2

echo "Copying filtered fastq files from TMPDIR"
# Copy back filtered fastq from tmpdir
cp $output_fastq1 /cephyr/NOBACKUP/groups/snic2020-8-84/filteredfastq/
cp $output_fastq2 /cephyr/NOBACKUP/groups/snic2020-8-84/filteredfastq/



# ERR1995158_filtered_1.fastq.gz
