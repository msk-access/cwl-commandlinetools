class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: maf_annotated_by_bed
baseCommand:
  - pv
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: input_maf
    type: File
    inputBinding:
      position: 0
      prefix: '-m'
  - id: input_bed
    type: File
    inputBinding:
      position: 1
      prefix: '-b'
  - id: output_filename
    type: string
    inputBinding:
      position: 3
      prefix: '-o'
  - 'sbg:toolDefaultValue': annotation
    id: column_name
    type: string?
    inputBinding:
      position: 4
      prefix: '-c'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.output_filename) {
                return inputs.output_filename
            } else {
                return inputs.input_maf.basename.replace('.maf', '_mafAnnotatedByBed.maf')
            }
        }
label: maf_annotated_by_bed
arguments:
  - maf
  - annotate
  - mafbybed
  - position: 2
    prefix: '--output'
    valueFrom: |-
      ${
          if(inputs.output_filename){
              return inputs.output_filename
          } else {
              return inputs.input_maf.basename.replace('.maf', '_mafAnnotatedByBed')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/postprocessing_variant_calls:0.2.3'
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
        'foaf:mbox': 'mailto:sivaprk@mskcc.org'
        'foaf:name': Karthigayini Sivaprakasam
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': postprocessing_variant_calls
    'doap:revision': 0.2.3
