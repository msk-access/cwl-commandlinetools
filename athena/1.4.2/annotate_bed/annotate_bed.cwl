class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: annotate_bed
baseCommand:
  - python
  - /app/bin/annotate_bed.py
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
    doc: 'worker thread number'
  - id: panel_bed
    type: File
    inputBinding:
      position: 0
      prefix: '-p'
    doc: >-
      Input panel bed file; must have ONLY the following 4 columns chromosome,
      start position, end position, gene/transcript
  - id: transcript_file
    type: File
    inputBinding:
      position: 0
      prefix: '-t'
    doc: >-
      Transcript annotation file, contains required gene and exon information.
      Must have ONLY the following 6 columns:

      chromosome, start, end, gene, transcript, exon
  - id: coverage_file
    type: File
    inputBinding:
      position: 0
      prefix: '-c'
    doc: Per base coverage file (output from mosdepth or similar)
  - id: chunk_size
    type: int?
    inputBinding:
      position: 999
      prefix: '-s'
  - id: output_name
    type: string?
    inputBinding:
      position: 960
      prefix: '-n'
    doc: >-
      (optional) Prefix for naming output file, if not given will use name from
      per base coverage file
outputs:
  - id: annotated_bed
    label: annotated_bed
    type: File
    outputBinding:
      glob: '*.bed'
label: annotate_bed
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/athena:1.4.2'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:charlk@mskcc.org'
        'foaf:name': Carmelina Charlambous
    'foaf:name': Memorial Sloan Kettering Cancer Center
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:buehlere@mskcc.org'
        'foaf:name': Eric Buehler
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:charlk@mskcc.org'
        'foaf:name': Carmelina Charlambous
    'foaf:name': Memorial Sloan Kettering Cancer Center
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:buehlere@mskcc.org'
        'foaf:name': Eric Buehler
    'foaf:name': Memorial Sloan Kettering Cancer Center
