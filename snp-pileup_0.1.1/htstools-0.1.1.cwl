cwlVersion: v1.0

class: CommandLineTool
baseCommand: [snp-pileup]
id: snp-pileup

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: roslin/pipeline-htstools:0.1.1
  ResourceRequirement:
    ramMin: 16000
    coresMin: 3

doc: |
  Run snp-pileup on a vcf file

inputs:
  vcf_file:
    type: File
    inputBinding:
      position: 0

  output_file:
    type: string
    inputBinding:
      position: 1

  bam_normal:
    type: File
    inputBinding:
      position: 2

  bam_tumor:
    type: File
    inputBinding:
      position: 3

  count_orphans:
    default: true
    type: boolean
    inputBinding:
      prefix: -A

  pseudo_snps:
    type: int
    default: 50
    inputBinding:
      prefix: -P

  gzip:
    type: boolean
    default: true
    inputBinding:
      prefix: --gzip

  ignore_overlaps:
    type: boolean?
    default: false
    inputBinding:
      prefix: --ignore-overlaps

  max_depth:
    type: int?
    inputBinding:
      prefix: -d

outputs:
  output_file:
    type: File
    outputBinding:
      glob: '*.*'
