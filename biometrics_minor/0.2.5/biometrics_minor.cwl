class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: biometrics_minor
baseCommand:
  - biometrics
  - minor
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 0
    doc: >-
      Can be one of three types: (1) path to a CSV file containing sample information (one per line). For example: sample_name,sample_bam,sample_type,sample_sex,sample_group. (2) Path to a '*.pk' file that was produced by the 'extract' tool. (3) Name of the sample to analyze; this assumes there is a file named '{sample_name}.pk' in your database directory. Can be specified more than once.
  - id: database
    type: string?
    inputBinding:
      position: 0
      prefix: --database
    doc: >-
      Directory to store the intermediate files after running the extraction step.
  - id: minor_threshold
    type: float?
    default: 0.002
    inputBinding:
      position: 0
      prefix: --minor-threshold
    doc: >-
      Minor contamination threshold for bad sample.
  - id: prefix
    type: string?
    inputBinding:
      position: 0
      prefix: --prefix
    doc: >-
      Output file prefix.
  - id: plot
    type: boolean?
    inputBinding:
      position: 0
      prefix: --plot
    doc: >-
      Also output plots of the data.
  - id: json
    type: boolean?
    inputBinding:
      position: 0
      prefix: --json
    doc: >-
      Also output data in JSON format.
  - id: no_db_comparison
    type: boolean?
    inputBinding:
      position: 0
      prefix: --no-db-compare
    doc: >-
      Do not compare the sample(s) you provided to all samples in the database, only compare them with each other.
outputs:
  - id: biometrics_minor_csv
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '_minor_contamination.csv'
            } else {
              return 'minor_contamination.csv'
            }
        }
  - id: biometrics_minor_json
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '_minor_contamination.json'
            } else {
              return 'minor_contamination.json'
            }
        }
  - id: biometrics_minor_plot
    type: File?
    outputBinding:
      glob: |-
        ${
          return 'minor_contamination.html'
        }
  - id: biometrics_minor_sites_plot
    type: File?
    outputBinding:
      glob: |-
        ${
          return 'minor_contamination_sites.html'
        }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/biometrics:0.2.5'
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
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': biometrics
    'doap:revision': 0.2.5
