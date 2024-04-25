// fastqc2.nf

process FastQC_2 {

    tag "${sample_id}"
    label 'FastQC'
    publishDir "${params.outputDir}/fastqc_prep", mode: 'copy'

    input:
    tuple val(sample_id), path(rcorrectRead1), path(rcorrectRead1)

    output:
    path "${sample_id}_*_fastqc.html", emit: report
    path "${sample_id}_*_fastqc.zip", emit: zip

    script:
    """
    fastqc -o . ${rcorrectRead1}
    fastqc -o . ${rcorrectRead1}
    """
}
