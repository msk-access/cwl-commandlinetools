class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: calculate_noise_0_2_4
baseCommand:
  - calculate_noise
inputs:
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: --ref_fasta
    secondaryFiles:
      - ^.fasta.fai
    doc: >-
      Path to reference fasta, containing all regions in bed_file
  - id: bam_file
    type: File
    inputBinding:
      position: 0
      prefix: --bam_file
    secondaryFiles:
      - ^.bai
    doc: >-
      Path to BAM file for calculating noise  [required]
  - id: bed_file
    type: File
    inputBinding:
      position: 0
      prefix: --bed_file
    doc: >-
      Path to BED file containing regions over which to calculate noise  [required]
  - id: sample_id
    type: string
    inputBinding:
      position: 0
      prefix: --sample_id
    doc: >-
      Prefix to include in all output file names
  - id: threshold
    type: float?
    inputBinding:
      position: 0
      prefix: --threshold
    doc: >-
      Alt allele frequency past which to ignore positions from the calculation.
  - id: truncate
    type: int?
    inputBinding:
      position: 0
      prefix: --truncate
    doc: >-
      Whether to exclude trailing bases from reads that only partially overlap the bed file (0 or 1)
  - id: min_mapq
    type: int?
    inputBinding:
      position: 0
      prefix: --min_mapq
    doc: >-
      Exclude reads with a lower mapping quality
  - id: min_basq
    type: int?
    inputBinding:
      position: 0
      prefix: --min_basq
    doc: >-
      Exclude bases with a lower base quality
outputs:
  - id: sequence_qc_pileup
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_pileup.tsv'
        }
  - id: sequence_qc_noise_positions
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise_positions.tsv'
        }
  - id: sequence_qc_noise_by_substitution
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise_by_substitution.tsv'
        }
  - id: sequence_qc_noise_acgt
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise_acgt.tsv'
        }
  - id: sequence_qc_noise_n
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise_n.tsv'
        }
  - id: sequence_qc_noise_del
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise_del.tsv'
        }
  - id: sequence_qc_figures
    type: File
    outputBinding:
      glob: |-
        ${
            return inputs.sample_id + '_noise.html'
        }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/sequence_qc:0.2.4'
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      LC_ALL: en_US.utf-8
      LANG: en_US.utf-8
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
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': sesquence_qc
    'doap:revision': 0.2.4
