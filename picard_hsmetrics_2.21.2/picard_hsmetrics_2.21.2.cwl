class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_hsmetrics_2_21_2
baseCommand:
  - java
inputs:
  - id: bait_intervals
    type: File
    inputBinding:
      position: 0
      prefix: BAIT_INTERVALS=
      separate: false
    doc: >-
      An interval list file that contains the locations of the baits used.
      Default value: null. This option must be specified at least 1 times.
  - id: bait_set_name
    type: string?
    inputBinding:
      position: 0
      prefix: BAIT_SET_NAME=
      separate: false
    doc: >-
      Bait set name. If not provided it is inferred from the filename of the
      bait intervals. Default value: null
  - id: minimum_mapping_quality
    type: int?
    inputBinding:
      position: 0
      prefix: MINIMUM_MAPPING_QUALITY=
      separate: false
    doc: >-
      Minimum mapping quality for a read to contribute coverage. Default value:
      20. This option can be set to 'null' to clear the default value.
  - id: minimum_base_quality
    type: int?
    inputBinding:
      position: 0
      prefix: MINIMUM_BASE_QUALITY=
      separate: false
    doc: >-
      Minimum base quality for a base to contribute coverage. Default value: 20.
      This option can be set to 'null' to clear the default value.
  - id: clip_overlapping_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: CLIP_OVERLAPPING_READS=true
      separate: false
    doc: >-
      True if we are to clip overlapping reads, false otherwise. Default value:
      true. This option can be set to 'null' to clear the default value.
      Possible values: {true, false}
  - id: target_intervals
    type: File?
    inputBinding:
      position: 0
      prefix: TARGET_INTERVALS=
      separate: false
    doc: >-
      An interval list file that contains the locations of the targets. Default
      value: null. This option must be specified at least 1 times.
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: INPUT=
      separate: false
    doc: An aligned SAM or BAM file. Required.
    secondaryFiles:
      - ^.bai
  - id: output_file_name
    type: string?
    inputBinding:
      position: 0
      prefix: OUTPUT=
      separate: false
    doc: The output file to write the metrics to. Required.
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
    doc: >-
      The level(s) at which to accumulate metrics. Default value: [ALL_READS].
      This option can be set to 'null' to clear the default value. Possible
      values: {ALL_READS, SAMPLE, LIBRARY, READ_GROUP} This option may be
      specified 0 or more times. This option can be set to 'null' to clear the
      default list.
  - id: per_target_coverage
    type: File?
    inputBinding:
      position: 0
      prefix: PER_TARGET_COVERAGE=
      separate: false
    doc: >-
      An optional file to output per target coverage information to. Default
      value: null.
  - id: per_base_coverage
    type: File?
    inputBinding:
      position: 0
      prefix: PER_BASE_COVERAGE=
      separate: false
    doc: >-
      An optional file to output per base coverage information to. The per-base
      file contains one line per target base and can grow very large. It is not
      recommended for use with large target sets. Default value: null.
  - id: near_distance
    type: int?
    inputBinding:
      position: 0
      prefix: NEAR_DISTANCE=
      separate: false
    doc: >-
      The maximum distance between a read and the nearest probe/bait/amplicon
      for the read to be considered 'near probe' and included in percent
      selected. Default value: 250. This option can be set to 'null' to clear
      the default value.
  - id: coverage_cap
    type: int?
    inputBinding:
      position: 0
      prefix: COVERAGE_CAP=
      separate: false
    doc: >-
      Parameter to set a max coverage limit for Theoretical Sensitivity
      calculations. Default is 200. Default value: 200. This option can be set
      to 'null' to clear the default value.
  - id: sample_size
    type: int?
    inputBinding:
      position: 0
      prefix: SAMPLE_SIZE=
      separate: false
    doc: >-
      Sample Size used for Theoretical Het Sensitivity sampling. Default is
      10000. Default value: 10000. This option can be set to 'null' to clear the
      default value.
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
label: picard_hsmetrics_2.21.2
arguments:
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/picard/picard.jar
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
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'broadinstitute/picard:2.21.2'
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
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': hsmetrics
    'doap:revision': 2.21.2
