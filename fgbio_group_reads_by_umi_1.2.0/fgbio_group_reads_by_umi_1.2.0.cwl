class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fgbio_group_reads_by_umi_1_2_0
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
    doc: The input BAM file.
  - id: output_file_name
    type: string?
    doc: The output SAM or BAM file to be written.
  - id: family_size_histogram
    type: string?
    inputBinding:
      position: 2
      prefix: '--family-size-histogram'
    doc: Optional output of tag family size counts.
  - id: raw_tag
    type: string?
    inputBinding:
      position: 2
      prefix: '--raw-tag'
    doc: The tag containing the raw UMI.
  - id: assign_tag
    type: string?
    inputBinding:
      position: 2
      prefix: '--assign-tag'
    doc: The output tag for UMI grouping.
  - id: min_map_q
    type: int?
    inputBinding:
      position: 2
      prefix: '--min-map-q'
    doc: Minimum mapping quality.
  - id: include_non_pf_reads
    type: boolean?
    inputBinding:
      position: 2
      prefix: '--include-non-pf-reads'
  - id: strategy
    type: string
    inputBinding:
      position: 2
      prefix: '--strategy'
    doc: 'The UMI assignment strategy. (identity,edit,adjacency,paired)'
  - id: edits
    type: int?
    inputBinding:
      position: 2
      prefix: '--edits'
    doc: The allowable number of edits between UMIs.
  - id: min_umi_length
    type: int?
    inputBinding:
      position: 2
      prefix: '--min-umi-length'
    doc: >-
      The minimum UMI length. If not specified then all UMIs must have the same
      length, otherwise discard reads with UMIs shorter than this length and
      allow for differing UMI lengths.
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
  - id: fgbio_group_reads_by_umi_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name)
                return inputs.output_file_name;
            return  inputs.input.basename.replace(/.bam/,'_group.bam');
        }
  - id: fgbio_group_reads_by_umi_histogram
    type: File?
    outputBinding:
      glob: |-
        ${
            if(inputs.family_size_histogram)
                return inputs.family_size_histogram
        }
doc: >-
  Groups reads together that appear to have come from the same original
  molecule. Reads are grouped by template, and then templates are sorted by the
  5’ mapping positions of the reads from the template, used from earliest
  mapping position to latest. Reads that have the same end positions are then
  sub-grouped by UMI sequence.


  Accepts reads in any order (including unsorted) and outputs reads sorted by:


  The lower genome coordinate of the two outer ends of the templates

  The sequencing library

  The assigned UMI tag

  Read Name

  Reads are aggressively filtered out so that only high quality reads/mappings
  are taken forward. Single-end reads must have mapping quality >= min-map-q.
  Paired-end reads must have both reads mapped to the same chromosome with both
  reads having mapping quality >= min-mapq. (Note: the MQ tag is required on
  reads with mapped mates).


  This is done with the expectation that the next step is building consensus
  reads, where it is undesirable to either:


  Assign reads together that are really from different source molecules

  Build two groups from reads that are really from the same molecule

  Errors in mapping reads could lead to both and therefore are minimized.


  Grouping of UMIs is performed by one of three strategies:


  1. identity: only reads with identical UMI sequences are grouped together.
  This strategy may be useful for evaluating data, but should generally be
  avoided as it will generate multiple UMI groups per original molecule in the
  presence of errors.

  2. edit: reads are clustered into groups such that each read within a group
  has at least one other read in the group with <= edits differences and there
  are inter-group pairings with <= edits differences. Effective when there are
  small numbers of reads per UMI, but breaks down at very high coverage of UMIs.

  3. adjacency: a version of the directed adjacency method described in
  umi_tools that allows for errors between UMIs but only when there is a count
  gradient.

  4. paired: similar to adjacency but for methods that produce template with a
  pair of UMIs such that a read with A-B is related to but not identical to a
  read with B-A. Expects the pair of UMIs to be stored in a single tag,
  separated by a hyphen (e.g. ACGT-CCGG). The molecular IDs produced have more
  structure than for single UMI strategies, and are of the form {base}/{AB|BA}.
  E.g. two UMI pairs would be mapped as follows AAAA-GGGG -> 1/AB, GGGG-AAAA ->
  1/BA.

  edit, adjacency and paired make use of the --edits parameter to control the
  matching of non-identical UMIs.


  By default, all UMIs must be the same length. If --min-umi-length=len is
  specified then reads that have a UMI shorter than len will be discarded, and
  when comparing UMIs of different lengths, the first len bases will be
  compared, where len is the length of the shortest UMI. The UMI length is the
  number of [ACGT] bases in the UMI (i.e. does not count dashes and other
  non-ACGT characters). This option is not implemented for reads with UMI pairs
  (i.e. using the paired assigner).
label: fgbio_group_reads_by_umi_1.2.0
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
    valueFrom: '-XX:-UseGCOverheadLimit'
  - position: 1
    valueFrom: GroupReadsByUmi
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
            return  inputs.input.basename.replace(/.bam/,'_group.bam');
      }
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 32000
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
    'doap:name': fgbio GroupReadsByUmi
    'doap:revision': 1.2.0
