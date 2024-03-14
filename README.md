# transFlow
A Nextflow (DSL2) pipeline for transcriptome quality assessment, pre-processing, _de novo_ assembly, and annotation.

## Installation

1. Install the transpipeline resources into your HPC cluster directory in which you will be performing the assembly:  

```
git clone https://github.com/krishnan-Rama/transFlow.git
```

2. Add the rawreads in the `data` directory.  

3. In the `nextflow.config` file, modify the HPC partition name and CPU/memory according to your HPC system.

4. Run the pipeline by executing the command `sbatch run_nextflow.sh`.  


### Workflow Diagram
![workflow](https://github.com/krishnan-Rama/transpipeline_containerised/assets/104147619/892ae381-69b3-45e8-a485-ccd50cf1794a)


### Concluding Note

To successfully run this pipeline, ensure the configuration script `nextflow.config` is properly configured for your system (HPC partition and allocated CPU/memory). For more detailed information or to modify specific pipeline behaviours, refer to individual nextflow scripts in the `modules` directory and the configuration file.

### Author Information

Rama Krishnan - krishnanr1@cardiff.ac.uk
