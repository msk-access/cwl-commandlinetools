class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_collect_insert_size_metrics_4_1_8_0
baseCommand:
  - gatk
  - CollectInsertSizeMetrics
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
    doc: Input file (bam or sam).  Required.
  - id: output_file_name
    type: string?
    doc: File to write the output to.  Required.
  - id: histogram_file
    type: string?
    doc: File to write insert size Histogram chart to.  Required.
  - id: deviations
    type: float?
    inputBinding:
      position: 0
      prefix: '--DEVIATIONS'
    doc: >-
      Generate mean, sd and plots by trimming the data down to MEDIAN +
      DEVIATIONS*MEDIAN_ABSOLUTE_DEVIATION. This is done because insert size
      data typically includes enough anomalous values from chimeras and other
      artifacts to make the mean and sd grossly misleading regarding the real
      distribution.  Default value: 10.0. This option can be set to 'null' to
      clear the default value.
  - id: histogram_width
    type: int?
    inputBinding:
      position: 0
      prefix: '--HISTOGRAM_WIDTH'
    doc: >-
      Explicitly sets the Histogram width, overriding automatic truncation of
      Histogram tail. Also, when calculating mean and standard deviation, only
      bins <= Histogram_WIDTH will be included.  Default value: null.
  - id: minimum_pct
    type: float?
    inputBinding:
      position: 0
      prefix: '--MINIMUM_PCT'
    doc: >-
      When generating the Histogram, discard any data categories (out of FR,
      TANDEM, RF) that have fewer than this percentage of overall reads. (Range:
      0 to 1).  Default value: 0.05. This option can be set to 'null' to clear
      the default value.
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
  - id: include_duplicates
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INCLUDE_DUPLICATES'
    doc: >-
      If true, also include reads marked as duplicates in the insert size
      histogram.  Default value: false. This option can be set to 'null' to
      clear the default value. Possible values: {true, false}
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
  - default: true
    id: assume_sorted
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ASSUME_SORTED'
    doc: >-
      If true (default), then the sort order in the header file will be
      ignored.  Default value: true. This option can be set to 'null' to clear
      the default value. Possible values: {true, false}
  - id: stop_after
    type: int?
    inputBinding:
      position: 0
      prefix: '--STOP_AFTER'
    doc: >-
      Stop after processing N reads, mainly for debugging. Default value: 0.
      This option can be set to 'null' to clear the default value.
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
  - id: use_jdk_deflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--USE_JDK_DEFLATER'
    doc: >-
      Use the JDK Deflater instead of the Intel Deflater for writing compressed
      output
  - id: use_jdk_inflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--USE_JDK_INFLATER'
    doc: >-
      Use the JDK Inflater instead of the Intel Inflater for reading compressed
      input
  - id: temporary_directory
    type: string?
    doc: 'Default value: null. This option may be specified 0 or more times.'
outputs:
  - id: gatk_collect_insert_size_metrics_txt
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_insert_size_metrics.txt')
            }
        }
  - id: gatk_collect_insert_size_metrics_histogram_pdf
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.histogram_file){
                return inputs.histogram_file
            } else {
                return inputs.input.basename.replace(/.bam/, '_histogram.pdf')
            }
        }
label: GATK-CollectInsertSizeMetrics
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
  - position: 2
    prefix: '-O'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_insert_size_metrics.txt')
          }
      }
  - position: 2
    prefix: '-H'
    valueFrom: |-
      ${
          if(inputs.histogram_file){
              return inputs.histogram_file
          } else {
              return inputs.input.basename.replace(/.bam/, '_histogram.pdf')
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
