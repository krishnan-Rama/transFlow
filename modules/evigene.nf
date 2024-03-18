//evigene.nf

process Evigene {

    tag "Evigene tr2aacds classification and annotation"
    label 'evigene'
    publishDir "${params.outputDir}/evigene", mode: 'copy'

    input:
    tuple path(trinityFasta)

    output:
    path "*.okay.fasta", emit: annotated_okay_fasta
    path "*.okay.aa.fasta", emit: annotated_protein_fasta
    path "*.notokay.fasta", emit: annotated_notokay_fasta
    path "tr2aacds.log", emit: tr2aacds_log

    script:
    """
    tr2aacds.pl -mrnaseq ${trinityFasta} -MINCDS=60 -MAXMEM=12800 -logfile tr2aacds.log -tidyup
    """
}

