//trinitymapping.nf

process trinitymapping {

    tag "${sample_id}"
    label 'trinitymapping'

    publishDir "${params.outputDir}/trinitymapping", mode: 'copy'

    input:
    tuple path(annotated_okay_fasta)
    tuple val(sample_id), path(filteredRead1), path(filteredRead2)

    output:
    tuple path("rsemdir/${sample_id}")

    script:
    """
    \$TRINITY_HOME/util/align_and_estimate_abundance.pl \
     --transcripts ${annotated_okay_fasta} \
     --seqType fq \
     --left ${filteredRead1} \
     --right ${filteredRead2} \
     --est_method RSEM \
     --aln_method bowtie2 \
     --trinity_mode \
     --thread_count ${task.cpus} \
     --prep_reference \
     --bowtie2_RSEM "--no-mixed --no-discordant --gbar 1000 -k 200 --end-to-end -N 1 --mp 4" \
      --output_dir rsemdir/${sample_id}
    """
}
