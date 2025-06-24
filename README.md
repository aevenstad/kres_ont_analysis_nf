# kres-UNN/ont_basecalling

## Steps:
* Basecalling 
* Demultiplexing of barcodes
* QC

## Notes:
The pipeline takes both input as a samplesheet and through the parameter `--pod5`.  
  
The first step, basecalling with `Dorado`, uses the pod5 parameter as input, which should be the path to a directory with pod5-files from a ONT sequencing run.  
  
After demultiplexing the sample info in the samplesheet is coupled to the barcode fastq-files and the subsequent steps are carried out per sample.

**Current usage:**
```
nextflow run main.nf -profile singularity --input samplesheet.csv --pod5 pod5/ --outdir out
```

**samplesheet.csv:**
```
sample,barcode
sample1,barcode19
sample2,barcode12
sample3,barcode17
sample4,barcode02
sample5,barcode16
```

## TO-DO
* 
