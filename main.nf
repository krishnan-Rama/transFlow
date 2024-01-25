#!/usr/bin/env nextflow

// Enable DSL2
nextflow.enable.dsl = 2

// Import modules
include { FastQC } from "./modules/fastqc.nf"
include { Fastp } from "./modules/fastp.nf"
include { downloadKrakenDB } from "./modules/kraken_download.nf"

// Define channels
Channel.fromFilePairs("${params.reads}", flat: true)
       .set { inputFastq }

// Define workflow
workflow {

    // Download Kraken database independently
    downloadKrakenDB()

    // Main workflow logic
//    FastQC(inputFastq)
//    Fastp(inputFastq)
}

