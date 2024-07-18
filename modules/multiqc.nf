// multiqc.nf

process multiqc {
    tag "Multiqc"
    label 'multiqc'
    time '2h'
    publishDir "${params.outputDir}/multiqc", mode: 'copy'

    input:
    path "params.outputDir"

    output:
    path "multiqc/*"

    script:
    """
    multiqc ${params.outputDir} -o multiqc
    """
}

