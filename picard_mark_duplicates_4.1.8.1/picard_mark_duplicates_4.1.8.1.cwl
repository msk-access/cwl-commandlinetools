class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_mark_duplicates_4.1.8.1
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
      prefix: -I
    doc: Input file (bam or sam).  Required.
  - id: output_file_name
    type: string?
    doc: Output file (bam or sam).
  - default: '$( inputs.input.basename.replace(/.bam/, ''_md.metrics'') )'
    id: duplication_metrics
    type: string
    inputBinding:
      position: 0
      prefix: -M
    doc: File to write duplication metrics to Required.
  - id: assume_sort_order
    type: string?
    inputBinding:
      position: 0
      prefix: -ASO
    doc: >-
      Optional sort order to output in. If not supplied OUTPUT is in the same
      order as INPUT.Default value: null. Possible values: {unsorted, queryname,
      coordinate}
  - id: tmp_dir
    type: string?
    inputBinding:
      position: 0
      prefix: --TMP_DIR
    doc: This option may be specified 0 or more times
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 0
      prefix: --VALIDATION_STRINGENCY
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
      prefix: --COMPRESSION_LEVEL
    doc: >-
      Compression level for all compressed files created (e.g. BAM and GELI).
      Default value:5. This option can be set to 'null' to clear the default
      value.
  - default: true
    id: create_bam_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: --CREATE_INDEX
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value:false. This option can be set to 'null' to clear the default
      value. Possible values:{true, false}
  - id: read_name_regex
    type: string?
    inputBinding:
      position: 0
      prefix: --READ_NAME_REGEX
    doc: >-
      MarkDuplicates can use the tile and cluster positions to estimate the rate of
      optical duplication in addition to the dominant source of duplication, PCR,
      to provide a more accurate estimation of library size. By default (with no
      READ_NAME_REGEX specified), MarkDuplicates will attempt to extract coordinates
      using a split on ':' (see Note below). Set READ_NAME_REGEX to 'null' to
      disable optical duplicate detection. Note that without optical duplicate
      counts, library size estimation will be less accurate. If the read name does
      not follow a standard Illumina colon-separation convention, but does contain
      tile and x,y coordinates, a regular expression can be specified to extract
      three variables: tile/region, x coordinate and y coordinate from a read name.
      The regular expression must contain three capture groups for the three variables,
      in order. It must match the entire read name. e.g. if field names were separated
      by semi-colon (';') this example regex could be specified
      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
      READ_NAME_REGEX is specified, the read name is split on ':'. For 5 element names,
      the 3rd, 4th and 5th elements are assumed to be tile, x and y values. For 7
      element names (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be
      tile, x and y values.
  - id: sorting_collection_size_ratio
    type: int?
    inputBinding:
      position: 0
      prefix: --SORTING_COLLECTION_SIZE_RATIO
    doc: >-
      This number, plus the maximum RAM available to the JVM, determine the memory
      footprint used by some of the sorting collections. If you are running out of memory, try reducing this number.
  - id: use_jdk_deflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: --USE_JDK_DEFLATER
    doc: >-
      Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  - id: use_jdk_inflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: --USE_JDK_INFLATER
    doc: >-
      Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  - id: duplicate_scoring_strategy
    type: string?
    inputBinding:
      position: 0
      prefix: --DUPLICATE_SCORING_STRATEGY
    doc: >-
      The scoring strategy for choosing the non-duplicate among candidates.
      Default value:SUM_OF_BASE_QUALITIES. This option can be set to 'null' to
      clear the default value.Possible values: {SUM_OF_BASE_QUALITIES,
      TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}
  - id: optical_duplicate_pixel_distance
    type: int?
    inputBinding:
      position: 0
      prefix: --OPTICAL_DUPLICATE_PIXEL_DISTANCE
    doc: >-
      The maximum offset between two duplicate clusters in order to consider
      them optical duplicates. The default is appropriate for unpatterned
      versions of the Illumina platform. For the patterned flowcell models, 2500
      is moreappropriate. For other platforms and models, users should
      experiment to find what works best.  Default value: 100. This option can
      be set to 'null' to clear the default value.
  - id: temporary_directory
    type: string?
    doc: 'Default value: null. This option may be specified 0 or more times.'
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
  - id: picard_mark_duplicates_metrics
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.duplication_metrics){
                return inputs.duplication_metrics
            } else {
                return inputs.input.basename.replace(/.bam/,'_md.metrics')
            }
        }
label: picard_mark_duplicates_4.1.8.1
arguments:
  - position: 0
    valueFrom: "${
      if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
              return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"
          }
          else {
              return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\"
          }
      }
      else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
              return \"-Xmx\" + (inputs.memory_per_job/1000).toString() + \"G\"
          }
          else {
              return \"-Xmx\" + Math.floor((inputs.memory_per_job/1000)).toString() + \"G\"
          }
      }
      else if(!inputs.memory_per_job && inputs.memory_overhead){
          return \"-Xmx24G\"
      }
      else {
        return \"-Xmx24G\"
      }
    }"
  - position: 0
    prefix: '-jar'
    valueFrom: /gatk/gatk-package-4.1.8.1-local.jar
  - position: 0
    valueFrom: MarkDuplicates
  - position: 0
    prefix: -O
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/,'_md.bam')
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
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gatk:4.1.8.1'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
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
    'doap:revision': 4.1.8.1
