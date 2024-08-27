class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_hsmetrics_2_8_1
baseCommand:
  - java
inputs:
  - id: bait_intervals
    type: File
    inputBinding:
      position: 0
      prefix: BAIT_INTERVALS=
      separate: false
  - id: bait_set_name
    type: string?
    inputBinding:
      position: 0
      prefix: BAIT_SET_NAME=
      separate: false
  - id: minimum_mapping_quality
    type: int?
    inputBinding:
      position: 0
      prefix: MINIMUM_MAPPING_QUALITY=
      separate: false
  - id: minimum_base_quality
    type: int?
    inputBinding:
      position: 0
      prefix: MINIMUM_BASE_QUALITY=
      separate: false
  - id: clip_overlapping_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: CLIP_OVERLAPPING_READS=true
      separate: false
  - id: target_intervals
    type: File?
    inputBinding:
      position: 0
      prefix: TARGET_INTERVALS=
      separate: false
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: INPUT=
      separate: false
  - id: output_file_name
    type: string?
    inputBinding:
      position: 0
      prefix: OUTPUT=
      separate: false
  - id: metric_accumulation_level
    type:
      - 'null'
      - type: enum
        symbols:
          - ALL_READS
          - SAMPLE
          - LIBRARY
          - READ_GROUP
        name: metric_accumulation_level
    inputBinding:
      position: 0
      prefix: METRIC_ACCUMULATION_LEVEL=
      separate: false
  - id: per_target_coverage
    type: File?
    inputBinding:
      position: 0
      prefix: PER_TARGET_COVERAGE=
      separate: false
  - id: per_base_coverage
    type: File?
    inputBinding:
      position: 0
      prefix: PER_BASE_COVERAGE=
      separate: false
  - id: near_distance
    type: int?
    inputBinding:
      position: 0
      prefix: NEAR_DISTANCE=
      separate: false
  - id: coverage_cap
    type: int?
    inputBinding:
      position: 0
      prefix: COVERAGE_CAP=
      separate: false
  - id: sample_size
    type: int?
    inputBinding:
      position: 0
      prefix: SAMPLE_SIZE=
      separate: false
outputs:
  - id: picard_hsmetrics_txt
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/,'.hsmetrics')
            }
        }
label: picard_hsmetrics_2.8.1
arguments:
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/local/bin/picard.jar
  - position: 0
    valueFrom: CollectHsMetrics
  - position: 0
    prefix: OUTPUT=
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/,'.hsmetrics')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'mskaccess/picard:0.6.2'
  - class: InlineJavascriptRequirement

'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': hsmetrics
    'doap:revision': 2.8.1
