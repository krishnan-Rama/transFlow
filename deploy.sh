#!/bin/bash

# Make a backup of the original run_nextflow.sh script
cp run_nextflow.sh run_nextflow.sh.bak
cp nextflow.config nextflow.config.bak

# Ask for the HPC queue name
read -p "Please enter the preferred HPC partition name to deploy the nf-transFlow pipeline: " hpc_queue

# Ask for the SPECIES_IDENTIFIER
read -p "Please enter the species identifier name (e.g., Hsap_02052 for human data): " species_identifier

# Replace <HPC queue> with the user provided queue name in the run_nextflow.sh and nextflow.config
sed -i "s/<HPC queue>/$hpc_queue/g" run_nextflow.sh
sed -i "s/<HPC queue>/$hpc_queue/g" nextflow.config

# Replace <SPECIES_IDENTIFIER> with the user provided species identifier in the nextflow.config
sed -i "s/<SPECIES_IDENTIFIER>/$species_identifier/g" nextflow.config

# Submit the job
sbatch run_nextflow.sh

