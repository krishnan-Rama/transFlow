// concatenate.nf

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

    # Ensure output files are empty or non-existent before starting concatenation
    > all_reads_1.fq
    > all_reads_2.fq

    # Concatenate files using a loop to handle large numbers of files, decompressing and recompressing
    find ${baseDir}/output/rcorrector -name '*_1.cor.fq.gz' | sort | xargs zcat >> all_reads_1.fq
    find ${baseDir}/output/rcorrector -name '*_2.cor.fq.gz' | sort | xargs zcat >> all_reads_2.fq

    # Compress the concatenated files
    gzip all_reads_1.fq
    gzip all_reads_2.fq
    """
}

