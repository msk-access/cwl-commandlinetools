class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: tabix
baseCommand:
  - tabix
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: preset
    type: string?
    inputBinding:
      position: 0
      prefix: '-p'
    doc: 'input file type can be gff, bed, sam or vcf'
  - id: input
    type: File
    inputBinding:
      position: 99
    doc: Input bgziped file
outputs:
  - id: tabixIndex
    type: File?
    outputBinding:
      glob: $(inputs.input.basename)
    secondaryFiles:
      - .tbi
label: tabix
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 2
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
    'doap:name': tabix
    'doap:revision': 1.15.1
