//evigene.nf

process Evigene {

    tag "Evigene tr2aacds classification and annotation"
    label 'evigene'
    
    publishDir "${params.outputDir}/evigene/Ea", mode: 'copy', pattern: "{okayset,dropset}/**"

    input:
    tuple path(trinityFasta)

    output:
    tuple path("okayset/*.okay.Trinity.fasta"), emit: annotated_okay_fasta
    tuple path("okayset/*.okay.Trinity.aa"), emit: annotated_protein_fasta
    path("dropset")

    script:
    """
    /opt/evigene/scripts/prot/tr2aacds.pl -mrnaseq ${trinityFasta} \\
              -MINCDS=60 \\
              -MAXMEM=12800 \\
              -logfile \\
              -NCPU=8 \\
              -tidyup
    """
}

