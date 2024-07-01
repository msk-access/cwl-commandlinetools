class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_collectmultiplemetrics_2_8_1
baseCommand:
  - java
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
      prefix: I=
      separate: false
    doc: Input file (bam or sam).  Required.
  - id: output_file_name
    type: string?
    doc: Output file (bam or sam).
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 0
      prefix: VALIDATION_STRINGENCY=
      separate: false
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
      prefix: AS=true
      separate: false
  - id: bam_compression_level
    type: int?
    inputBinding:
      position: 0
      prefix: COMPRESSION_LEVEL=
      separate: false
    doc: >-
      Compression level for all compressed files created (e.g. BAM and GELI).
      Default value:5. This option can be set to 'null' to clear the default
      value.
  - default: true
    id: create_bam_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: CREATE_INDEX=true
      separate: false
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value:false. This option can be set to 'null' to clear the default
      value. Possible values:{true, false}
  - id: stop_after
    type: int?
    inputBinding:
      position: 0
      prefix: STOP_AFTER=
      separate: false
    doc: >-
      Stop after processing N reads, mainly for debugging. Default value: 0.
      This option can be set to 'null' to clear the default value.
  - id: metric_accumulation_level
    type: string?
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
  - id: file_extension
    type: string?
    inputBinding:
      position: 0
      prefix: FILE_EXTENSION=
      separate: false
    doc: >-
      Append the given file extension to all metric file names (ex.
      OUTPUT.insert_size_metrics.EXT). None if null Default value: null.
  - id: program_list
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: PROGRAM=
      separate: false
    doc: >-
      Set of metrics programs to apply during the pass through the SAM file.
      Default value: [CollectAlignmentSummaryMetrics,
      CollectBaseDistributionByCycle, CollectInsertSizeMetrics,
      MeanQualityByCycle, QualityScoreDistribution]. This option can be set to
      'null' to clear the default value. Possible values:
      {CollectAlignmentSummaryMetrics, CollectInsertSizeMetrics,
      QualityScoreDistribution, MeanQualityByCycle,
      CollectBaseDistributionByCycle, CollectGcBiasMetrics, RnaSeqMetrics,
      CollectSequencingArtifactMetrics, CollectQualityYieldMetrics} This option
      may be specified 0 or more times. This option can be set to 'null' to
      clear the default list.
  - id: intervals_file
    type: File?
    inputBinding:
      position: 0
      prefix: INTERVALS=
      separate: false
    doc: >-
      An optional list of intervals to restrict analysis to. Only pertains to
      some of the PROGRAMs. Programs whose stand-alone CLP does not have an
      INTERVALS argument will silently ignore this argument. Default value:
      null.
  - id: dbsnp_file
    type: File?
    inputBinding:
      position: 0
      prefix: DB_SNP=
      separate: false
    doc: >-
      VCF format dbSNP file, used to exclude regions around known polymorphisms
      from analysis by some PROGRAMs; PROGRAMs whose CLP doesn't allow for this
      argument will quietly ignore it. Default value: null.
  - id: include_unpaired
    type: boolean?
    inputBinding:
      position: 0
      prefix: INCLUDE_UNPAIRED=true
      separate: false
    doc: >-
      Include unpaired reads in CollectSequencingArtifactMetrics. If set to true
      then all paired reads will be included as well - MINIMUM_INSERT_SIZE and
      MAXIMUM_INSERT_SIZE will be ignored in CollectSequencingArtifactMetrics.
      Default value: false. This option can be set to 'null' to clear the
      default value. Possible values: {true, false}
outputs:
  - id: picard_collectmultiplemetrics_alignment_summary_metrics
    type: File?
    outputBinding:
      glob: '*alignment_summary_metrics'
  - id: picard_collectmultiplemetrics_bait_bias_detail_metrics
    type: File?
    outputBinding:
      glob: '*bait_bias_detail_metrics'
  - id: picard_collectmultiplemetrics_bait_bias_summary_metrics
    type: File?
    outputBinding:
      glob: '*bait_bias_summary_metrics'
  - id: picard_collectmultiplemetrics_base_distribution_by_cycle_metrics
    type: File?
    outputBinding:
      glob: '*base_distribution_by_cycle_metrics'
  - id: picard_collectmultiplemetrics_base_distribution_by_cycle_pdf
    type: File?
    outputBinding:
      glob: '*base_distribution_by_cycle.pdf'
  - id: picard_collectmultiplemetrics_error_summary_metrics
    type: File?
    outputBinding:
      glob: '*error_summary_metrics'
  - id: picard_collectmultiplemetrics_gc_bias_detail_metrics
    type: File?
    outputBinding:
      glob: '*gc_bias.detail_metrics'
  - id: picard_collectmultiplemetrics_gc_bias_pdf
    type: File?
    outputBinding:
      glob: '*gc_bias.pdf'
  - id: picard_collectmultiplemetrics_gc_bias_summary_metrics
    type: File?
    outputBinding:
      glob: '*gc_bias.summary_metrics'
  - id: picard_collectmultiplemetrics_insert_size_histogram_pdf
    type: File?
    outputBinding:
      glob: '*insert_size_histogram.pdf'
  - id: picard_collectmultiplemetrics_insert_size_metrics
    type: File?
    outputBinding:
      glob: '*insert_size_metrics'
  - id: picard_collectmultiplemetrics_pre_adapter_detail_metrics
    type: File?
    outputBinding:
      glob: '*pre_adapter_detail_metrics'
  - id: picard_collectmultiplemetrics_pre_adapter_summary_metrics
    type: File?
    outputBinding:
      glob: '*pre_adapter_summary_metrics'
  - id: picard_collectmultiplemetrics_quality_by_cycle_metrics
    type: File?
    outputBinding:
      glob: '*quality_by_cycle_metrics'
  - id: picard_collectmultiplemetrics_quality_by_cycle_pdf
    type: File?
    outputBinding:
      glob: '*quality_by_cycle.pdf'
  - id: picard_collectmultiplemetrics_quality_distribution_metrics
    type: File?
    outputBinding:
      glob: '*quality_distribution_metrics'
  - id: picard_collectmultiplemetrics_quality_distribution_pdf
    type: File?
    outputBinding:
      glob: '*quality_distribution.pdf'
label: picard_collectmultiplemetrices_2.8.1
arguments:
  - position: 0
    prefix: ''
    separate: false
    valueFrom: "${\n  if(inputs.memory_per_job && inputs.memory_overhead) {\n   \n    if(inputs.memory_per_job % 1000 == 0) {\n    \t\n      return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"\n    }\n    else {\n      \n      return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\" \n    }\n  }\n  else if (inputs.memory_per_job && !inputs.memory_overhead){\n    \n    if(inputs.memory_per_job % 1000 == 0) {\n    \t\n      return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"\n    }\n    else {\n      \n      return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\" \n    }\n  }\n  else if(!inputs.memory_per_job && inputs.memory_overhead){\n    \n    return \"-Xmx15G\"\n  }\n  else {\n    \n  \treturn \"-Xmx15G\"\n  }\n}"
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/local/bin/picard.jar
  - position: 0
    prefix: ''
    separate: false
    valueFrom: CollectMultipleMetrics
  - position: 0
    prefix: O=
    separate: false
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/,'_multiple_metrics')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'mskaccess/picard:0.6.3'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': picard
    'doap:revision': 2.8.1
