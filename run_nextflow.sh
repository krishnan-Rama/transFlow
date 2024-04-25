#!/bin/bash

#SBATCH --job-name=nf-deploy
#SBATCH --partition=<HPC queue>
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --error="logs/%J.err"
#SBATCH --output="logs/%J.out"

# Load required modules
module load singularity/3.8.7
module load nextflow/23.04.1

# Run Nextflow pipeline
nextflow run main.nf -profile cluster -resume

