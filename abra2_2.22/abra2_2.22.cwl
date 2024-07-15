class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: abra2_2_22
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
  - id: input_bam
    type:
      - File
      - type: array
        items: File
    inputBinding:
      position: 0
      prefix: '--in'
    doc: Required list of input sam or bam file (s) separated by comma
    secondaryFiles:
      - ^.bai
  - id: working_directory
    type: string?
    doc: Set the temp directory (overrides java.io.tmpdir)
  - id: reference_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '--ref'
    doc: Genome reference location
    secondaryFiles:
      - .fai
  - id: targets
    type: File
    inputBinding:
      position: 0
      prefix: '--targets'
  - id: kmer_size
    type: string?
    inputBinding:
      position: 0
      prefix: '--kmer'
    doc: >-
      Optional assembly kmer size(delimit with commas if multiple sizes
      specified)
  - id: maximum_average_depth
    type: int?
    inputBinding:
      position: 0
      prefix: '--mad'
    doc: >-
      Regions with average depth exceeding this value will be downsampled
      (default: 1000)
  - id: soft_clip_contig
    type: string?
    inputBinding:
      position: 0
      prefix: '--sc'
    doc: >-
      Soft clip contig args
      [max_contigs,min_base_qual,frac_high_qual_bases,min_soft_clip_len]
      (default:16,13,80,15)
  - id: maximum_mixmatch_rate
    type: float?
    inputBinding:
      position: 0
      prefix: '--mmr'
    doc: >-
      Max allowed mismatch rate when mapping reads back to contigs (default:
      0.05)
  - id: scoring_gap_alignments
    type: string?
    inputBinding:
      position: 0
      prefix: '--sga'
    doc: >-
      Scoring used for contig alignments(match,
      mismatch_penalty,gap_open_penalty,gap_extend_penalty) (default:8,32,48,1)
  - id: contig_anchor
    type: string?
    inputBinding:
      position: 0
      prefix: '--ca'
    doc: >-
      Contig anchor [M_bases_at_contig_edge,max_mismatches_near_edge]
      (default:10,2)
  - id: window_size
    type: string?
    inputBinding:
      position: 0
      prefix: '--ws'
    doc: |-
      Processing window size and overlap
      (size,overlap) (default: 400,200)
  - id: consensus_sequence
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--cons'
    doc: Use positional consensus sequence when aligning high quality soft clipping
  - id: output_bams
    type:
      - string
      - type: array
        items: string
    inputBinding:
      position: 0
      prefix: '--out'
    doc: Required list of output sam or bam file (s) separated by comma
  - id: ignore_bad_assembly
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--ignore-bad-assembly'
    doc: Use this option to avoid parsing errors for corrupted assemblies
  - id: bam_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--index'
    doc: >-
      Enable BAM index generation when outputting sorted alignments (may require
      additonal memory)
  - id: input_vcf
    type: File?
    inputBinding:
      position: 0
      prefix: '--in-vcf'
    doc: >-
      VCF containing known (or suspected) variant sites.  Very large files
      should be avoided.
  - id: no_edge_complex_indel
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--no-edge-ci'
    doc: Prevent output of complex indels at read start or read end
  - id: no_sort
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--nosort'
    doc: Do not attempt to sort final output
outputs:
  - id: abra_realigned_bam
    type:
      - 'null'
      - File
      - type: array
        items: File
    outputBinding:
      glob: |-
        ${
            return inputs.output_bams
        }
    secondaryFiles:
      - ^.bai
label: abra2_2.22
arguments:
  - position: 0
    valueFrom: |-
      ${
        if (inputs.memory_per_job && inputs.memory_overhead) {

          if (inputs.memory_per_job % 1000 == 0) {

            return "-Xmx" + (inputs.memory_per_job / 1000).toString() + "G"
          }
          else {

            return "-Xmx" + Math.floor((inputs.memory_per_job / 1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead) {

          if (inputs.memory_per_job % 1000 == 0) {

            return "-Xmx" + (inputs.memory_per_job / 1000).toString() + "G"
          }
          else {

            return "-Xmx" + Math.floor((inputs.memory_per_job / 1000)).toString() + "G"
          }
        }
        else if (!inputs.memory_per_job && inputs.memory_overhead) {

          return "-Xmx64G -XX:+ExplicitGCInvokesConcurrent"
        }
        else {

          return "-Xmx64G -XX:+ExplicitGCInvokesConcurrent"
        }
      }
  - position: 0
    prefix: '-jar'
    valueFrom: /usr/local/bin/abra2.jar
  - position: 0
    prefix: '--threads'
    valueFrom: |-
      ${
          if(inputs.number_of_threads)
              return inputs.number_of_threads
          return runtime.cores
      }
  - position: 0
    prefix: '--tmpdir'
    valueFrom: |-
      ${
          if(inputs.working_directory)
              return inputs.working_directory;
            return runtime.tmpdir
      }
requirements:
  - class: ResourceRequirement
    ramMin: 96000
    coresMin: 48
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/abra2:2.22'
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
    'doap:name': abra2
    'doap:revision': 2.22
