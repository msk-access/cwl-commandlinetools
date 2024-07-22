class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  edam: 'http://edamontology.org/'
  foaf: 'http://xmlns.com/foaf/0.1/'
id: bedtools_genomecov
baseCommand:
  - bedtools
  - genomecov
inputs:
  - id: input
    type: File
    inputBinding:
      position: 5
      prefix: '-ibam'
      shellQuote: false
    doc: >-
      The input file can be in BAM format (Note: BAM  must be sorted by
      position)
    secondaryFiles:
      - ^.bai
  - id: output_file_name
    type: string?
  - id: memory_overhead
    type: int?
  - id: memory_per_job
    type: int?
  - id: number_of_threads
    type: int?
  - id: option_bedgraph
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-bg'
      separate: false
    doc: >-
      option flag parameter to choose output file format. -bg refers to bedgraph
      format
  - id: coverage
    type: int?
outputs:
  - id: bedtools_genomecove_bedgraph
    type: File
    outputBinding:
      glob: |-
        ${
             if (inputs.output_file_name)
              return inputs.output_file_name;
            return inputs.input.basename.replace('.bam','.bedgraph');
          }
label: bedtools_genomecov
arguments:
  - position: 98
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '|'
  - position: 99
    prefix: ''
    shellQuote: false
    separate: false
    valueFrom: awk
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '''$4'
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '>'
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: $(20 + '\'')
  - position: 100
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '|'
  - position: 101
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: grep
  - position: 101
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '-v'
  - position: 101
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '''^GL'''
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/bedtools:v2.28.0_cv2'
  - class: InlineJavascriptRequirement
stdout: |-
  ${
      if (inputs.output_file_name)
        return inputs.output_file_name;
      return inputs.input.basename.replace('.bam','.bedgraph');
    }
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': bedtools
    'doap:revision': v2.28.0_cv2
