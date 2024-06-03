//concatanate.nf

process ConcatenateReads {

    tag "Concatenating Reads"
    publishDir "${params.outputDir}/concatenated_reads", mode: 'copy'

    input:
    tuple val(sample_id), path(rcorrectRead1), path(rcorrectRead2)

    output:
    path("all_reads_1.fq.gz"), emit: concatenatedRead1
    path("all_reads_2.fq.gz"), emit: concatenatedRead2

    script:
    """
    echo "Concatenating the following files for read 1 in ${baseDir}/output/rcorrector:"
    ls -1 ${baseDir}/output/rcorrector/*_1.cor.fq.gz
    echo "Concatenating the following files for read 2 in ${baseDir}/output/rcorrector:"
    ls -1 ${baseDir}/output/rcorrector/*_2.cor.fq.gz

    # Concatenate files and compress them
    zcat ${baseDir}/output/rcorrector/*_1.cor.fq.gz | gzip > all_reads_1.fq.gz
    zcat ${baseDir}/output/rcorrector/*_2.cor.fq.gz | gzip > all_reads_2.fq.gz
    """
}

