//filter_kraken.nf

process ExtractKrakenReads {

    tag "${sample_id}"
    label 'KrakenTools'
    publishDir "${params.outputDir}/kraken_filtered/Psca", mode: 'copy'

    input:
    tuple val(sample_id), path(trimmedRead1), path(trimmedRead2), path(krakenOutput1), path(krakenOutput2)

    output:
    tuple val(sample_id), path("${sample_id}_filtered_1.fastq.gz"), path("${sample_id}_filtered_2.fastq.gz"), emit: filteredReads

    script:
    """
    source ${baseDir}/modules/python_kraken/python_kraken2/bin/activate    

    python ${baseDir}/modules/extract_kraken_reads.py \\
        -k ${krakenOutput2} \\
        -s1 ${trimmedRead1} \\
        -s2 ${trimmedRead2} \\
        -r ${krakenOutput1} \\
        --exclude --include-parents --taxid 2 \\
        -o ${sample_id}_filtered_1.fastq \\
        -o2 ${sample_id}_filtered_2.fastq    
     """
}

