//concatanate.nf

process ConcatenateReads {
    tag "Concatenating Reads"
    publishDir "${params.outputDir}/concatenated_reads", mode: 'copy'

    input:
    path rcorrectRead1
    path rcorrectRead2

    output:
    path("all_reads_1.fq.gz"), emit: concatenatedRead1
    path("all_reads_2.fq.gz"), emit: concatenatedRead2

    script:
    """
    echo "Concatenating the following files for read 1:"
    for file in ${rcorrectRead1}; do
        echo \$file
    done

    echo "Concatenating the following files for read 2:"
    for file in ${rcorrectRead2}; do
        echo \$file
    done

    # Ensure output files are empty or non-existent before starting concatenation
    > all_reads_1.fq
    > all_reads_2.fq

    # Concatenate files using a loop to handle large numbers of files, decompressing and recompressing
    for file in ${rcorrectRead1}; do
        zcat \$file >> all_reads_1.fq
    done

    for file in ${rcorrectRead2}; do
        zcat \$file >> all_reads_2.fq
    done

    # Compress the concatenated files
    gzip all_reads_1.fq
    gzip all_reads_2.fq
    """
}

