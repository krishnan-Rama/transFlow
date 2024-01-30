#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Import modules
include { FastQC } from './modules/fastqc.nf'
include { Fastp } from './modules/fastp.nf'
include { Kraken2 } from './modules/kraken.nf'
include { curlKrakenDB } from './modules/curlkraken.nf'

// Define channels
Channel.fromFilePairs("${params.reads}", flat: true)
       .set { inputFastq }

// Define workflow
workflow {
  
  FastQC(inputFastq)
  Fastp(inputFastq)
  curlKrakenDB()  
  Kraken2(Fastp.out.trimmedReads, params.krakenDb)

}

