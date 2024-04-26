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
    def read1_files = rcorrectRead1.collect { it.toString() }.join(" ")
    def read2_files = rcorrectRead2.collect { it.toString() }.join(" ")    
    """
}

