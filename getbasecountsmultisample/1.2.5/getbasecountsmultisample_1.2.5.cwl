class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: getbasecountsmultisample_1_2_5
baseCommand:
  - GetBaseCountsMultiSample
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: genotyping_bams
    type:
      - File
      - type: array
        items: File
    doc: Input bam file
  - id: genotyping_bams_ids
    type:
      - string
      - type: array
        items: string
    doc: >-
      Input bam, sample identifier to be used for "Tumor Sample Barcode" for maf
      or Sample name in the header for vcf
  - id: filter_duplicate
    type: int
    inputBinding:
      position: 0
      prefix: '--filter_duplicate'
    doc: >-
      Whether to filter reads that are marked as duplicate. 0=off, 1=on. Default
      1
  - id: fragment_count
    type: int
    inputBinding:
      position: 0
      prefix: '--fragment_count'
    doc: 'Whether to output fragment read counts DPF/RDF/ADF. 0=off, 1=on. Default 0'
  - id: maf
    type: File
    inputBinding:
      position: 0
      prefix: '--maf'
    doc: >-
      Input variant file in TCGA maf format. --maf or --vcf need to be specified
      at least once. But --maf and --vcf are mutually exclusive
  - id: maq
    type: int?
    inputBinding:
      position: 0
      prefix: '--maq'
    doc: Mapping quality threshold. Default 20
  - id: omaf
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--omaf'
    doc: Output the result in maf format
  - id: output
    type: string?
    inputBinding:
      position: 0
      prefix: '--output'
      valueFrom: |-
        ${
            if (inputs.output) {
                return inputs.output
            } else if (inputs.genotyping_bams.length) {
                return inputs.maf.basename.replace('.maf', '_fillout.maf')
            } else {
                return inputs.genotyping_bams.basename.replace('.bam', '_fillout.maf')
            }
        }
    doc: Filename for output of raw fillout data in MAF/VCF format
  - id: ref_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '--fasta'
    doc: Input reference sequence file
  - id: vcf
    type: File?
    inputBinding:
      position: 0
      prefix: '--vcf'
    doc: >-
      Input variant file in vcf-like format(the first 5 columns are used). --maf
      or --vcf need to be specified at least once. But --maf and --vcf are
      mutually exclusive
  - id: generic_counting
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--generic_counting'
    doc: >-
      Use the newly implemented generic counting algorithm. Works better for
      complex variants. You may get different allele count result from the
      default counting algorithm
outputs:
  - id: fillout
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.output) {
                return inputs.output
            } else if (inputs.genotyping_bams.length) {
                return inputs.maf.basename.replace('.maf', '_fillout.maf')
            } else {
                return inputs.genotyping_bams.basename.replace('.bam', '_fillout.maf')
            }
        }
label: getbasecountsmultisample_1.2.5
arguments:
  - position: 0
    prefix: ''
    shellQuote: false
    valueFrom: |
      $('--bam_fof bam_fof.tsv')
  - position: 0
    prefix: '--thread'
    valueFrom: $(runtime.cores - 3)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gbcms:1.2.5'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: bam_fof.tsv
        entry: |-
          ${
            if (typeof(inputs.genotyping_bams_ids) == 'object') {
                return inputs.genotyping_bams_ids.map(function(sid, i) {
                  return sid + "\t" +
                    inputs.genotyping_bams[i].path
                }).join("\n")
            } else {
                return inputs.genotyping_bams_ids + "\t" + inputs.genotyping_bams.path + "\n"
            }
          }
        writable: false
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
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
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': GetBaseCountsMultiSample
    'doap:revision': 1.2.5
