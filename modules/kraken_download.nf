process downloadKrakenDB {
    tag "Downloading Kraken DB"
    label 'krakenDB'
    publishDir "${params.outputDir}/dependencies/kraken_db", mode: 'copy'

    output:
    path "k2_standard_20230605.tar.gz"

    script:
    """
    curl -L https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20230605.tar.gz -o k2_standard_20230605.tar.gz
    tar -xzvf k2_standard_20230605.tar.gz
    """
}

