class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_sam_to_fastq_4_1_8_0
baseCommand:
  - gatk
  - SamToFastq
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: fastq
    type: string?
    doc: >-
      Output FASTQ file (single-end fastq or, if paired, first end of the pair
      FASTQ)
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--INPUT'
    doc: Input SAM/BAM file to extract reads from  Required.
  - id: clipping_action
    type: string?
    inputBinding:
      position: 0
      prefix: '--CLIPPING_ACTION'
    doc: >-
      The action that should be taken with clipped reads: 'X' means the reads
      and qualities should be trimmed at the clipped position; 'N' means the
      bases should be changed to Ns in the clipped region; and any integer means
      that the base qualities should be set to that value in the clipped
      region.  Default value: null.
  - id: clipping_attribute
    type: string?
    inputBinding:
      position: 0
      prefix: '--CLIPPING_ATTRIBUTE'
    doc: >-
      The attribute that stores the position at which the SAM record should be
      clipped  Default value: null.
  - id: clipping_min_length
    type: int?
    inputBinding:
      position: 0
      prefix: '--CLIPPING_MIN_LENGTH'
    doc: >-
      When performing clipping with the CLIPPING_ATTRIBUTE and CLIPPING_ACTION
      parameters, ensure that the resulting reads after clipping are at least
      CLIPPING_MIN_LENGTH bases long. If the original read is shorter than
      CLIPPING_MIN_LENGTH then the original read length will be maintained.
      Default value: 0.
  - id: compress_outputs_per_rg
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--COMPRESS_OUTPUTS_PER_RG'
    doc: >-
      Compress output FASTQ files per read group using gzip and append a .gz
      extension to the file names.  Default value: false. Possible values:
      {true, false}  Cannot be used in conjunction with argument(s) FASTQ (F)
      SECOND_END_FASTQ (F2) UNPAIRED_FASTQ (FU)
  - id: compression_level
    type: int?
    inputBinding:
      position: 0
      prefix: '--COMPRESSION_LEVEL'
    doc: >-
      Compression level for all compressed files created (e.g. BAM and VCF).
      Default value: 2.
  - id: create_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_INDEX'
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value: false. Possible values: {true, false}
  - id: include_non_pf_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INCLUDE_NON_PF_READS'
    doc: >-
      Include non-PF reads from the SAM file into the output FASTQ files. PF
      means 'passes filtering'. Reads whose 'not passing quality controls' flag
      is set are non-PF reads. See GATK Dictionary for more info.  Default
      value: false. Possible values: {true, false}
  - id: include_non_primary_alignments
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INCLUDE_NON_PRIMARY_ALIGNMENTS'
    doc: >-
      If true, include non-primary alignments in the output.  Support of
      non-primary alignments in SamToFastq is not comprehensive, so there may be
      exceptions if this is set to true and there are paired reads with
      non-primary alignments.  Default value: false. Possible values: {true,
      false}
  - id: interleave
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INTERLEAVE'
    doc: >-
      Will generate an interleaved fastq if paired, each line will have /1 or /2
      to describe which end it came from  Default value: false. Possible values:
      {true, false}
  - default: 50000
    id: max_records_in_ram
    type: int?
    inputBinding:
      position: 0
      prefix: '--MAX_RECORDS_IN_RAM'
    doc: >-
      When writing files that need to be sorted, this will specify the number of
      records stored in RAM before spilling to disk. Increasing this number
      reduces the number of file handles needed to sort the file, and increases
      the amount of RAM needed.  Default value: 500000.
  - id: output_dir
    type: string?
    inputBinding:
      position: 0
      prefix: '--OUTPUT_DIR'
    doc: >-
      Directory in which to output the FASTQ file(s). Used only when
      OUTPUT_PER_RG is true. Default value: null. Cannot be used in conjunction
      with argument(s) FASTQ (F).
  - id: create_md5_file
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_MD5_FILE'
    doc: >-
      Whether to create an MD5 digest for any BAM or FASTQ files created.
      Default value: false. Possible values: {true, false}.
  - id: output_per_rg
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--OUTPUT_PER_RG'
    doc: >-
      Output a FASTQ file per read group (two FASTQ files per read group if the
      group is paired).  Default value: false. Possible values: {true, false}
      Cannot be used in conjunction with argument(s) FASTQ (F) SECOND_END_FASTQ
      (F2) UNPAIRED_FASTQ (FU)
  - id: quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--QUALITY'
    doc: >-
      End-trim reads using the phred/bwa quality trimming algorithm and this
      quality. Default value: null.
  - id: re_reverse
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--RE_REVERSE'
    doc: >-
      Re-reverse bases and qualities of reads with negative strand flag set
      before writing them to FASTQ  Default value: true. Possible values: {true,
      false}
  - id: read1_max_bases_to_write
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ1_MAX_BASES_TO_WRITE'
    doc: >-
      The maximum number of bases to write from read 1 after trimming. If there
      are fewer than this many bases left after trimming, all will be written.
      If this value is null then all bases left after trimming will be written.
      Default value: null.
  - id: read1_trim
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ1_TRIM'
    doc: >-
      The number of bases to trim from the beginning of read 1.  Default value:
      0.
  - id: read2_max_bases_to_write
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ2_MAX_BASES_TO_WRITE'
    doc: >-
      The maximum number of bases to write from read 2 after trimming. If there
      are fewer than this many bases left after trimming, all will be written.
      If this value is null then all bases left after trimming will be written.
      Default value: null.
  - id: read2_trim
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ2_TRIM'
    doc: >-
      The number of bases to trim from the beginning of read 2.  Default value:
      0.
  - id: reference_sequence
    type: File?
    inputBinding:
      position: 0
      prefix: '--REFERENCE_SEQUENCE'
    doc: 'Reference sequence file. Default value: null.'
  - id: rg_tag
    type: string?
    inputBinding:
      position: 0
      prefix: '--RG_TAG'
    doc: >-
      The read group tag (PU or ID) to be used to output a FASTQ file per read
      group.  Default value: PU.
  - id: second_end_fastq
    type: string?
    inputBinding:
      position: 0
      prefix: '--SECOND_END_FASTQ'
    doc: >-
      Output FASTQ file (if paired, second end of the pair FASTQ).  Default
      value: null.  Cannot be used in conjunction with argument(s) OUTPUT_PER_RG
      (OPRG) COMPRESS_OUTPUTS_PER_RG (GZOPRG)
  - id: unpaired_fastq
    type: string?
    inputBinding:
      position: 0
      prefix: '--UNPAIRED_FASTQ'
    doc: >-
      Output FASTQ file for unpaired reads; may only be provided in paired-FASTQ
      mode  Default value: null.  Cannot be used in conjunction with argument(s)
      OUTPUT_PER_RG (OPRG) COMPRESS_OUTPUTS_PER_RG (GZOPRG)
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 0
      prefix: '--VALIDATION_STRINGENCY'
    doc: >-
      Validation stringency for all SAM files read by this program.  Setting
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need
      to be decoded.  Default value: STRICT. Possible values: {STRICT, LENIENT,
      SILENT}
  - id: temporary_directory
    type: string?
    doc: 'Default value: null. This option may be specified 0 or more times.'
outputs:
  - id: gatk_sam_to_fastq_fastq
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.fastq){
              return inputs.fastq
            } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_R1.fastq')
            }
        }
  - id: gatk_sam_to_fastq_unpaired_fastq
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.unpaired_fastq){
                return inputs.unpaired_fastq
            } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_unpaired.fastq')
            }
        }
  - id: gatk_sam_to_fastq_second_end_fastq
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.second_end_fastq){
                return inputs.second_end_fastq
            } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_R2.fastq')
            }
        }
label: GATK-SamToFastq
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
    prefix: '--FASTQ'
    valueFrom: |-
      ${
          if(inputs.fastq){
              return inputs.fastq
          } else {
              return inputs.input.basename.replace(/.bam|.sam/, '_R1.fastq')
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
