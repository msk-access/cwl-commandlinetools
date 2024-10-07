class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - pv
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: inputVCF
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
      shellQuote: false
    doc: Input vardict vcf to be filtered
  - id: tsampleName
    type: string
    inputBinding:
      position: 1
      prefix: '--tsampleName'
      shellQuote: false
    doc: Name of the tumor Sample
  - id: alleledepth
    type: int
    inputBinding:
      position: 2
      prefix: '-ad'
      shellQuote: false
  - id: totalDepth
    type: int?
    inputBinding:
      position: 2
      prefix: '-dp'
      shellQuote: false
    doc: Tumor total depth threshold
  - id: tnRatio
    type: int?
    inputBinding:
      position: 2
      prefix: '-tnr'
      shellQuote: false
    doc: Tumor-Normal variant fraction ratio threshold
  - id: variantFraction
    type: float?
    inputBinding:
      position: 2
      prefix: '-vf'
      shellQuote: false
    doc: Tumor variant fraction threshold
  - id: minQual
    type: int?
    inputBinding:
      position: 2
      prefix: '-mq'
    doc: Minimum variant call quality
  - id: filterGermline
    type: boolean?
    inputBinding:
      position: 2
      prefix: '-fg'
    doc: Whether to remove calls without 'somatic' status
outputs:
  - id: txt
    type: File
    outputBinding:
      glob: '*_STDfilter.txt'
  - id: vcf_complex
    type: File
    outputBinding:
      glob: '*_STDfilter_complex_sorted.vcf'
  - id: vcf
    type: File
    outputBinding:
      glob: '*_STDfilter_sorted.vcf'
arguments:
  - vardict
  - case-control
  - filter
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 40000
    coresMin: 4
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/postprocessing_variant_calls:0.2.3'
'dct:contributor':
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
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': postprocessing_variant_calls
    'doap:revision': 0.0.1
