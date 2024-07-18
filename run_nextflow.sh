#!/bin/bash

#SBATCH --job-name=nf-deploy
#SBATCH --partition=epyc
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --error="logs/%J.err"
#SBATCH --output="logs/%J.out"

# Load required modules
module load singularity/3.8.7
module load nextflow/23.04.1

# Create task_reports directory if it doesn't exist
mkdir -p task_reports

# Run Nextflow pipeline with additional reporting options, saving reports in the task_reports directory
nextflow run main.nf -profile cluster -resume \
  -with-report task_reports/report_${SLURM_JOB_ID}.html \
  -with-dag task_reports/flowchart_${SLURM_JOB_ID}.png \
  -with-trace task_reports/trace_${SLURM_JOB_ID}.txt \
  -with-timeline task_reports/timeline_${SLURM_JOB_ID}.html

