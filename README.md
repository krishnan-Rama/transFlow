# nf-transFlow
A Nextflow (DSL2) pipeline for transcriptome quality assessment, pre-processing, _de novo_ assembly, and functional annotation.

## Installation and deployment

1. Install the transFlow pipeline resources into your HPC cluster directory in which you will be performing the assembly:  

```
git clone https://github.com/krishnan-Rama/transFlow.git
```

2. Add the RNA-seq fastq reads ({_1,_2,_R1,_R2}.fastq.gz format) in the `raw_data` directory.  

3. Change module versions for singualrity and nextflow (prerequisites) in `run_nextflow.sh` script accordingly as available in your HPC cluster, if necessary. 
4. Run the pipeline by executing the command `./deploy.sh`  

5. The prompt will ask you to type the preferred/available HPC partion name to submit the job, simply type the name.

### Workflow Diagram
![workflow](https://github.com/krishnan-Rama/transpipeline_containerised/assets/104147619/892ae381-69b3-45e8-a485-ccd50cf1794a)


### Concluding Note

To successfully run this pipeline, ensure the configuration script `nextflow.config` is properly configured for your system (HPC partition and allocated CPU/memory). For more detailed information or to modify specific pipeline behaviours, refer to individual nextflow scripts in the `modules` directory and the configuration file.

### Author Information

Rama Krishnan - krishnanr1@cardiff.ac.uk
