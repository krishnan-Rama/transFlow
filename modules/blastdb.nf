// blastdb.nf

process blastdb {
    tag "blastdb"
    label 'blastdb'
    time '10h'
    publishDir "${params.outputDir}/blastdb", mode: 'copy'

    output:
    path "*", emit: blastdb_paths

    script:
    """
    mkdir -p blastdb

    # URLs for downloading datasets and output filenames
    urls=(
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz blastdb/sprot.fasta.gz"
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000005640/UP000005640_9606.fasta.gz blastdb/Hsap.fasta.gz"
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000000589/UP000000589_10090.fasta.gz blastdb/Mmus.fasta.gz"
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000000803/UP000000803_7227.fasta.gz blastdb/Dmel.fasta.gz"
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000001940/UP000001940_6239.fasta.gz blastdb/Cele.fasta.gz"
        "ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/Eukaryota/UP000002311/UP000002311_559292.fasta.gz blastdb/Scer.fasta.gz"
    )

    # Download datasets
    for entry in "\${urls[@]}"; do
        url=\$(echo "\$entry" | cut -d ' ' -f 1)
        output=\$(echo "\$entry" | cut -d ' ' -f 2)
        wget "\$url" -O "\$output"
    done

    # Unzip the downloaded files
    gunzip blastdb/*.gz

    # Create BLAST databases
    makeblastdb -in blastdb/sprot.fasta -dbtype prot -title sprot -out blastdb/sprot
    makeblastdb -in blastdb/Hsap.fasta -dbtype prot -title Hsap -out blastdb/Hsap
    makeblastdb -in blastdb/Mmus.fasta -dbtype prot -title Mmus -out blastdb/Mmus
    makeblastdb -in blastdb/Dmel.fasta -dbtype prot -title Dmel -out blastdb/Dmel
    makeblastdb -in blastdb/Cele.fasta -dbtype prot -title Cele -out blastdb/Cele
    makeblastdb -in blastdb/Scer.fasta -dbtype prot -title Scer -out blastdb/Scer
    """
}

