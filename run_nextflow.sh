#!/bin/bash

#SBATCH --job-name=nextflow-main
#SBATCH --partition=jumbo
#SBATCH --time=01:00:00 
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

module load singularity/3.8.7
module load nextflow/23.04.1

nextflow run main.nf -profile cluster -resume

