#!/bin/bash

module load singularity/3.8.7
module load nextflow/23.04.1

nextflow run main.nf -profile cluster

module unload singularity/3.8.7
module unload nextflow/23.04.1
