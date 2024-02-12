// concatenate.nf

process ConcatenateReads {

    tag "Concatenating Reads"
    publishDir "${params.outputDir}/concatenated/Psca", mode: 'copy'

    input:
    tuple path(trimmedRead1), path(trimmedRead2)

    output:
    tuple path(concatenatedRead1.fastq), path(concatenatedRead2.fastq), emit: concatenatedReads

    script:
    """
    cat ${trimmedRead1.join(' ')} > concatenatedRead1.fastq
    cat ${trimmedRead2.join(' ')} > concatenatedRead2.fastq
    """
}

