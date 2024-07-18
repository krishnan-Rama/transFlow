// upimapi.nf

process UPIMAPI {
    tag "Annotation"
    label 'upimapi'
    time '4h'
    publishDir "${params.outputDir}/upimapi_annotations", mode: 'copy'

    input:
    path blastp_out
    val SPECIES_IDENTIFIER

    output:
    path "upimapi/*"

    script:
    """
    for i in sprot Dmel Cele Mmus Scer Hsap; do

    mkdir -p upimapi/\${i}/

    upimapi --blast -i "${blastp_out}/${SPECIES_IDENTIFIER}_\${i}_blp.tsv" -t ${task.cpus} -o upimapi/\${i}/ -ot "upimapi/\${i}/${SPECIES_IDENTIFIER}_\${i}_upimapi.tsv" --columns "Organism&Gene Names&InterPro&PANTHER"

    done
    """
}

