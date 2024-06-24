class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: merge_fastq_0_1_7
baseCommand:
  - merge_fastq
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: fastq1
    type:
      type: array
      items: File
      inputBinding:
        prefix: '--fastq1'
    inputBinding:
      position: 0
    doc: >-
      Full path to gziped READ1 fastq files, can be specified multiple times for
      example: --fastq1 test_part1_R1.fastq.gz --fastq1 test_part2_R1.fastq.gz
      [required]
  - id: fastq2
    type:
      type: array
      items: File
      inputBinding:
        prefix: '--fastq2'
    inputBinding:
      position: 1
    doc: >-
      Full path to gziped READ2 fastq files, can be specified multiple times for
      example: --fastq1 test_part1_R2.fastq.gz --fastq1 test_part2_R2.fastq.gz
      [required]
  - id: output_path
    type: string?
    inputBinding:
      position: 2
      prefix: '--output-path'
    doc: 'Full path to write the output files (default: Current working directory)'
  - id: out_fastq1_name
    type: string?
    inputBinding:
      position: 2
      prefix: '--out-fastq1'
    doc: >-
      Name of the merged output READ1 fastq file(default:
      merged_fastq_R1.fastq.gz)
  - id: out_fastq2_name
    type: string?
    inputBinding:
      position: 2
      prefix: '--out-fastq2'
    doc: >-
      Name of the merged output READ2 fastq file(default:
      merged_fastq_R2.fastq.gz)
outputs:
  - id: merge_fastq_1
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.out_fastq1_name){
                return inputs.out_fastq1_name
            } else {
                return 'merged_fastq_R1.fastq.gz'
            }
        }
  - id: merge_fastq_2
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.out_fastq2_name){
                return inputs.out_fastq2_name
            } else {
                return 'merged_fastq_R2.fastq.gz'
            }
        }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/merge_fastq:0.1.7'
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
    'doap:name': merge_fastq
    'doap:revision': 0.1.7
