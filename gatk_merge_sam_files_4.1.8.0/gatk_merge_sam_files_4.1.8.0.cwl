class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_merge_sam_files_4_1_8_0
baseCommand:
  - gatk
  - MergeSamFiles
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
    type:
      type: array
      items: File
      inputBinding:
        prefix: '-I'
    inputBinding:
      position: 1
    doc: >
      SAM or BAM input file  This argument must be specified at least once.
      Required.
  - id: output_file_name
    type: string?
    doc: SAM or BAM file to write merged result to  Required.
  - id: assume_sorted
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--ASSUME_SORTED'
    doc: >
      If true, assume that the input files are in the same sort order as the
      requested output

      sort order, even if their headers say otherwise.  Default value: false.
      Possible values:

      {true, false}
  - id: comment
    type: string?
    inputBinding:
      position: 1
      prefix: '--COMMENT'
    doc: >
      Comment(s) to include in the merged output files header.  This argument
      may be specified

      0 or more times. Default value: null.
  - id: create_index
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--CREATE_INDEX'
    doc: >
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value:

      false. Possible values: {true, false}
  - id: create_md5_file
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--CREATE_MD5_FILE'
    doc: >
      Whether to create an MD5 digest for any BAM or FASTQ files created.
      Default value:

      false. Possible values: {true, false}
  - id: intervals
    type: File?
    inputBinding:
      position: 1
      prefix: '--INTERVALS'
    doc: >
      An interval list file that contains the locations of the positions to
      merge. Assume bam

      are sorted and indexed. The resulting file will contain alignments that
      may overlap with

      genomic regions outside the requested region. Unmapped reads are
      discarded.  Default

      value: null.
  - id: merge_sequence_dictionaries
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--MERGE_SEQUENCE_DICTIONARIES'
    doc: >
      Merge the sequence dictionaries  Default value: false. Possible values:
      {true, false}
  - id: reference_sequence
    type: File?
    inputBinding:
      position: 1
      prefix: '--REFERENCE_SEQUENCE'
    doc: |
      Reference sequence file.  Default value: null.
  - id: sort_order
    type: string?
    inputBinding:
      position: 1
      prefix: '--SORT_ORDER'
    doc: >
      Sort order of output file  Default value: coordinate. Possible values:
      {unsorted,

      queryname, coordinate, duplicate, unknown}
  - id: use_threading
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--USE_THREADING'
    doc: >
      Option to create a background thread to encode, compress and write to disk
      the output

      file. The threaded version uses about 20% more CPU and decreases runtime
      by ~20% when

      writing out a compressed BAM file.  Default value: false. Possible values:
      {true, false}
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 1
      prefix: '--VALIDATION_STRINGENCY'
    doc: >
      Validation stringency for all SAM files read by this program.  Setting
      stringency to

      SILENT can improve performance when processing a BAM file in which
      variable-length data

      (read, qualities, tags) do not otherwise need to be decoded.  Default
      value: STRICT.

      Possible values: {STRICT, LENIENT, SILENT}
  - id: verbosity
    type: string?
    inputBinding:
      position: 1
      prefix: '--VERBOSITY'
    doc: >
      Control verbosity of logging.  Default value: INFO. Possible values:
      {ERROR, WARNING,

      INFO, DEBUG}
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
  - id: gatk_merge_sam_files_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return 'merged.bam'
            }
        }
label: GATK-MergeSamFiles
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
              return 'merged.bam'
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 48000
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
