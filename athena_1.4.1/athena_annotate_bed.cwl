class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: athena_1_4_1
baseCommand:
  - annotate_bed.py
inputs:
  - id: panel_bed
    type: File
    inputBinding:
      position: 0
      prefix: '-p'
      shellQuote: false
  - id: transcript_file
    type: File
    inputBinding:
      position: 0
      prefix: '-t'
      shellQuote: false
  - id: coverage_file
    type: File
    inputBinding:
      position: 0
      prefix: '-c'
      shellQuote: false
outputs:
  - id: gene_exon_coverage
    type: File
label: athena_1.4.1
arguments:
  - position: 0
    prefix: '-t'
    valueFrom: $(runtime.cores)
  - position: 99
    prefix: ''
    valueFrom: $(inputs.prefix)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 17000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/athena:1.4.1'
  - class: InlineJavascriptRequirement
