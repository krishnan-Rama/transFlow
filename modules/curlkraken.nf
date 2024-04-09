process curlKrakenDB {
    tag "Downloading Kraken DB"
    label 'krakenDB'
    publishDir "${params.outputDir}/dependencies", mode: 'copy'

    output:
    path "kraken_standard/*"

    script:
    """
    mkdir -p kraken_standard    
    curl -L https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20231009.tar.gz -o k2_standard_20231009.tar.gz && tar -xzvf k2_standard_20231009.tar.gz -C kraken_standard/
    """
}
