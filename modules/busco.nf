// BUSCO assessment for Trinity assembled transcripts

process BUSCO {

    tag "busco"
    label 'busco'

    publishDir "${params.outputDir}/busco/Ea", mode: 'copy', patters: "*.{busco,txt,tsv}"

    input:
    tuple path(annotated_okay_fasta)

    output:
    path "busco", emit: buscoResults

    script:
    """
    busco \\
        -i ${annotated_okay_fasta} \\
        -m trans \\
        -o busco \\
        --auto-lineage-euk \\
        -c ${task.cpus}
    """
}
