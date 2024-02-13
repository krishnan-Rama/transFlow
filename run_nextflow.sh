#!/bin/bash

#SBATCH --job-name=nf-deploy
#SBATCH --partition=jumbo
#SBATCH --time=01:00:00 
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --error="logs/%J.err"
#SBATCH --output="logs/%J.out"

module load singularity/3.8.7
module load nextflow/23.04.1

nextflow run main.nf -profile cluster -resume

