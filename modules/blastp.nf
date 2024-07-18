// blastp.nf

process blastp {
    tag "blastp"
    label 'blastp'
    publishDir "${params.outputDir}/blast_results", mode: 'copy'

    input:
    path annotated_okay_aa
    path blastdb_paths
    val SPECIES_IDENTIFIER

    output:
    path "*", emit: blastp_out

    script:
    """
    mkdir -p blastp_out
    blastlib=("sprot" "Hsap" "Mmus" "Dmel" "Cele" "Scer")

    for db in "\${blastlib[@]}"; do
        blastp -query "${annotated_okay_aa}" \
               -db "${blastdb_paths}/\${db}" \
               -num_threads ${task.cpus} \
               -max_target_seqs 1 \
               -evalue 1E-10 \
               -outfmt 6 \
               -out "blastp_out/${SPECIES_IDENTIFIER}_\${db}_blp.tsv"
    done
    """
}
