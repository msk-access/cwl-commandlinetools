class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: mosdepth_0_3_3
baseCommand:
  - mosdepth
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: bed
    type: File?
    inputBinding:
      position: 0
      prefix: '-b'
      shellQuote: false
    doc: optional BED file or (integer) window-sizes.
  - id: chrom
    type: File?
    inputBinding:
      position: 0
      prefix: '-c'
      shellQuote: false
    doc: chromosome to restrict depth calculation.
  - id: input_bam
    type:
      - File
      - type: array
        items: File
    doc: Required list of input bam file (s) separated by comma
    secondaryFiles:
      - ^.bai
  - id: prefix
    type: string?
    doc: Prefix for the output files
  - id: flag
    type: int?
    inputBinding:
      position: 0
      prefix: '-F'
    doc: exclude reads with any of the bits in FLAG set
  - id: mapq
    type: int?
    inputBinding:
      position: 0
      prefix: '-Q'
    doc: mapping quality threshold. reads with a mapping quality less than this are ignored
outputs:
  - id: per_base_bed
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '.per-base.bed.gz'
            } else {
              return 'per-base.bed.gz'
            }
        }
  - id: per_region_bed
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '.regions.bed.gz'
            } else {
              return 'regions.bed.gz'
            }
        }
  - id: global_distribution
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '.mosdepth.global.dist.txt'
            } else {
              return 'mosdepth.global.dist.txt'
            }
        }
  - id: region_distribution
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '.mosdepth.region.dist.txt'
            } else {
              return 'mosdepth.region.dist.txt'
            }
        }
doc: 'fast BAM/CRAM depth calculation for WGS, exome, or targeted sequencing.'
label: mosdepth_0.3.3
arguments:
  - position: 0
    prefix: '-t'
    valueFrom: $(runtime.cores)
  - position: 99
    valueFrom: $(inputs.prefix)
  - position: 100
    valueFrom: $(inputs.input_bam)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/mosdepth:0.3.3'
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
        'foaf:mbox': 'mailto:charalk@mskcc.org'
        'foaf:name': Carmelina
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': mosdepth
    'doap:revision': 0.3.3
