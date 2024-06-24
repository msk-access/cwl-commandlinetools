class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_revert_sam_4_1_8_0
baseCommand:
  - gatk
  - RevertSam
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
    doc: An aligned SAM or BAM file.  Required.
  - id: output
    type: string?
    doc: >-
      The output SAM/BAM file to create, or an output directory if OUTPUT_BY_READGROUP is true. Required.  Cannot be used in conjunction with argument(s) OUTPUT_MAP (OM)
  - id: output_map
    type: string?
    doc: >-
      Tab separated file with two columns, READ_GROUP_ID and OUTPUT, providing file mapping only used if OUTPUT_BY_READGROUP is true.  Required.  Cannot be used in conjunction with argument(s) OUTPUT (O)
  - id: attribute_to_clear
    type:
      - "null"
      - type: array
        items: string
        inputBinding:
          position: 0
          prefix: '--ATTRIBUTE_TO_CLEAR'
    doc: >-
      When removing alignment information, the set of optional tags to remove.  This may be specified 0 or more times. Default value: [NM, UQ, PG, MD, MQ, SA, MC, AS].
  - id: max_discard_fraction
    type: float?
    inputBinding:
      position: 0
      prefix: '--MAX_DISCARD_FRACTION'
    doc: >-
      If SANITIZE=true and higher than MAX_DISCARD_FRACTION reads are discarded due to
      sanitization thenthe program will exit with an Exception instead of exiting cleanly.
      Output BAM will still be valid.  Default value: 0.01.
  - id: library_name
    type: string?
    inputBinding:
      position: 0
      prefix: '--LIBRARY_NAME'
    doc: >-
      The library name to use in the reverted output file.  This will override the existing
      sample alias in the file and is used only if all the read groups in the input file have
      the same library name.  Default value: null.
  - id: max_records_in_ram
    type: int?
    inputBinding:
      position: 0
      prefix: '--MAX_RECORDS_IN_RAM'
    doc: >-
      When writing files that need to be sorted, this will specify the number of records stored
      in RAM before spilling to disk. Increasing this number reduces the number of file handles
      needed to sort the file, and increases the amount of RAM needed.  Default value: 500000.
  - id: output_by_readgroup
    type: string?
    default: 'false'
    inputBinding:
      position: 0
      prefix: '--OUTPUT_BY_READGROUP'
    doc: >-
      When true, outputs each read group in a separate file.  Default value: false. Possible values: {true, false}
  - id: output_by_readgroup_file_format
    type: string?
    inputBinding:
      position: 0
      prefix: '--OUTPUT_BY_READGROUP_FILE_FORMAT'
    doc: >-
      When using OUTPUT_BY_READGROUP, the output file format can be set to a certain format.
      Default value: dynamic. sam (Generate SAM files.)
      bam (Generate BAM files.)
      cram (Generate CRAM files.)
      dynamic (Generate files based on the extention of INPUT.)
  - id: remove_alignment_information
    type: string?
    default: 'true'
    inputBinding:
      position: 0
      prefix: '--REMOVE_ALIGNMENT_INFORMATION'
    doc: >-
      Remove all alignment information from the file.  Default value: true. Possible values: {true, false}
  - id: remove_duplicate_information
    type: string?
    default: 'true'
    inputBinding:
      position: 1
      prefix: '--REMOVE_DUPLICATE_INFORMATION'
    doc: |
      Remove duplicate read flags from all reads.  Note that if this is false and
      REMOVE_ALIGNMENT_INFORMATION==true,  the output may have the unusual but sometimes
      desirable trait of having unmapped reads that are marked as duplicates.  Default value:
      true. Possible values: {true, false}
  - id: restore_hardclips
    type: string?
    default: 'true'
    inputBinding:
      position: 0
      prefix: '--RESTORE_HARDCLIPS'
    doc: >-
      When true, restores reads and qualities of records with hard-clips containing XB and XQ tags.  Default value: true. Possible values: {true, false}
  - id: restore_original_qualities
    type: string?
    default: 'true'
    inputBinding:
      position: 1
      prefix: '--RESTORE_ORIGINAL_QUALITIES'
    doc: |
      True to restore original qualities from the OQ field to the QUAL field if available. Default value: true. Possible values: {true, false}
  - id: sample_alias
    type: string?
    inputBinding:
      position: 1
      prefix: '--SAMPLE_ALIAS'
    doc: |
      The sample alias to use in the reverted output file.  This will override the existing
      sample alias in the file and is used only if all the read groups in the input file have
      the same sample alias.  Default value: null.
  - id: sanitize
    type: string?
    default: 'false'
    inputBinding:
      position: 1
      prefix: '--SANITIZE'
    doc: |
      WARNING: This option is potentially destructive. If enabled will discard reads in order to
      produce a consistent output BAM. Reads discarded include (but are not limited to) paired
      reads with missing mates, duplicated records, records with mismatches in length of bases
      and qualities. This option can only be enabled if the output sort order is queryname and
      will always cause sorting to occur.  Default value: false. Possible values: {true, false}
  - id: sort_order
    type: string?
    inputBinding:
      position: 1
      prefix: '--SORT_ORDER'
    doc: |
      The sort order to create the reverted output file with.  Default value: queryname. Possible values: {unsorted, queryname, coordinate, duplicate, unknown}
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
  - id: compression_level
    type: int?
    inputBinding:
      position: 0
      prefix: '--COMPRESSION_LEVEL'
    doc: >-
      Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 2.
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
  - id: gatk_revert_sam_output
    type: File
    outputBinding:
      glob: |-
        ${
          if(inputs.output){
              return inputs.output
          } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_revertsam.bam')
          }
        }
    secondaryFiles:
      - ^.bai
  - id: gatk_revert_sam_output_map
    type: File?
    outputBinding:
      glob: |-
        ${
          if(inputs.output_map){
              return inputs.output_map
          } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_revertsam.tsv')
          }
        }
label: GATK-RevertSam
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
          if(inputs.output){
              return inputs.output;
          } else if (inputs.output_map) {
            return null;
          } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_revertsam.bam');
          }
      }
  - position: 0
    prefix: '-OM'
    valueFrom: |-
      ${
          if(inputs.output_map){
              return inputs.output_map;
          } else {
              return null;
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
