//trinitymapping.nf

process trinitymapping {

    tag "${sample_id}"
    label 'Mapping'

    publishDir "${params.outputDir}/trinitymapping", mode: 'copy'

    input:
    path (annotated_okay_fasta) 
    path (okay_trans_map)
    tuple val(sample_id), path(filteredRead1), path(filteredRead2)

    output:
    path ("rsemdir/*")
    tuple path("rsemdir/${sample_id}/*"), emit: rsem_dir
    path ("rsemdir/${sample_id}/RSEM.isoforms.results"), emit: isoforms

    script:
    """
    echo "Processing sample ID: ${sample_id}"
    mkdir -p ${sample_id}
    cp ${annotated_okay_fasta} ${sample_id}/${annotated_okay_fasta}
    cp ${okay_trans_map} ${sample_id}/${okay_trans_map}

    echo "Running Trinity align_and_estimate_abundance.pl for sample ID: ${sample_id}"

    \$TRINITY_HOME/util/align_and_estimate_abundance.pl \
     --transcripts ${sample_id}/${annotated_okay_fasta} \
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

    echo "Finished processing sample ID: ${sample_id}"
    """
}

