// concatenate.nf

process ConcatenateReads {

    tag "Concatenating Reads"
    publishDir "${params.outputDir}/concatenated_reads", mode: 'copy'

    input:
    tuple val(sample_id), path(rcorrectRead1), path(rcorrectRead2)

    output:
    tuple path("all_reads_1.fq.gz"), path("all_reads_2.fq.gz"), emit: concatenatedReads

    script:
    """
    cat ${rcorrectRead1.join(" ")} > all_reads_1.fq.gz
    cat ${rcorrectRead2.join(" ")} > all_reads_2.fq.gz
    """
}

