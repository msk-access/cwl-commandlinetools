class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_mark_duplicates_2_9_0
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
  - default: '$( inputs.input.basename.replace(/.bam/, ''_md.metrics'') )'
    id: duplication_metrics
    type: string
    inputBinding:
      position: 0
      prefix: M=
      separate: false
      valueFrom: '$( inputs.input.basename.replace(/.bam/, ''_md.metrics'') )'
    doc: File to write duplication metrics to Required.
  - id: sort_order
    type: string?
    inputBinding:
      position: 0
      prefix: SO=
      separate: false
    doc: >-
      Optional sort order to output in. If not supplied OUTPUT is in the same
      order as INPUT.Default value: null. Possible values: {unsorted, queryname,
      coordinate}
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
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value:false. This option can be set to 'null' to clear the default
      value. Possible values:{true, false}
  - default: true
    id: assume_sorted
    type: boolean?
    inputBinding:
      position: 0
      prefix: AS=true
  - id: duplicate_scoring_strategy
    type: string?
    inputBinding:
      position: 0
      prefix: DUPLICATE_SCORING_STRATEGY=
      separate: false
    doc: >-
      The scoring strategy for choosing the non-duplicate among candidates.
      Default value:SUM_OF_BASE_QUALITIES. This option can be set to 'null' to
      clear the default value.Possible values: {SUM_OF_BASE_QUALITIES,
      TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}
  - id: optical_duplicate_pixel_distance
    type: int?
    inputBinding:
      position: 0
      prefix: OPTICAL_DUPLICATE_PIXEL_DISTANCE=
    doc: >-
      The maximum offset between two duplicate clusters in order to consider
      them optical duplicates. The default is appropriate for unpatterned
      versions of the Illumina platform. For the patterned flowcell models, 2500
      is moreappropriate. For other platforms and models, users should
      experiment to find what works best.  Default value: 100. This option can
      be set to 'null' to clear the default value.
  - id: read_name_regex
    type: string?
    inputBinding:
      position: 0
      prefix: READ_NAME_REGEX=
      separate: false
outputs:
  - id: picard_mark_duplicates_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/,'_md.bam')
            }
        }
    secondaryFiles:
      - ^.bai
      - ^.metrics
label: picard_mark_duplicates_2.9.0
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
             return "-Xmx24G"
         }
         else {
             return "-Xmx24G"
         }
      }
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/local/bin/picard.jar
  - position: 0
    valueFrom: MarkDuplicates
  - position: 0
    prefix: O=
    separate: false
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/,'_md.bam')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'mskaccess/picard_2.9.0:0.1.0'
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
    'doap:revision': 2.9.0
