class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: biometrics_major_0_2_15
baseCommand:
  - biometrics
  - major
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: '--input'
    inputBinding:
      position: 0
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
  - default: 0.6
    id: major_threshold
    type: float?
    inputBinding:
      position: 0
      prefix: '--major-threshold'
    doc: Major contamination threshold for bad sample.
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
outputs:
  - id: biometrics_major_csv
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '_major_contamination.csv'
            } else {
              return 'major_contamination.csv'
            }
        }
  - id: biometrics_major_json
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.prefix) {
              return inputs.prefix + '_major_contamination.json'
            } else {
              return 'major_contamination.json'
            }
        }
  - id: biometrics_major_plot
    type: File?
    outputBinding:
      glob: |-
        ${
          return 'major_contamination.html'
        }
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 4
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
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': biometrics
    'doap:revision': 0.2.15
