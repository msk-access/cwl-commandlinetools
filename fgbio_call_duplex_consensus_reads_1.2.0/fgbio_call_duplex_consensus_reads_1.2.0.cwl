class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fgbio_call_duplex_consensus_reads_1_2_0
baseCommand:
  - fgbio
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
      position: 2
      prefix: '--input'
      shellQuote: false
    doc: The input SAM or BAM file.
  - id: output_file_name
    type: string?
    doc: Output SAM or BAM file to write consensus reads.
  - id: read_name_prefix
    type: string?
    inputBinding:
      position: 2
      prefix: '--read-name-prefix'
    doc: The prefix all consensus read names
  - id: read_group_id
    type: string?
    inputBinding:
      position: 2
      prefix: '--read-group-id'
    doc: The new read group ID for all the consensus reads.
  - id: error_rate_pre_umi
    type: int?
    inputBinding:
      position: 2
      prefix: '--error-rate-pre-umi'
    doc: >-
      The Phred-scaled error rate for an error prior to the UMIs being
      integrated.
  - id: error_rate_post_umi
    type: int?
    inputBinding:
      position: 2
      prefix: '--error-rate-post-umi'
    doc: >-
      The Phred-scaled error rate for an error post the UMIs have been
      integrated.
  - id: min_input_base_quality
    type: int?
    inputBinding:
      position: 2
      prefix: '--min-input-base-quality'
    doc: Ignore bases in raw reads that have Q below this value.
  - id: trim
    type: boolean?
    inputBinding:
      position: 2
      prefix: '--trim'
    doc: 'If true, quality trim input reads in addition to masking low Q bases'
  - id: sort_order
    type: string?
    inputBinding:
      position: 2
      prefix: '--sort-order'
    doc: 'The sort order of the output, if :none: then the same as the input.'
  - id: min_reads
    type: 'int[]'
    inputBinding:
      position: 2
      prefix: '--min-reads'
      itemSeparator: ' '
      shellQuote: false
    doc: The minimum number of input reads to a consensus read.
  - id: max_reads_per_strand
    type: int?
    inputBinding:
      position: 2
      prefix: '--max-reads-per-strand'
    doc: >-
      The maximum number of reads to use when building a single-strand
      consensus. If more than this many reads are present in a tag family, the
      family is randomly downsampled to exactly max-reads reads.
  - id: temporary_directory
    type: string?
    doc: 'Default value: null.'
  - id: async_io
    type: string?
    inputBinding:
      position: 0
      separate: false
      prefix: '--async-io='
    doc: >-
      'Use asynchronous I/O where possible, e.g. for SAM and BAM files [=true|false].'
outputs:
  - id: fgbio_call_duplex_consensus_reads_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name)
                return inputs.output_file_name;
            return  inputs.input.basename.replace(/.bam/,'_cons.bam');
        }
doc: >-
  Calls duplex consensus sequences from reads generated from the same
  double-stranded source molecule. Prior to running this tool, read must have
  been grouped with GroupReadsByUmi using the paired strategy. Doing so will
  apply (by default) MI tags to all reads of the form */A and */B where the /A
  and /B suffixes with the same identifier denote reads that are derived from
  opposite strands of the same source duplex molecule.


  Reads from the same unique molecule are first partitioned by source strand and
  assembled into single strand consensus molecules as described by
  CallMolecularConsensusReads. Subsequently, for molecules that have at least
  one observation of each strand, duplex consensus reads are assembled by
  combining the evidence from the two single strand consensus reads.


  Because of the nature of duplex sequencing, this tool does not support
  fragment reads - if found in the input they are ignored. Similarly, read pairs
  for which consensus reads cannot be generated for one or other read (R1 or R2)
  are omitted from the output.


  Consensus reads have a number of additional optional tags set in the resulting
  BAM file. The tag names follow a pattern where the first letter (a, b or c)
  denotes that the tag applies to the first single strand consensus (a), second
  single-strand consensus (b) or the final duplex consensus (c). The second
  letter is intended to capture the meaning of the tag (e.g. d=depth, m=min
  depth, e=errors/error-rate) and is upper case for values that are one per read
  and lower case for values that are one per base.
label: fgbio_call_duplex_consensus_reads_1.2.0
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
          return "-Xmx40G"
        }
        else {
            return "-Xmx40G"
        }
      }
  - position: 0
    valueFrom: '-XX:-UseGCOverheadLimit'
  - position: 1
    valueFrom: CallDuplexConsensusReads
  - position: 0
    prefix: '--tmp-dir='
    separate: false
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 2
    prefix: '--output'
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.output_file_name)
              return inputs.output_file_name;
            return  inputs.input.basename.replace(/.bam/,'_cons.bam');
      }
  - position: 2
    prefix: '--threads'
    valueFrom: |-
      ${
          if(inputs.number_of_threads)
              return inputs.number_of_threads
          return runtime.cores
      }
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/fgbio:1.2.0'
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
    'doap:name': fgbio CallDuplexConsensusReads
    'doap:revision': 1.2.0
