// fastqc.nf

process FastQC {

    tag "${sample_id}"
    label 'FastQC'
    publishDir "${params.outputDir}/fastqc/Psca", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "${sample_id}_1_fastqc.html", emit: report1
    path "${sample_id}_1_fastqc.zip", emit: zip1
    path "${sample_id}_2_fastqc.html", emit: report2
    path "${sample_id}_2_fastqc.zip", emit: zip2

    script:
    """
    fastqc -o . ${read1}
    fastqc -o . ${read2}
    """
}

