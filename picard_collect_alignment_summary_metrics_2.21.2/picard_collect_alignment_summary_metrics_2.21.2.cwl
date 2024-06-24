class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_collect_alignment_summary_metrics_2_8_1
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
  - id: metrics_acciumulation_level
    type: string?
    inputBinding:
      position: 0
      prefix: LEVEL=
      separate: false
    doc: >-
      The level(s) at which to accumulate metrics. Default value: [ALL_READS].
      This option can be set to 'null' to clear the default value. Possible
      values: {ALL_READS, SAMPLE, LIBRARY, READ_GROUP} This option may be
      specified 0 or more times. This option can be set to 'null' to clear the
      default list.
  - id: max_insert_size
    type: int?
    inputBinding:
      position: 0
      prefix: MAX_INSERT_SIZE=
      separate: false
    doc: >-
      Paired-end reads above this insert size will be considered chimeric along
      with inter-chromosomal pairs. Default value: 100000. This option can be
      set to 'null' to clear the default value.
  - id: tmp_dir
    type: string?
    inputBinding:
      position: 0
      prefix: TMP_DIR=
      separate: false
    doc: This option may be specified 0 or more times
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
  - id: reference_sequence
    type: File
    inputBinding:
      position: 0
      prefix: R=
      separate: false
    doc: >-
      Reference sequence file. Note that while this argument isn't required,
      without it only a small subset of the metrics will be calculated. Note
      also that if a reference sequence is provided, it must be accompanied by a
      sequence dictionary. Default value: null.
    secondaryFiles:
      - ^.dict
  - id: stop_after
    type: int?
    inputBinding:
      position: 0
      prefix: STOP_AFTER=
    doc: >-
      Stop after processing N reads, mainly for debugging. Default value: 0.
      This option can be set to 'null' to clear the default value.
outputs:
  - id: picard_collect_alignment_summary_metrics_txt
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/,'_alignment_metrics.txt')
            }
        }
label: picard_collect_alignment_summary_metrics_2.8.1
arguments:
  - position: 0
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
             return "-Xmx16G"
         }
         else {
             return "-Xmx16G"
         }

       }
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/local/bin/picard.jar
  - position: 0
    valueFrom: CollectAlignmentSummaryMetrics
  - position: 0
    prefix: O=
    separate: false
    valueFrom: |-
      ${
        if(inputs.output_file_name){
            return inputs.output_file_name
        } else {
            return inputs.input.basename.replace(/.bam/,'_alignment_metrics.txt')
        }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'mskaccess/picard:0.6.3'
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
    'doap:name': picard
    'doap:revision': 2.8.1
