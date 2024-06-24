class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_collect_hs_metrics_4_1_8_0
baseCommand:
  - gatk
  - CollectHsMetrics
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
    doc: An aligned SAM or BAM file.  Required.
  - id: bait_intervals
    type: File
    inputBinding:
      position: 0
      prefix: '--BAIT_INTERVALS'
    doc: >-
      An interval list file that contains the locations of the baits used.  This
      argument must be specified at least once. Required.
  - id: target_intervals
    type: File
    inputBinding:
      position: 0
      prefix: '--TARGET_INTERVALS'
    doc: >-
      An interval list file that contains the locations of the targets.  This
      argument must be specified at least once. Required.
  - id: output_file_name
    type: string?
    doc: The output file to write the metrics to.  Required.
  - id: per_base_coverage
    type: string?
    doc: >-
      An optional file to output per base coverage information to. The per-base
      file contains one line per target base and can grow very large. It is not
      recommended for use with large target sets.  Default value: null.
  - id: per_target_coverage
    type: string?
    doc: >-
      An optional file to output per target coverage information to.  Default
      value: null.
  - id: theoretical_sensitivity_output
    type: string?
    inputBinding:
      position: 0
      prefix: '--THEORETICAL_SENSITIVITY_OUTPUT'
    doc: >-
      Output for Theoretical Sensitivity metrics where the allele fractions are
      provided by the ALLELE_FRACTION argument.  Default value: null.
  - id: allele_fraction
    type: float?
    inputBinding:
      position: 0
      prefix: '--ALLELE_FRACTION'
    doc: >-
      Allele fraction for which to calculate theoretical sensitivity.  This
      argument may be specified 0 or more times. Default value: [0.001, 0.005,
      0.01, 0.02, 0.05, 0.1, 0.2, 0.3, 0.5].
  - id: bait_set_name
    type: string?
    inputBinding:
      position: 0
      prefix: '--BAIT_SET_NAME'
    doc: >-
      Bait set name. If not provided it is inferred from the filename of the
      bait intervals. Default value: null.
  - id: clip_overlapping_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CLIP_OVERLAPPING_READS'
    doc: >-
      True if we are to clip overlapping reads, false otherwise.  Default value:
      true. Possible values: {true, false}
  - id: coverage_cap
    type: int?
    inputBinding:
      position: 0
      prefix: '--COVERAGE_CAP'
    doc: >-
      Parameter to set a max coverage limit for Theoretical Sensitivity
      calculations. Default is 200.  Default value: 200.
  - id: include_indels
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INCLUDE_INDELS'
    doc: >-
      If true count inserted bases as on target and deleted bases as covered by
      a read.  Default value: false. Possible values: {true, false}
  - id: minimum_base_quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--MINIMUM_BASE_QUALITY'
    doc: >-
      Minimum base quality for a base to contribute coverage.  Default value:
      20.
  - id: minimum_mapping_quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--MINIMUM_MAPPING_QUALITY'
    doc: >-
      Minimum mapping quality for a read to contribute coverage.  Default value:
      20.
  - id: near_distance
    type: int?
    inputBinding:
      position: 0
      prefix: '--NEAR_DISTANCE'
    doc: >-
      The maximum distance between a read and the nearest probe/bait/amplicon
      for the read to be considered 'near probe' and included in percent
      selected.  Default value: 250.
  - id: sample_size
    type: int?
    inputBinding:
      position: 0
      prefix: '--SAMPLE_SIZE'
    doc: >-
      Sample Size used for Theoretical Het Sensitivity sampling. Default is
      10000.  Default value: 10000.
  - id: reference
    type: File?
    inputBinding:
      position: 0
      prefix: '-R'
    doc: >-
      Reference sequence file. Note that while this argument is not required,
      without it only a small subset of the metrics will be calculated. Note
      also that if a reference sequence is provided, it must be accompanied by a
      sequence dictionary.  Default value: null.
    secondaryFiles:
      - ^.fasta.fai
      - ^.dict
  - id: metrics_acciumulation_level
    type: string?
    inputBinding:
      position: 0
      prefix: '--METRIC_ACCUMULATION_LEVEL'
    doc: >-
      The level(s) at which to accumulate metrics. Default value: [ALL_READS].
      This option can be set to 'null' to clear the default value. Possible
      values: {ALL_READS, SAMPLE, LIBRARY, READ_GROUP} This option may be
      specified 0 or more times. This option can be set to 'null' to clear the
      default list.
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 0
      prefix: '--VALIDATION_STRINGENCY'
    doc: >-
      Validation stringency for all SAM files read by this program.  Setting
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need
      to be decoded.  Default value: STRICT. This option can be set to 'null' to
      clear the default value. Possible values: {STRICT,LENIENT, SILENT}
  - id: create_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_INDEX'
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value: false. Possible values: {true, false}
  - id: create_md5_file
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_MD5_FILE'
    doc: >-
      Whether to create an MD5 digest for any BAM or FASTQ files created.
      Default value: false. Possible values: {true, false}
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: temporary_directory
    type: string?
    doc: 'Default value: null. This option may be specified 0 or more times.'
outputs:
  - id: gatk_collect_hs_metrics_txt
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_hs_metrics.txt')
            }
        }
  - id: gatk_collect_hs_metrics_per_base_coverage_txt
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.per_base_coverage){
                return inputs.per_base_coverage
            } else {
                return inputs.input.basename.replace(/.bam/, '_per_base_coverage.txt')
            }
        }
  - id: gatk_collect_hs_metrics_per_target_coverage_txt
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.per_target_coverage){
                return inputs.per_target_coverage
            } else {
                return inputs.input.basename.replace(/.bam/, '_per_target_coverage.txt')
            }
        }
label: GATK-CollectHsMetrics
arguments:
  - position: 0
    prefix: '--java-options'
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xmx24G"
        }
        else {
            return "-Xmx24G"
        }
      }
  - position: 0
    prefix: '--TMP_DIR'
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 0
    prefix: '-O'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_hs_metrics.txt')
          }
      }
  - position: 0
    prefix: '--PER_TARGET_COVERAGE'
    valueFrom: |-
      ${
          if(inputs.per_target_coverage){
              return inputs.per_target_coverage
          } else {
              return inputs.input.basename.replace(/.bam/, '_per_target_coverage.txt')
          }
      }
  - position: 0
    prefix: '--PER_BASE_COVERAGE'
    valueFrom: |-
      ${
          if(inputs.per_base_coverage){
              return inputs.per_base_coverage
          } else {
              return inputs.input.basename.replace(/.bam/, '_per_base_coverage.txt')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gatk:4.1.8.0'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charles Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charles Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': gatk4
    'doap:revision': 4.1.8.0
