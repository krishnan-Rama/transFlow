//trinityassembly.nf

process Trinity {
    tag "trinity assembly"
    label 'trinity'
    time '72h'
    publishDir "${params.outputDir}/trinity_assembly", mode: 'copy'

    input:
    path concatenatedRead1
    path concatenatedRead2

    output:
    path("trinity_out.Trinity.fasta"), emit: trinityFasta
    path "trinity_out.Trinity.fasta.gene_trans_map", emit: trans_map

    script:
    """
    Trinity \\
        --seqType fq \\
        --max_memory 100G \\
        --left ${concatenatedRead1} \\
        --right ${concatenatedRead2} \\
        --CPU ${task.cpus} \\
        --output trinity_out \\
        --full_cleanup
    """
}

