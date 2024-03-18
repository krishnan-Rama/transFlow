// concatenate.nf

process ConcatenateReads {

    tag "Concatenating Reads"
    publishDir "${params.outputDir}/concatenated_reads", mode: 'copy'

    input:
    tuple val(sample_id), path(filteredRead1), path(filteredRead2)

    output:
    tuple path("all_reads_1.fq.gz"), path("all_reads_2.fq.gz"), emit: concatenatedReads

    script:
    """
    cat ${filteredRead1.join(' ')} > all_reads_1.fq.gz
    cat ${filteredRead2.join(' ')} > all_reads_2.fq.gz
    """
}

