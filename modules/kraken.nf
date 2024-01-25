// kraken2.nf
process Kraken2 {
    
    tag "${sample_id}"
    label 'Kraken2'
    publishDir "${params.outputDir}/kraken2", mode: 'copy'

    input:
    tuple val(sample_id), path(fastq1), path(fastq2)
    path kraken2_db  // Input for the database

    output:
    path "${sample_id}_kraken2_report.txt", emit: kraken2_report

    script:
    """
    kraken2 \
        --db ${kraken2_db} \
        --paired \
        --output ${sample_id}_kraken2_output.txt \
        --report ${sample_id}_kraken2_report.txt \
        ${read1} ${read2}
    """
}

