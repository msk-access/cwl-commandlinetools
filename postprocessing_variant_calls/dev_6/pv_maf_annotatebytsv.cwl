class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: pv_maf_annotated_by_tsv
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
  - 'sbg:toolDefaultValue': output.maf
    id: output_maf_name
    type: string?
    inputBinding:
      position: 0
      prefix: '-o'
  - 'sbg:toolDefaultValue': tsv
    id: output_column_name
    type: string?
    inputBinding:
      position: 0
      prefix: '-oc'
  - id: input_tsv_file
    type: File
    inputBinding:
      position: 1
      prefix: '-t'
  - id: separator
    type: string?
    inputBinding:
      position: 0
      prefix: '-sep'
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: |-
        ${ 
            if (inputs.output_maf_name) { 
                return inputs.output_maf_name 
            } else { 
                return inputs.input_maf.basename.replace('.maf', '_maftagcmoCh.maf') 
            } 
        }
label: pv_maf_annotatedByTsv
arguments:
  - maf
  - annotate
  - mafbytsv
  - position: 2
    prefix: '--output'
    valueFrom: |-
      ${ 
          if (inputs.output_maf_name) { 
              return inputs.output_maf_name 
          } else { 
              return inputs.input_maf.basename.replace('.maf', '_maftagcmoCh.maf') 
          } 
      }
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/postprocessing_variant_calls:dev7'
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
    'doap:revision': dev6
