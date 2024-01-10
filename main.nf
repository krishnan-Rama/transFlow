#!/usr/bin/env nextflow

// Enable DSL2
nextflow.enable.dsl = 2

// Import modules with different names
include {FastQC} from "./modules/fastqc.nf"
include {Fastp} from "./modules/fastp.nf"

// Define channels
Channel.fromFilePairs("${params.reads}", flat: true)
       .set { inputFastq }

// Define workflow
workflow {
    
// Main workflow logic
    main:
    FastQC(inputFastq)
    Fastp(inputFastq)
}
