class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
id: bedtools_merge
baseCommand:
  - bedtools
  - merge
inputs:
  - id: input
    type: File
    inputBinding:
      position: 5
      prefix: '-i'
      shellQuote: false
    doc: BEDgraph format file generated from Bedtools Genomecov module
  - id: output_file_name
    type: string?
  - id: memory_overhead
    type: int?
  - id: memory_per_job
    type: int?
  - id: number_of_threads
    type: int?
  - default: 0
    id: distance_between_features
    type: int?
    inputBinding:
      position: 0
      prefix: '-d'
      shellQuote: false
    doc: Maximum distance between features allowed for features to be merged.
outputs:
  - id: bedtools_merge_bed
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.output_file_name)
              return inputs.output_file_name;
            return inputs.input.basename.replace('.bedgraph', '.bed');
          }
label: bedtools_merge
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/bedtools:v2.28.0_cv2'
  - class: InlineJavascriptRequirement
stdout: |-
  ${
      if (inputs.output_file_name)
        return inputs.output_file_name;
      return inputs.input.basename.replace('.bedgraph', '.bed');
    }
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sumans@mskcc.org'
        'foaf:name': Shalabh Suman
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': bedtools
    'doap:revision': v2.28.0_cv2
