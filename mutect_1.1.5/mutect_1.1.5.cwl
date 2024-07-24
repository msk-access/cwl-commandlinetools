class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: mutect_v1_1_5
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
  - id: BQSR
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--BQSR'
    doc: >-
      The input covariates table file which enables on-the-fly base quality
      score recalibration
  - id: absolute_copy_number_data
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--absolute_copy_number_data'
    doc: >-
      Absolute Copy Number Data, as defined by Absolute, to use in power
      calculations
  - id: arg_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--arg_file'
    doc: Reads arguments from the specified file
  - id: bam_tumor_sample_name
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--bam_tumor_sample_name'
    doc: >-
      if the tumor bam contains multiple samples, only use read groups with SM
      equal to this value
  - id: baq
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--baq'
    doc: >-
      Type of BAQ calculation to apply in the engine
      (OFF|CALCULATE_AS_NECESSARY| RECALCULATE)
  - id: baqGapOpenPenalty
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--baqGapOpenPenalty'
    doc: >-
      BAQ gap open penalty (Phred Scaled). Default value is 40. 30 is perhaps
      better for whole genome call sets
  - id: clipping_bias_pvalue_threshold
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--clipping_bias_pvalue_threshold'
    doc: >-
      pvalue threshold for fishers exact test of clipping bias in mutant reads
      vs ref reads
  - id: cosmic
    type: File?
    inputBinding:
      position: 0
      prefix: '--cosmic'
    doc: VCF file of COSMIC sites
    secondaryFiles:
      - ^.vcf.idx
  - id: coverage_20_q20_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--coverage_20_q20_file'
    doc: write out 20x of Q20 coverage in WIGGLE format to this file
  - id: coverage_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--coverage_file'
    doc: write out coverage in WIGGLE format to this file
  - id: dbsnp
    type: File?
    inputBinding:
      position: 0
      prefix: '--dbsnp'
    doc: VCF file of DBSNP information
    secondaryFiles:
      - ^.vcf.idx
  - id: dbsnp_normal_lod
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--dbsnp_normal_lod'
    doc: LOD threshold for calling normal non-variant at dbsnp sites
  - id: defaultBaseQualities
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--defaultBaseQualities'
    doc: >-
      If reads are missing some or all base quality scores, this value will be
      used for all base quality scores
  - default: false
    id: disableRandomization
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disableRandomization'
    doc: >-
      Completely eliminates randomization from nondeterministic methods. To be
      used mostly in the testing framework where dynamic parallelism can result
      in differing numbers of calls to the generator.
  - default: false
    id: disable_indel_quals
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable_indel_quals'
    doc: >-
      If true, disables printing of base insertion and base deletion tags (with
      -BQSR)
  - id: downsample_to_coverage
    type: int?
    inputBinding:
      position: 0
      prefix: '--downsample_to_coverage'
    doc: Target coverage threshold for downsampling to coverage
  - default: NONE
    id: downsampling_type
    type: string?
    inputBinding:
      position: 0
      prefix: '--downsampling_type'
    doc: >-
      Type of reads downsampling to employ at a given locus. Reads will be
      selected randomly to be removed from the pile based on the method
      described here (NONE|ALL_READS| BY_SAMPLE) given locus; note that
      downsampled reads are randomly selected from all possible reads at a locus
  - default: false
    id: emit_original_quals
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--emit_original_quals'
    doc: >-
      If true, enables printing of the OQ tag with the original base qualities
      (with -BQSR)
  - default: true
    id: enable_extended_output
    type: boolean
    inputBinding:
      position: 0
      prefix: '--enable_extended_output'
  - id: excludeIntervals
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--excludeIntervals'
    doc: >-
      One or more genomic intervals to exclude from processing. Can be
      explicitly specified on the command line or in a file (including a rod
      file)
  - default: false
    id: filter_mismatching_base_and_quals
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--filter_mismatching_base_and_quals'
    doc: >-
      if a read has mismatching number of bases and base qualities, filter out
      the read instead of blowing up.
  - default: false
    id: force_alleles
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--force_alleles'
    doc: force output for all alleles at each site
  - default: false
    id: force_output
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--force_output'
    doc: force output for each site
  - id: fraction_contamination
    type: float?
    inputBinding:
      position: 0
      prefix: '--fraction_contamination'
    doc: >-
      estimate of fraction (0-1) of physical contamination with other unrelated
      samples
  - id: fraction_mapq0_threshold
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--fraction_mapq0_threshold'
    doc: >-
      threshold for determining if there is relatedness between the alt and ref
      allele read piles
  - id: gap_events_threshold
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--gap_events_threshold'
    doc: >-
      how many gapped events (ins/del) are allowed in proximity to this
      candidate
  - id: gatk_key
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--gatk_key'
    doc: >-
      GATK Key file. Required if running with -et NO_ET. Please see
      -phone-home-and-how-does-it-affect-me#latest for details.
  - id: heavily_clipped_read_fraction
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--heavily_clipped_read_fraction'
    doc: >-
      if this fraction or more of the bases in a read are soft/hard clipped, do
      not use this read for mutation calling
  - id: initial_tumor_lod
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--initial_tumor_lod'
    doc: Initial LOD threshold for calling tumor variant
  - id: input_file_normal
    type: File?
    inputBinding:
      position: 0
      prefix: '--input_file:normal'
    doc: SAM or BAM file(s)
    secondaryFiles:
      - ^.bai
  - id: input_file_tumor
    type: File?
    inputBinding:
      position: 0
      prefix: '--input_file:tumor'
    doc: SAM or BAM file(s)
    secondaryFiles:
      - ^.bai
  - id: interval_merging
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--interval_merging'
    doc: >-
      Indicates the interval merging rule we should use for abutting intervals
      (ALL| OVERLAPPING_ONLY)
  - id: interval_padding
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--interval_padding'
    doc: >-
      Indicates how many basepairs of padding to include around each of the
      intervals specified with the -L/
  - id: interval_set_rule
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--interval_set_rule'
    doc: >-
      Indicates the set merging approach the interval parser should use to
      combine the various -L or -XL inputs (UNION| INTERSECTION)
  - id: intervals
    type:
      - string
      - File
      - 'null'
    inputBinding:
      position: 0
      prefix: '--intervals'
    doc: >-
      One or more genomic intervals over which to operate. Can be explicitly
      specified on the command line or in a file (including a rod file)
  - default: false
    id: keep_program_records
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--keep_program_records'
    doc: >-
      Should we override the Walkers default and keep program records from the
      SAM header
  - id: log_to_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--log_to_file'
    doc: Set the logging location
  - id: logging_level
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--logging_level'
    doc: >-
      Set the minimum level of logging, i.e. setting INFO gets you INFO up to
      FATAL, setting ERROR gets you ERROR and FATAL level logging.
  - id: maxRuntime
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--maxRuntime'
    doc: >-
      If provided, that GATK will stop execution cleanly as soon after
      maxRuntime has been exceeded, truncating the run but not exiting with a
      failure. By default the value is interpreted in minutes, but this can be
      changed by maxRuntimeUnits
  - id: maxRuntimeUnits
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--maxRuntimeUnits'
    doc: >-
      The TimeUnit for maxRuntime (NANOSECONDS|
      MICROSECONDS|MILLISECONDS|SECONDS|MINUTES| HOURS|DAYS)
  - id: max_alt_allele_in_normal_fraction
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--max_alt_allele_in_normal_fraction'
    doc: threshold for maximum alternate allele fraction in normal
  - id: max_alt_alleles_in_normal_count
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--max_alt_alleles_in_normal_count'
    doc: threshold for maximum alternate allele counts in normal
  - id: max_alt_alleles_in_normal_qscore_sum
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--max_alt_alleles_in_normal_qscore_sum'
    doc: threshold for maximum alternate allele quality score sum in normal
  - id: min_qscore
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--min_qscore'
    doc: threshold for minimum base quality score
  - id: minimum_mutation_cell_fraction
    type: float?
    inputBinding:
      position: 0
      prefix: '--minimum_mutation_cell_fraction'
    doc: >-
      minimum fraction of cells which are presumed to have a mutation, used to
      handle non-clonality and contamination
  - id: minimum_normal_allele_fraction
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--minimum_normal_allele_fraction'
    doc: >-
      minimum allele fraction to be considered in normal, useful for normal
      sample contaminated with tumor
  - default: false
    id: monitorThreadEfficiency
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--monitorThreadEfficiency'
    doc: Enable GATK threading efficiency monitoring
  - default: false
    id: nonDeterministicRandomSeed
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--nonDeterministicRandomSeed'
    doc: >-
      Makes the GATK behave non deterministically, that is, the random numbers
      generated will be different in every run
  - default: false
    id: noop
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--noop'
    doc: 'used for debugging, basically exit as soon as we get the reads'
  - id: normal_depth_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--normal_depth_file'
    doc: write out normal read depth in WIGGLE format to this file
  - id: normal_lod
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--normal_lod'
    doc: LOD threshold for calling normal non-germline
  - id: normal_sample_name
    type: string
    inputBinding:
      position: 0
      prefix: '--normal_sample_name'
    doc: name to use for normal in output files
  - id: num_bam_file_handles
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--num_bam_file_handles'
    doc: The total number of BAM file handles to keep open simultaneously
  - id: num_cpu_threads_per_data_thread
    type: string?
    inputBinding:
      position: 0
      prefix: '--num_cpu_threads_per_data_thread'
    doc: >-
      How many CPU threads should be allocated per data thread to running this
      analysis?
  - id: num_threads
    type: string?
    inputBinding:
      position: 0
      prefix: '--num_threads'
    doc: How many data threads should be allocated to running this analysis.
  - default: false
    id: only_passing_calls
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--only_passing_calls'
    doc: only emit passing calls
  - default: mutect_variants.txt
    id: out
    type: string?
    inputBinding:
      position: 0
      prefix: '--out'
    doc: Call-stats output
  - id: pedigree
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--pedigree'
    doc: Pedigree files for samples
  - id: pedigreeString
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--pedigreeString'
    doc: Pedigree string for samples
  - id: pedigreeValidationType
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--pedigreeValidationType'
    doc: >-
      How strict should we be in validating the pedigree information?
      (STRICT|SILENT)
  - id: performanceLog
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--performanceLog'
    doc: 'If provided, a GATK runtime performance log will be written to this file'
  - id: phone_home
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--phone_home'
    doc: >-
      What kind of GATK run report should we generate? STANDARD is the default,
      can be NO_ET so nothing is posted to the run repository. Please see
      -phone-home-and-how-does-it-affect-me#latest for details.
      (NO_ET|STANDARD|STDOUT)
  - id: pir_mad_threshold
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--pir_mad_threshold'
    doc: threshold for clustered read position artifact MAD
  - id: pir_median_threshold
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--pir_median_threshold'
    doc: threshold for clustered read position artifact median
  - id: power_constant_af
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--power_constant_af'
    doc: Allelic fraction constant to use in power calculations
  - id: power_constant_qscore
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--power_constant_qscore'
    doc: Phred scale quality score constant to use in power calculations
  - id: power_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--power_file'
    doc: write out power in WIGGLE format to this file
  - id: preserve_qscores_less_than
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--preserve_qscores_less_than'
    doc: >-
      Bases with quality scores less than this threshold wont be recalibrated
      (with -BQSR)
  - id: read_buffer_size
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--read_buffer_size'
    doc: Number of reads per SAM file to buffer in memory
  - id: read_filter
    type: string?
    inputBinding:
      position: 0
      prefix: '--read_filter'
    doc: Specify filtration criteria to apply to each read individually
  - id: read_group_black_list
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--read_group_black_list'
    doc: >-
      Filters out read groups matching <TAG> -<STRING> or a .txt file containing
      the filter strings one per line.
  - id: reference_sequence
    type: File
    inputBinding:
      position: 0
      prefix: '--reference_sequence'
    secondaryFiles:
      - .fai
      - ^.dict
  - default: false
    id: remove_program_records
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--remove_program_records'
    doc: >-
      Should we override the Walkers default and remove program records from the
      SAM header
  - default: false
    id: required_maximum_alt_allele_mapping_quality_score
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--required_maximum_alt_allele_mapping_quality_score'
    doc: >-
      required minimum value for
      <required_maximum_alt_allele_mapping_quality_score> tumor alt allele
      maximum mapping quality score
  - default: false
    id: somatic_classification_normal_power_threshold
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--somatic_classification_normal_power_threshold'
    doc: >-
      Power threshold for normal to
      <somatic_classification_normal_power_threshold> determine germline vs
      variant
  - id: tag
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--tag'
    doc: >-
      Arbitrary tag string to identify this GATK run as part of a group of runs,
      for later analysis
  - id: tumor_depth_file
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--tumor_depth_file'
    doc: write out tumor read depth in WIGGLE format to this file
  - id: tumor_f_pretest
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--tumor_f_pretest'
    doc: >-
      for computational efficiency, reject sites with allelic fraction below
      this threshold
  - id: tumor_lod
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--tumor_lod'
    doc: LOD threshold for calling tumor variant
  - id: tumor_sample_name
    type: string
    inputBinding:
      position: 0
      prefix: '--tumor_sample_name'
    doc: name to use for tumor in output files
  - id: unsafe
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--unsafe'
    doc: >-
      If set, enables unsafe operations - nothing will be checked at runtime.
      For expert users only who know what they are doing. We do not support
      usage of this argument. (ALLOW_UNINDEXED_BAM| ALLOW_UNSET_BAM_SORT_ORDER|
      NO_READ_ORDER_VERIFICATION| ALLOW_SEQ_DICT_INCOMPATIBILITY|
      LENIENT_VCF_PROCESSING|ALL)
  - default: false
    id: useOriginalQualities
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--useOriginalQualities'
    doc: >-
      If set, use the original base quality scores from the OQ tag when present
      instead of the standard scores
  - id: validation_strictness
    type: 'string[]?'
    inputBinding:
      position: 0
      prefix: '--validation_strictness'
    doc: How strict should we be with validation (STRICT|LENIENT|SILENT)
  - default: mutect_variants.vcf
    id: vcf
    type: string?
    inputBinding:
      position: 0
      prefix: '--vcf'
    doc: VCF output of mutation candidates
outputs:
  - id: mutect_output_txt
    type: File?
    outputBinding:
      glob: $(inputs.out)
  - id: mutext_output_vcf
    type: File?
    outputBinding:
      glob: $(inputs.vcf)
arguments:
  - |-
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
        return "-Xmx15G"
      }
      else {
          return "-Xmx15G"
      }
    }
  - |-
    ${
      if(inputs.memory_per_job && inputs.memory_overhead) {
        if(inputs.memory_per_job % 1000 == 0) {
          return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
        }
        else {
          return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
        }
      }
      else if (inputs.memory_per_job && !inputs.memory_overhead){
        if(inputs.memory_per_job % 1000 == 0) {
          return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
        }
        else {
          return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
        }
      }
      else if(!inputs.memory_per_job && inputs.memory_overhead){
        return "-Xmx24G"
      }
      else {
          return "-Xmx24G"
      }
    }
  - '-XX:-UseGCOverheadLimit'
  - '-jar'
  - /usr/local/bin/muTect.jar
  - '--analysis_type'
  - MuTect
requirements:
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/mutect:1.1.5'
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
        'foaf:mbox': 'mailto:huy1@mskcc.org'
        'foaf:name': Yu Hu
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': MuTect
    'doap:revision': 1.1.5
