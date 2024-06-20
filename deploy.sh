#!/bin/bash

# Ask for the HPC queue name
read -p "Please enter the preferred HPC partition name to deploy the nf-transFlow pipeline: " hpc_queue

# Make a backup of the original run_nextflow.sh script
cp run_nextflow.sh run_nextflow.sh.bak
cp nextflow.config nextflow.config.bak

# Replace <HPC queue> with the user provided queue name in the run_nextflow.sh
sed -i "s/<HPC queue>/$hpc_queue/g" run_nextflow.sh
sed -i "s/<HPC queue>/$hpc_queue/g" nextflow.config

# Submit the job
sbatch run_nextflow.sh

# Optionally, restore the original script (uncomment the next line to enable)
#mv run_nextflow.sh.bak run_nextflow.sh

