// BUSCO assessment for Trinity assembled transcripts

process BUSCO {

    tag "busco"
    label 'busco'

    publishDir "${params.outputDir}/busco", mode: 'copy', patters: "*.{busco,busco2,txt,tsv}"

    input:
    tuple path(annotated_okay_fasta)
    tuple path(trinityFasta)

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
    
    busco \\
        -i ${trinityFasta} \\
        -m trans \\
        -o busco2 \\
        --auto-lineage-euk \\
        -c ${task.cpus}
    """
}
