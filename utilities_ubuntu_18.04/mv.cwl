class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: mv
baseCommand:
  - mv
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: infile
    type: File
    inputBinding:
      position: 1
    doc: 'Source with path that needs to be moved'
  - id: outfile
    type: string
    inputBinding:
      position: 2
    doc: 'Target destination for the source'
  - id: force
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-f'
    doc: 'Do not prompt for confirmation before overwriting the destination path.'
  - id: verbose
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-v'
    doc: 'Cause mv to be verbose, showing files after they are moved.'
outputs:
  - id: out
    type: File
    outputBinding:
      glob: $(inputs.outfile)
label: mv
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ubuntu:18.04'
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
    'doap:name': mv
    'doap:revision': 18.04
