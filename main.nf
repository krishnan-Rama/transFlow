#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Import modules
include { FastQC } from './modules/fastqc.nf'
include { Fastp } from './modules/fastp.nf'
include { Kraken2 } from './modules/kraken.nf'
include { curlKrakenDB } from './modules/curlkraken.nf'
include { ExtractKrakenReads } from './modules/filter_kraken.nf'
include { rcorrector } from './modules/rcorrector.nf'
include { ConcatenateReads } from './modules/concatanate.nf'
include { Trinity } from './modules/trinityassembly.nf'
include { Evigene } from './modules/evigene.nf'

// Define channels
Channel.fromFilePairs("${params.reads}", flat: true)
       .set { inputFastq }

// Define workflow
workflow {
  
  FastQC(inputFastq)
  Fastp(inputFastq)
  curlKrakenDB()  
  Kraken2(Fastp.out.trimmedReads, params.krakenDb)  
  ExtractKrakenReads(Fastp.out.trimmedReads.combine(Kraken2.out.krakenOutputs, by: 0))
  rcorrector(ExtractKrakenReads.out.filteredReads)
  ConcatenateReads(rcorrector.out.rcorrectReads)
  Trinity(ConcatenateReads.out.concatenatedReads)
  Evigene(Trinity.out.trinityFasta)
  //BUSCO(Evigene.out.annotated_okay_fasta)
}

