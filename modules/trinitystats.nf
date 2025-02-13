//trinitystats.nf

process Trinity_stats {

    tag "trinity assembly"
    label 'trinity'
    time '12h'
    publishDir "${params.outputDir}/trinity_stats", mode: 'copy'

    input:
    tuple path(trinityFasta)
    tuple path(annotated_okay_fasta)

    output:
    path "trinity_out.fasta_stats.txt"
    path "trinity_out.okay_fasta_stats.txt"
    path "trinity_out_okay.gene_trans_map", emit: okay_trans_map

    script:
    """
    TrinityStats.pl ${trinityFasta} > trinity_out.fasta_stats.txt

    TrinityStats.pl ${annotated_okay_fasta} > trinity_out.okay_fasta_stats.txt

    get_Trinity_gene_to_trans_map.pl ${annotated_okay_fasta} > trinity_out_okay.gene_trans_map
    """
}

