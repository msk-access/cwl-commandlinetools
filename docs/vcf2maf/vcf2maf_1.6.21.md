# CWL and Dockerfile for running vcf2maf v1.6.21

## Version of tools in docker image (/container/Dockerfile)

| Tool	| Version	| Location	|
|---	|---	|---	|
| clearlinux (base image)  	| -  	|   -	|
| vcf2maf  	        | 1.6.21	| https://github.com/mskcc/vcf2maf/archive/v1.6.21.zip	|
| VEP  	            | 105  	| - | - |
|MINICONDA_VERSION  | py37_4.9.2  | https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh
|BCFTOOLS_VERSION  	| 1.10.2      | - | - |
|SAMTOOLS_VERSION  	| 1.10        | - | - |
|VCF2MAF_VERSION  	| 1.6.21      | - | - |
|HTSLIB_VERSION  	  | 1.10.2      | - | - |

## CWL

- CWL specification 1.0
- Use example_inputs.yaml to see the inputs to the cwl
- Example Command using [toil](https://toil.readthedocs.io):

```bash
    > toil-cwl-runner vcf2maf_1.6.21.cwl example_inputs.yaml
```

**If at MSK, using the JUNO cluster having installed toil version 3.19 and manually modifying [lsf.py](https://github.com/DataBiosphere/toil/blob/releases/3.19.0/src/toil/batchSystems/lsf.py#L170) by removing `type==X86_64 &&` you can use the following command**

```bash
#Using CWLTOOL
> cwltool --singularity --non-strict /path/to/vcf2maf_1.6.21.cwl /path/to/inputs.yaml

#Using toil-cwl-runner
> mkdir vcf2maf_toil_log
> toil-cwl-runner --singularity --logFile /path/to/vcf2maf_toil_log/cwltoil.log  --jobStore /path/to/vcf2maf_jobStore --batchSystem lsf --workDir /path/to/vcf2maf_toil_log --outdir . --writeLogs /path/to/vcf2maf_toil_log --logLevel DEBUG --stats --retryCount 2 --disableCaching --maxLogFileSize 20000000000 /path/to/vcf2maf_1.6.17.cwl /path/to/inputs.yaml > vcf2maf_toil.stdout 2> vcf2maf_toil.stderr &
```

### Usage

```
Usage:
     perl vcf2maf.pl --help
     perl vcf2maf.pl --input-vcf input.vcf --output-maf output.maf --tumor-id TUMOR_ID --normal-id NORMAL_ID

--input-vcf      Path to input file in VCF format
--output-maf     Path to output MAF file
--tmp-dir        Folder to retain intermediate VCFs after runtime [Default: Folder containing input VCF]
--tumor-id       Tumor_Sample_Barcode to report in the MAF [TUMOR]
--normal-id      Matched_Norm_Sample_Barcode to report in the MAF [NORMAL]
--vcf-tumor-id   Tumor sample ID used in VCF's genotype columns [--tumor-id]
--vcf-normal-id  Matched normal ID used in VCF's genotype columns [--normal-id]
--custom-enst    List of custom ENST IDs that override canonical selection
--vep-path       Folder containing the vep script [~/miniconda3/bin]
--vep-data       VEP's base cache/plugin directory [~/.vep]
--vep-forks      Number of forked processes to use when running VEP [4]
--vep-custom     String to pass into VEP's --custom option []
--vep-config     Config file to pass into VEP's --config option []
--vep-overwrite  Allow VEP to overwrite output VCF if it exists
--buffer-size    Number of variants VEP loads at a time; Reduce this for low memory systems [5000]
--any-allele     When reporting co-located variants, allow mismatched variant alleles too
--inhibit-vep    Skip running VEP, but extract VEP annotation in VCF if found
--online         Use useastdb.ensembl.org instead of local cache (supports only GRCh38 VCFs listing <100 events)
--ref-fasta      Reference FASTA file [~/.vep/homo_sapiens/102_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz]
--max-subpop-af  Add FILTER tag common_variant if gnomAD reports any subpopulation AFs greater than this [0.0004]
--species        Ensembl-friendly name of species (e.g. mus_musculus for mouse) [homo_sapiens]
--ncbi-build     NCBI reference assembly of variants MAF (e.g. GRCm38 for mouse) [GRCh37]
--cache-version  Version of offline cache to use with VEP (e.g. 75, 91, 102) [Default: Installed version]
--maf-center     Variant calling center to report in MAF [.]
--retain-info    Comma-delimited names of INFO fields to retain as extra columns in MAF []
--retain-fmt     Comma-delimited names of FORMAT fields to retain as extra columns in MAF []
--retain-ann     Comma-delimited names of annotations (within the VEP CSQ/ANN) to retain as extra columns in MAF []
--min-hom-vaf    If GT undefined in VCF, minimum allele fraction to call a variant homozygous [0.7]
--remap-chain    Chain file to remap variants to a different assembly before running VEP
--verbose        Print more things to log progress
--help           Print a brief help message and quit
--man            Print the detailed manual
```
