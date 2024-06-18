class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: biometrics_genotype_0_2_15
baseCommand:
  - biometrics
  - genotype
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        position: 0
        prefix: '--input'
    doc: >-
      Can be one of three types: (1) path to a CSV file containing sample
      information (one per line). For example:
      sample_name,sample_bam,sample_type,sample_sex,sample_group. (2) Path to a
      '*.pk' file that was produced by the 'extract' tool. (3) Name of the
      sample to analyze; this assumes there is a file named '{sample_name}.pk'
      in your database directory. Can be specified more than once.
  - id: database
    type: string?
    inputBinding:
      position: 0
      prefix: '--database'
    doc: >-
      Directory to store the intermediate files after running the extraction
      step.
  - default: 0.05
    id: discordance_threshold
    type: float?
    inputBinding:
      position: 0
      prefix: '--discordance-threshold'
    doc: >-
      Discordance values less than this are regarded as matching samples.
      (default: 0.05)
  - id: prefix
    type: string?
    inputBinding:
      position: 0
      prefix: '--prefix'
    doc: Output file prefix.
  - id: plot
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--plot'
    doc: Also output plots of the data.
  - id: het
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--het'
    doc: Include Hetrozygous sites along with homozygous sites when calculating discordant rate, helps specifically in cases where there are less than 100 total number of sites.
  - id: json
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--json'
    doc: Also output data in JSON format.
  - id: no_db_comparison
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--no-db-compare'
    doc: >-
      Do not compare the sample(s) you provided to all samples in the database,
      only compare them with each other.
  - default: 2
    id: threads
    type: int?
    inputBinding:
      position: 0
      prefix: '--threads'
    doc: Number of threads to use.
outputs:
  - id: biometrics_genotype_comparisons
    type: File
    outputBinding:
      glob: |-
        ${
          if (inputs.prefix) {
            return inputs.prefix + '_genotype_comparison.csv'
          } else {
            return 'genotype_comparison.csv'
          }
        }
  - id: biometrics_genotype_cluster_input
    type: File
    outputBinding:
      glob: |-
        ${
          if (inputs.prefix) {
            return inputs.prefix + '_genotype_clusters_input.csv'
          } else {
            return 'genotype_clusters_input.csv'
          }
        }
  - id: biometrics_genotype_cluster_input_database
    type: File?
    outputBinding:
      glob: |-
        ${
          if (inputs.prefix) {
            return inputs.prefix + '_genotype_clusters_database.csv'
          } else {
            return 'genotype_clusters_database.csv'
          }
        }
  - id: biometrics_genotype_plot_input
    type: File?
    outputBinding:
      glob: |-
        ${
          return 'genotype_comparison_input.html'
        }
  - id: biometrics_genotype_plot_input_database
    type: File?
    outputBinding:
      glob: |-
        ${
          return 'genotype_comparison_database.html'
        }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/biometrics:0.2.15'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
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
    'doap:name': biometrics
    'doap:revision': 0.2.15
