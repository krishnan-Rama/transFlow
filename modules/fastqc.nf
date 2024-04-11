// fastqc.nf

process FastQC {

    tag "${sample_id}"
    label 'FastQC'
    publishDir "${params.outputDir}/fastqc", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "${sample_id}_*_fastqc.html", emit: report
    path "${sample_id}_*_fastqc.zip", emit: zip

    script:
    """
    fastqc -o . ${read1}
    fastqc -o . ${read2}
    """
}

