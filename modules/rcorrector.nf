//rcorrector.nf

process rcorrector {

    tag "${sample_id}"
    label 'rcorrector'
    time '24h'
    publishDir "${params.outputDir}/rcorrector", mode: 'copy'
    
    input:
    tuple val(sample_id), path(filteredRead1), path(filteredRead2)

    output:
    tuple val(sample_id), path("${sample_id}_filtered_1.cor.fq.gz"), path("${sample_id}_filtered_2.cor.fq.gz"), emit: rcorrectReads

    script:
    """
    run_rcorrector.pl -1 ${filteredRead1} -2 ${filteredRead2} -t ${task.cpus} 
    """
}

