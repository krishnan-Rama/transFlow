// kraken2dbsetup.nf
process Kraken2DBSetup {
    
    tag "Kraken2DBSetup"
    label 'Kraken2DBSetup'
    publishDir "${params.outputDir}/kraken2db", mode: 'copy'

    output:
    path "../databases/kraken2_database", emit: db

    script:
    """
    mkdir -p ../databases
    if [ ! -d "../databases/kraken2_database" ]; then
        wget -O kraken2_db.tar.gz https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20230605.tar.gz
        tar -xzf kraken2_db.tar.gz -C ../databases
        mv ../databases/kraken2_standard_20230605 ../databases/kraken2_database
        rm kraken2_db.tar.gz
    fi
    """
}

