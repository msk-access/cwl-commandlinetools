class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: bcftools_sort
baseCommand:
  - bcftools
  - sort
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
    inputBinding:
      position: 0
      prefix: '--threads'
  - id: output_name
    type: string?
    doc: Output file name
  - id: output_type
    type: string?
    inputBinding:
      position: 99
      prefix: '-O'
    doc: >-
      compressed BCF (b), uncompressed BCF (u), compressed VCF (z), uncompressed
      VCF (v)
  - id: input
    type: File
    inputBinding:
      position: 100
    doc: input vcf files
    secondaryFiles:
      - .tbi
outputs:
  - id: sorted_file
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.output_name) {
                return inputs.output_name
            } else {
                return inputs.input.basename.replace(/.vcf/, '.sorted.vcf')
            }
        }
label: bcftools_sort
arguments:
  - position: 0
    prefix: '-o'
    valueFrom: |-
      ${
          if(inputs.output_name) {
              return inputs.output_name
          } else {
              return inputs.input.basename.replace(/.vcf/, '.sorted.vcf')
              }
          }
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/bcftools:1.15.1'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input)
  - class: InlineJavascriptRequirement
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
    'doap:name': bcftools sort
    'doap:revision': 1.15.1
