// kraken2.nf

process Kraken2 {

    tag "${sample_id}"
    label 'Kraken2'
    publishDir "${params.outputDir}/kraken", mode: 'copy'

    input:
    tuple val(sample_id), path(trimmedRead1), path(trimmedRead2)
    path params.krakenDb

    output:
    tuple val(sample_id), path("${sample_id}_kraken2_report.txt"), path("${sample_id}_kraken2_output.txt"), emit: krakenOutputs

    script:
    """
    kraken2 \\
        --db ${params.krakenDb} \\
        --paired \\
        --output ${sample_id}_kraken2_output.txt \\
        --report ${sample_id}_kraken2_report.txt \\
        --classified-out ${sample_id}_#.classified.fastq \\
        --unclassified-out ${sample_id}_#.unclassified.fastq \\
        ${trimmedRead1} ${trimmedRead2}
    """
}

