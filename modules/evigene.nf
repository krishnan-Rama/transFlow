//evigene.nf

process Evigene {

    tag "Evigene tr2aacds classification and annotation"
    label 'evigene'
    
    publishDir "${params.outputDir}/evigene", mode: 'copy', pattern: "{okayset,dropset}/**"

    input:
    tuple path(trinityFasta)

    output:
    tuple path("*.okay.fasta"), emit: annotated_okay_fasta
    tuple path("*.okay.aa.fasta"), emit: annotated_protein_fasta
    tuple path("*.notokay.fasta"), emit: annotated_notokay_fasta

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

