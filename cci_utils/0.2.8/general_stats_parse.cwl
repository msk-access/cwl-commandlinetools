class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: general_stats_parse
baseCommand:
  - general_stats_parse.py
arguments:
  - --dir
  - .
inputs:
  - id: directory
    type: Directory
    doc: Directory containing results.
  - id: samples-json
    type: File
    inputBinding:
      prefix: '--samples-json'
    doc: Sample JSON file.
  - id: config
    type: File
    inputBinding:
      prefix: '--config'
    doc: MultQC config file.
outputs:
  - id: aggregate_parsed_stats
    label: aggregate_parsed_stats
    type: Directory
    outputBinding:
      glob: .
      outputEval: |-
        ${
            self[0].basename = "aggregate_parsed_stats";
            return self[0]
        }
label: general_stats_parse
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/cci_utils:0.2.8'
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.directory)
        writable: true
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
