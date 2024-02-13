//trinityassembly.nf

process Trinity {

    tag "trinity assembly"
    label 'trinity'
    publishDir "${params.outputDir}/trinity_assembly/Psca", mode: 'copy'

    input:
    tuple path(concatenatedRead1), path(concatenatedRead2)

    output:
    tuple path("Trinity.fasta"), emit: trinityFasta

    script:
    """
    Trinity --seqType fq --max_memory ${task.memory} --left ${concatenatedRead1} --right ${concatenatedRead2} --CPU ${task.cpus} --output ${sample_id}_trinity_out
    """
}

