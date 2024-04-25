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
    cat \$(find -name '*_1.cor.fq.gz') > all_reads_1.fq.gz
    cat \$(find -name '*_2.cor.fq.gz') > all_reads_2.fq.gz    
    """
}

