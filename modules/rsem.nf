// rsem.nf

process RSEM {
    tag "RSEM analysis"
    label 'rsem'
    time '4h'
    publishDir "${params.outputDir}/rsem", mode: 'copy'

    input:
    tuple path(annotated_okay_fasta)
    tuple path(rsem_dir)
    tuple path(okay_trans_map)
    tuple path(isoforms)    
    path metadata

    output:
    path "*.matrix"
    path "edgeR_results"
    path "*_norm"

    script:
    """
    echo "annotated_okay_fasta: ${annotated_okay_fasta}"
    echo "rsem_dir: ${rsem_dir}"
    echo "gene_trans_map: ${okay_trans_map}"
    echo "metadata: ${metadata}"

    isoform_counts=\$(ls "${isoforms}")

    \$TRINITY_HOME/util/abundance_estimates_to_matrix.pl \\
                   --gene_trans_map ${okay_trans_map} \\
                   --name_sample_by_basedir --est_method RSEM \$isoform_counts \\
                   --out_prefix RSEM || { echo "Error running abundance_estimates_to_matrix.pl"; exit 1; }

    \$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl RSEM.gene.TPM.not_cross_norm | tee RSEM.qgenes_matrix.TPM.not_cross_norm.counts_by_min_TPM || { echo "Error running count_matrix_features_given_MIN_TPM_threshold.pl"; exit 1; }

    \$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.gene.counts.matrix --samples ${metadata} --CPM --log2 --compare_replicates || { echo "Error running PtR --compare_replicates"; exit 1; }

    \$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.gene.counts.matrix -s ${metadata} --log2 --sample_cor_matrix || { echo "Error running PtR --sample_cor_matrix"; exit 1; }

    \$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.gene.counts.matrix -s ${metadata} --log2 --prin_comp 3 || { echo "Error running PtR --prin_comp"; exit 1; }

    \$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix RSEM.gene.counts.matrix --samples_file ${metadata} --method edgeR --dispersion 0.1 --output edgeR_results || { echo "Error running run_DE_analysis.pl"; exit 1; }

    \$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix RSEM.gene.counts.matrix -P 1e-3 -C 1.4 --samples ${metadata} || { echo "Error running analyze_diff_expr.pl"; exit 1; }
    """
}

