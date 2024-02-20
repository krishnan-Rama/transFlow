// BUSCO assessment for Trinity assembled transcripts

process BUSCO {

    tag "busco assessment"
    label 'busco'

    publishDir "${params.outputDir}/busco/Psca", mode: 'copy'

    input:
    tuple path(annotated_okay_fasta)

    output:
    path "busco_out", emit: buscoResults

    script:
    """
    busco \\
        --in ${annotated_okay_fasta} \\
        --out busco_out \\
        --mode transcriptome \\
        --auto-lineage-euk \\
        --cpu ${task.cpus}
    """
}
