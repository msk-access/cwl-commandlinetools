class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: snpsift_annotate_5_0
baseCommand:
  - java
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: input_DB_vcf
    type: File
    inputBinding:
      position: 25
    secondaryFiles:
      - .tbi
  - id: input_vcf
    type: File
    inputBinding:
      position: 26
  - id: tabix
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-tabix'
    doc: 'VCF database is tabix-indexed. Default: false'
  - id: config
    type: File?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: Specify config file
  - id: debug
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-d'
    doc: debug
  - id: output_file_name
    type: string?
  - id: sorted
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-sorted'
    doc: 'VCF database is sorted and uncompressed. Default: false'
outputs:
  - id: annotatedOutput
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.output_file_name) {
                return inputs.output_file_name
            } else {
                return inputs.input_vcf.basename.replace(/.vcf/, '_snpsift.vcf')
            }
        }
label: snpsift_annotate_5.0
arguments:
  - position: 0
    prefix: '-jar'
    valueFrom: /snpEff/SnpSift.jar
  - position: 0
    valueFrom: annotate
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/snpsift:5.0'
  - class: InlineJavascriptRequirement
stdout: >-
  ${      if (inputs.output_file_name) {          return
  inputs.output_file_name      } else {          return
  inputs.input_vcf.basename.replace(/.vcf/, 'snpsift.vcf')      }  }
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sivaprk@mskcc.org'
        'foaf:name': Karthigayini Sivaprakasam
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sivaprk@mskcc.org'
        'foaf:name': Karthigayini Sivaprakasam
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': snpsift
    'doap:revision': 5
