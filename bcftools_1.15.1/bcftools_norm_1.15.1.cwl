class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: norm
baseCommand:
  - bcftools
  - norm
inputs:
  - id: check_ref
    type: string?
    inputBinding:
      position: 99
      prefix: '--check-ref'
  - id: multiallelics
    type: string?
    inputBinding:
      position: 99
      prefix: '-m'
    doc: use any
  - id: output_type
    type: string
    inputBinding:
      position: 99
      prefix: '-O'
  - id: output_name
    type: string?
    inputBinding:
      position: 99
      prefix: '-o'
  - id: input
    type: File
    inputBinding:
      position: 100
    doc: input vcf file
    secondaryFiles:
      - .tbi
  - id: fastaRef
    type: File
    inputBinding:
      position: 99
      prefix: '-f'
    secondaryFiles:
      - .fai
outputs:
  - id: normalized_vcf
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.output_name
        } 
label: bcftools_norm
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 1
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
    'doap:name': bcftools norm
    'doap:revision': 1.15.1