class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: bcftools_concat
baseCommand:
  - bcftools
  - concat
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: allow_overlaps
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-a'
    doc: >-
      First coordinate of the next file can precede last record of the current
      file.
  - id: output_name
    type: string
    inputBinding:
      position: 0
      prefix: '-o'
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
    type: 'File[]'
    inputBinding:
      position: 100
    secondaryFiles:
      - .tbi
outputs:
  - id: concatenated_vcf
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.output_name
        }
label: bcftools_concat
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/bcftools:1.15.1'
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
    'doap:name': bcftools concat
    'doap:revision': 1.15.1
