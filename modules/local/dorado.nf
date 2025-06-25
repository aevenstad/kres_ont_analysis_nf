process DORADO_BASECALL {
    publishDir "${params.outdir}", mode: 'copy'
    container 'docker.io/nanoporetech/dorado:shae9327ad17e023b76e4d27cf287b6b9d3a271092b'
    containerOptions '--nv'

    input:
    file pod5

    output:
    path("basecalled.fastq.gz")             , emit: fastq
    path "versions.yml"                                         , emit: versions

    script:
    """
    dorado basecaller ${params.dorado_mode} \\
    --emit-fastq \\
    --device cuda:0 \\
    --kit-name ${params.barcode_kit} \\
    --no-trim \\
    ${pod5} | \\
    gzip > basecalled.fastq.gz

    VER=\$(dorado --version 2>&1)
    echo "dorado: \$VER" > versions.yml
    """
}

process DORADO_DEMUX {
    publishDir "${params.outdir}", mode: 'copy'
    container 'docker.io/nanoporetech/dorado:shae9327ad17e023b76e4d27cf287b6b9d3a271092b'
    containerOptions '--nv'

    input:
    path fastq

    output:
    path("demux_fastq/*fastq.gz"), emit: fastq

    script:
    """
    dorado demux \\
    --kit-name ${params.barcode_kit} \\
    --emit-fastq \\
    --output-dir demux_fastq \\
    ${fastq}

    gzip demux_fastq/*.fastq
    """
}