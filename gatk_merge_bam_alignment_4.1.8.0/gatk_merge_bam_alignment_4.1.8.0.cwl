class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_merge_bam_alignment_4_1_8_0
baseCommand:
  - gatk
  - MergeBamAlignment
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: unmapped_bam
    type: File
    inputBinding:
      position: 0
      prefix: '--UNMAPPED_BAM'
    doc: >
      Original SAM or BAM file of unmapped reads, which must be in queryname
      order.  Reads MUST

      be unmapped. Required.
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--REFERENCE_SEQUENCE'
    doc: |
      Reference sequence file.  Required.
    secondaryFiles:
      - ^.dict
  - id: output_file_name
    type: string?
    doc: |
      Merged SAM or BAM file to write to.  Required.
  - id: add_mate_cigar
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ADD_MATE_CIGAR'
    doc: >
      Adds the mate CIGAR tag (MC) if true, does not if false.  Default value:
      true. Possible

      values: {true, false}
  - id: add_pg_tag_to_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ADD_PG_TAG_TO_READS'
    doc: >
      Add PG tag to each read in a SAM or BAM  Default value: true. Possible
      values: {true,

      false}
  - id: aligned_bam
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '--ALIGNED_BAM'
    inputBinding:
      position: 1
    doc: >
      SAM or BAM file(s) with alignment data.  This argument may be specified 0
      or more times.

      Default value: null.  Cannot be used in conjunction with argument(s)
      READ1_ALIGNED_BAM

      (R1_ALIGNED) READ2_ALIGNED_BAM (R2_ALIGNED)
  - id: aligned_reads_only
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ALIGNED_READS_ONLY'
    doc: >
      Whether to output only aligned reads. Default value: false. Possible
      values: {true,

      false}
  - id: aligner_proper_pair_flags
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ALIGNER_PROPER_PAIR_FLAGS'
    doc: >
      Use the aligners idea of what a proper pair is rather than computing in
      this program.

      Default value: false. Possible values: {true, false}
  - id: attributes_to_remove
    type: string?
    inputBinding:
      position: 0
      prefix: '--ATTRIBUTES_TO_REMOVE'
    doc: >
      Attributes from the alignment record that should be removed when merging.
      This overrides

      ATTRIBUTES_TO_RETAIN if they share common tags.  This argument may be
      specified 0 or more

      times. Default value: null.
  - id: attributes_to_retain
    type: string?
    inputBinding:
      position: 0
      prefix: '--ATTRIBUTES_TO_RETAIN'
    doc: >
      Reserved alignment attributes (tags starting with X, Y, or Z) that should
      be brought over

      from the alignment data when merging.  This argument may be specified 0 or
      more times.

      Default value: null.
  - id: attributes_to_reverse
    type: string?
    inputBinding:
      position: 0
      prefix: '--ATTRIBUTES_TO_REVERSE'
    doc: >
      Attributes on negative strand reads that need to be reversed.  This
      argument may be

      specified 0 or more times. Default value: [OQ, U2].
  - id: attributes_to_reverse_complement
    type: string?
    inputBinding:
      position: 0
      prefix: '--ATTRIBUTES_TO_REVERSE_COMPLEMENT'
    doc: >
      Attributes on negative strand reads that need to be reverse complemented.
      This argument

      may be specified 0 or more times. Default value: [E2, SQ].
  - id: clip_adapters
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CLIP_ADAPTERS'
    doc: >
      Whether to clip adapters where identified.  Default value: true. Possible
      values: {true,

      false}
  - id: clip_overlapping_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CLIP_OVERLAPPING_READS'
    doc: >
      For paired reads, clip the 3' end of each read if necessary so that it
      does not extend

      past the 5' end of its mate.  Clipping will be either soft or hard
      clipping, depending on

      CLIP_OVERLAPPING_READS_OPERATOR setting. Hard clipped bases and their
      qualities will be

      stored in the XB and XQ tags respectively.  Default value: true. Possible
      values: {true,

      false}
  - id: expected_orientations
    type: string?
    inputBinding:
      position: 0
      prefix: '--EXPECTED_ORIENTATIONS'
    doc: >
      The expected orientation of proper read pairs. Replaces JUMP_SIZE  This
      argument may be

      specified 0 or more times. Default value: null. Possible values: {FR, RF,
      TANDEM}  Cannot

      be used in conjunction with argument(s) JUMP_SIZE (JUMP)
  - id: hard_clip_overlapping_reads
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--HARD_CLIP_OVERLAPPING_READS'
    doc: >
      If true, hard clipping will be applied to overlapping reads.  By default,
      soft clipping is

      used.  Default value: false. Possible values: {true, false}
  - id: include_secondary_alignments
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--INCLUDE_SECONDARY_ALIGNMENTS'
    doc: >
      If false, do not write secondary alignments to output.  Default value:
      true. Possible

      values: {true, false}
  - id: is_bisulfite_sequence
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--IS_BISULFITE_SEQUENCE'
    doc: >
      Whether the lane is bisulfite sequence (used when calculating the NM
      tag).  Default value:

      false. Possible values: {true, false}
  - id: jump_size
    type: int?
    inputBinding:
      position: 0
      prefix: '--JUMP_SIZE'
    doc: >
      The expected jump size (required if this is a jumping library).
      Deprecated. Use

      EXPECTED_ORIENTATIONS instead  Default value: null.  Cannot be used in
      conjunction with

      argument(s) EXPECTED_ORIENTATIONS (ORIENTATIONS)
  - id: matching_dictionary_tags
    type: string?
    inputBinding:
      position: 0
      prefix: '--MATCHING_DICTIONARY_TAGS'
    doc: >
      List of Sequence Records tags that must be equal (if present) in the
      reference dictionary

      and in the aligned file. Mismatching tags will cause an error if in this
      list, and a

      warning otherwise.  This argument may be specified 0 or more times.
      Default value: [M5,

      LN].
  - id: max_insertions_or_deletions
    type: int?
    inputBinding:
      position: 0
      prefix: '--MAX_INSERTIONS_OR_DELETIONS'
    doc: >
      The maximum number of insertions or deletions permitted for an alignment
      to be included.

      Alignments with more than this many insertions or deletions will be
      ignored. Set to -1 to

      allow any number of insertions or deletions.  Default value: 1.
  - id: min_unclipped_bases
    type: int?
    inputBinding:
      position: 0
      prefix: '--MIN_UNCLIPPED_BASES'
    doc: >
      If UNMAP_CONTAMINANT_READS is set, require this many unclipped bases or
      else the read will

      be marked as contaminant.  Default value: 32.
  - id: paired_run
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--PAIRED_RUN'
    doc: >
      DEPRECATED. This argument is ignored and will be removed.  Default value:
      true. Possible

      values: {true, false}
  - id: primary_alignment_strategy
    type: string?
    inputBinding:
      position: 0
      prefix: '--PRIMARY_ALIGNMENT_STRATEGY'
    doc: >
      Strategy for selecting primary alignment when the aligner has provided
      more than one

      alignment for a pair or fragment, and none are marked as primary, more
      than one is marked

      as primary, or the primary alignment is filtered out for some reason. For
      all strategies,

      ties are resolved arbitrarily.  Default value: BestMapq. BestMapq (Expects
      that multiple

      alignments will be correlated with HI tag, and prefers the pair of
      alignments with the

      largest MAPQ, in the absence of a primary selected by the aligner.)

      EarliestFragment (Prefers the alignment which maps the earliest base in
      the read. Note

      that EarliestFragment may not be used for paired reads.)

      BestEndMapq (Appropriate for cases in which the aligner is not pair-aware,
      and does not

      output the HI tag. It simply picks the alignment for each end with the
      highest MAPQ, and

      makes those alignments primary, regardless of whether the two alignments
      make sense

      together.)

      MostDistant (Appropriate for a non-pair-aware aligner. Picks the alignment
      pair with the

      largest insert size. If all alignments would be chimeric, it picks the
      alignments for each

      end with the best MAPQ.)
  - id: read1_aligned_bam
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '--READ1_ALIGNED_BAM'
    inputBinding:
      position: 1
    doc: >
      SAM or BAM file(s) with alignment data from the first read of a pair.
      This argument may

      be specified 0 or more times. Default value: null.  Cannot be used in
      conjunction with

      argument(s) ALIGNED_BAM (ALIGNED)
  - id: read1_trim
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ1_TRIM'
    doc: >
      The number of bases trimmed from the beginning of read 1 prior to
      alignment  Default

      value: 0.
  - id: read2_aligned_bam
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: '--READ2_ALIGNED_BAM'
    inputBinding:
      position: 1
    doc: >
      SAM or BAM file(s) with alignment data from the second read of a pair.
      This argument may

      be specified 0 or more times. Default value: null.  Cannot be used in
      conjunction with

      argument(s) ALIGNED_BAM (ALIGNED)
  - id: read2_trim
    type: int?
    inputBinding:
      position: 0
      prefix: '--READ2_TRIM'
    doc: >
      The number of bases trimmed from the beginning of read 2 prior to
      alignment  Default

      value: 0.
  - id: sort_order
    type: string?
    inputBinding:
      position: 1
      prefix: '--SORT_ORDER'
    doc: >
      The order in which the merged reads should be output.  Default value:
      coordinate. Possible

      values: {unsorted, queryname, coordinate, duplicate, unknown}
  - id: unmap_contaminant_reads
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--UNMAP_CONTAMINANT_READS'
    doc: >
      Detect reads originating from foreign organisms (e.g. bacterial DNA in a
      non-bacterial

      sample),and unmap + label those reads accordingly.  Default value: false.
      Possible values:

      {true, false}
  - id: unmapped_read_strategy
    type: string?
    inputBinding:
      position: 1
      prefix: '--UNMAPPED_READ_STRATEGY'
    doc: >
      How to deal with alignment information in reads that are being unmapped
      (e.g. due to

      cross-species contamination.) Currently ignored unless
      UNMAP_CONTAMINANT_READS = true.

      Note that the DO_NOT_CHANGE strategy will actually reset the cigar and set
      the mapping

      quality on unmapped reads since otherwisethe result will be an invalid
      record. To force no

      change use the DO_NOT_CHANGE_INVALID strategy.  Default value:
      DO_NOT_CHANGE. Possible

      values: {COPY_TO_TAG, DO_NOT_CHANGE, DO_NOT_CHANGE_INVALID, MOVE_TO_TAG}
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
  - id: gatk_merge_bam_alignment_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.unmapped_bam.basename.replace(/.bam|.sam/, '_merged.bam')
            }
        }
    secondaryFiles:
      - ^.bai
label: GATK-MergeBamAlignment
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
  - position: 1
    prefix: '-O'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.unmapped_bam.basename.replace(/.bam|.sam/, '_merged.bam')
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
