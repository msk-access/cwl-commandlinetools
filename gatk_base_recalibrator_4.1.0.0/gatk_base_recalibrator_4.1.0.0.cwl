class: CommandLineTool
cwlVersion: v1.0
id: gatk_base_recalibrator_4_1_0_0
baseCommand:
  - gatk
  - BaseRecalibrator
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
  - id: known_sites
    type: File
    inputBinding:
      position: 0
      prefix: '--known-sites'
    secondaryFiles:
      - .idx
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '--reference'
    secondaryFiles:
      - .fai
      - ^.dict
  - id: add_output_sam_program_record
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--add-output-sam-program-record'
  - id: add_output_vcf_command_line
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--add-output-vcf-command-line'
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          position: 0
          prefix: '--arguments_file'
  - id: binary_tag_name
    type: string?
    inputBinding:
      position: 0
      prefix: '--binary-tag-name'
  - id: bqsr_baq_gap_open_penalty
    type: float?
    inputBinding:
      position: 0
      prefix: '--bqsr-baq-gap-open-penalty'
  - id: cloud-index-prefetch-buffer
    type: int?
    inputBinding:
      position: 0
      prefix: '--cloud-index-prefetch-buffer'
  - id: cloud_prefetch_buffer
    type: int?
    inputBinding:
      position: 0
      prefix: '--cloud-prefetch-buffer'
  - id: create_output_bam_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--create-output-bam-index'
  - id: create_output_bam_md5
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--create-output-bam-md5'
  - id: create_output_variant_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--create-output-variant-index'
  - id: create_output_variant_md5
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--create-output-variant-md5'
  - id: default_base_qualities
    type: int?
    inputBinding:
      position: 0
      prefix: '--default-base-qualities'
  - id: deletions_default_quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--deletions-default-quality'
  - id: disable_bam_index_caching
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable-bam-index-caching'
  - id: disable_read_filter
    type: string?
    inputBinding:
      position: 0
      prefix: '--disable-read-filter'
  - id: disable_sequence_dictionary_validation
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable-sequence-dictionary-validation'
  - id: exclude_intervals
    type: string?
    inputBinding:
      position: 0
      prefix: '--exclude-intervals'
  - id: gatk_config_file
    type: File?
    inputBinding:
      position: 0
      prefix: '--gatk-config-file'
  - id: gcs_max_retries
    type: int?
    inputBinding:
      position: 0
      prefix: '--gcs-max-retries'
  - id: gcs_project_for_requester_pays
    type: string?
    inputBinding:
      position: 0
      prefix: '--gcs-project-for-requester-pays'
  - id: indels_context_size
    type: int?
    inputBinding:
      position: 0
      prefix: '--indels-context-size'
  - id: insertions_default_quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--insertions-default-quality'
  - id: interval_exclusion_padding
    type: int?
    inputBinding:
      position: 0
      prefix: '--interval-exclusion-padding'
  - id: interval_merging_rule
    type: string?
    inputBinding:
      position: 0
      prefix: '--interval-merging-rule'
  - id: interval_padding
    type: string?
    inputBinding:
      position: 0
      prefix: '--interval-padding'
  - id: interval_set_rule
    type: string?
    inputBinding:
      position: 0
      prefix: '--interval-set-rule'
  - id: intervals
    type: string?
    inputBinding:
      position: 0
      prefix: '--intervals'
  - id: lenient
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--lenient'
  - id: low_quality_tail
    type: int?
    inputBinding:
      position: 0
      prefix: '--low-quality-tail'
  - id: maximum_cycle_value
    type: int?
    inputBinding:
      position: 0
      prefix: '--maximum-cycle-value'
  - id: mismatches_context_size
    type: int?
    inputBinding:
      position: 0
      prefix: '--mismatches-context-size'
  - id: mismatches_default_quality
    type: int?
    inputBinding:
      position: 0
      prefix: '--mismatches-default-quality'
  - id: preserve_qscores_less_than
    type: int?
    inputBinding:
      position: 0
      prefix: '--preserve-qscores-less-than'
  - id: quantizing_levels
    type: int?
    inputBinding:
      position: 0
      prefix: '--quantizing-levels'
  - id: QUIET
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--QUIET'
  - id: read_filter
    type: string?
    inputBinding:
      position: 0
      prefix: '--read-filter'
  - id: read_index
    type: string?
    inputBinding:
      position: 0
      prefix: '--read-index'
  - id: seconds_between_progress_updates
    type: float?
    inputBinding:
      position: 0
      prefix: '--seconds-between-progress-updates'
  - id: sequence_dictionary
    type: File?
    inputBinding:
      position: 0
      prefix: '--sequence-dictionary'
  - id: sites_only_vcf_output
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--sites-only-vcf-output'
  - id: use_original_qualities
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--use-original-qualities'
outputs:
  - id: gatk_base_recalibrator_output
    type: File?
    outputBinding:
      glob: '$(inputs.input.basename.replace(''.bam'', '''')).recal.table'
label: gatk_base_recalibrator_4.1.0.0
arguments:
  - position: 0
    prefix: '--tmp-dir'
    valueFrom: .
  - position: 0
    prefix: '--output'
    valueFrom: '$(inputs.input.basename.replace(''.bam'', '''')).recal.table'
  - position: 0
    prefix: '--verbosity'
    valueFrom: INFO
requirements:
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'broadinstitute/gatk:4.1.0.0'
  - class: InlineJavascriptRequirement
