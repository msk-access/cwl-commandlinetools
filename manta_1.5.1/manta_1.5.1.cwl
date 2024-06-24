class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: manta_1_5_1
baseCommand:
  - /usr/bin/python
  - /usr/local/bin/manta/bin/configManta.py
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: call_regions
    type: File?
    inputBinding:
      position: -5
      prefix: '--callRegions'
    doc: >-
      bgzip-compressed, tabix-indexed BED file specifiying regions to which
      variant analysis will be restricted
    secondaryFiles:
      - .tbi
  - id: non_wgs
    type: boolean?
    inputBinding:
      position: -6
      prefix: '--exome'
    doc: toggles on settings for WES
  - id: normal_bam
    type: File?
    inputBinding:
      position: -2
      prefix: '--normalBam'
    doc: >-
      Normal sample BAM or CRAM file. May be specified more than once, multiple
      inputs will be treated as each BAM file representing a different sample.
      [optional] (no default)
    secondaryFiles:
      - |-
        ${
            if (self.nameext === ".bam") {
                return self.basename + ".bai"
            }
            else {
                return self.basename + ".crai"
            }
        }
  - id: output_contigs
    type: boolean?
    inputBinding:
      position: -7
      prefix: '--outputContig'
    doc: >-
      if true, outputs assembled contig sequences in final VCF files, in the
      INFO field CONTIG
  - id: reference_fasta
    type: File
    inputBinding:
      position: -4
      prefix: '--referenceFasta'
    doc: 'samtools-indexed reference fasta file [required]'
    secondaryFiles:
      - .fai
  - id: tumor_bam
    type: File
    inputBinding:
      position: -3
      prefix: '--tumorBam'
    doc: Tumor sample BAM or CRAM file. Only up to one tumor bam file accepted.
    secondaryFiles:
      - |-
        ${
            if (self.nameext === ".bam") {
                return self.basename + ".bai"
            }
            else {
                return self.basename + ".crai"
            }
        }
  - id: generateEvidenceBam
    type: boolean?
    inputBinding:
      position: -8
      prefix: '--generateEvidenceBam'
      separate: false
    doc: Generate a bam of supporting reads for all SVs
outputs:
  - id: manta_all_candidates_vcf_gz
    type: File
    outputBinding:
      glob: results/variants/candidateSV.vcf.gz
    secondaryFiles:
      - .tbi
  - id: manta_diploid_variants_vcf_gz
    type: File?
    outputBinding:
      glob: results/variants/diploidSV.vcf.gz
    secondaryFiles:
      - .tbi
  - id: manta_small_candidates_vcf_gz
    type: File
    outputBinding:
      glob: results/variants/candidateSmallIndels.vcf.gz
    secondaryFiles:
      - .tbi
  - id: manta_somatic_variants_vcf_gz
    type: File?
    outputBinding:
      glob: results/variants/somaticSV.vcf.gz
    secondaryFiles:
      - .tbi
  - id: manta_tumor_only_variants_vcf_gz
    type: File?
    outputBinding:
      glob: results/variants/tumorSV.vcf.gz
    secondaryFiles:
      - .tbi
  - id: manta_evidence_bams
    type: 'File[]?'
    outputBinding:
      glob: |-
        ${ if(inputs.generateEvidenceBam){
            return 'results/evidence/*.bam'
            }
        }
    secondaryFiles:
      - .bai
doc: Setup and execute Manta 1.51
label: manta_1.5.1
arguments:
  - position: -1
    prefix: '--runDir'
    valueFrom: $(runtime.outdir)
  - position: 0
    shellQuote: false
    valueFrom: '&&'
  - /usr/bin/python
  - runWorkflow.py
  - '-m'
  - local
  - position: 1
    prefix: '-j'
    valueFrom: $(runtime.cores)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/manta:1.5.1'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': manta
    'doap:revision': 1.5.1
