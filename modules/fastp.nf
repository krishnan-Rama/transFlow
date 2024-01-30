// fastp.nf

process Fastp {
    tag "${sample_id}"
    label 'Fastp'
    publishDir "${params.outputDir}/fastp/Psca", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id), path("${sample_id}_1.fastp.fastq.gz"), path("${sample_id}_2.fastp.fastq.gz"), emit: trimmedReads
    path "*.html", emit: report
    path "*.json", emit: json

    script:
    """
    fastp \
        -i ${read1} \
        -I ${read2} \
        -o ${sample_id}_1.fastp.fastq.gz \
        -O ${sample_id}_2.fastp.fastq.gz \
        -h ${sample_id}.html \
        -j ${sample_id}.json
    """
}

