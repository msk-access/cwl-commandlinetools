class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fgbio_postprocessing_simplex_filter_0.1.7
baseCommand:
  - simplex_filter
inputs:
  - id: input_bam
    type: File
    inputBinding:
      prefix: --input_bam
    doc: Input file (bam or sam).  Required.
  - id: output_file_name
    type: string?
    inputBinding:
      prefix: --output_filename
    doc: Output file (bam or sam).
  - id: min_simplex_reads
    type: int?
    inputBinding:
      prefix: --min_simplex_reads
    doc: Minimum number of simplex reads to pass filter for consensus reads
outputs:
  - id: fgbio_postprocessing_simplex_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input_bam.basename.replace(/.bam/,'_simplex.bam')
            }
        }
    secondaryFiles:
      - ^.bai
label: fgbio_postprocessing_simplex_filter_0.1.7
requirements:
  - class: ResourceRequirement
    ramMin: 2000
    coresMin: 1
  - class: DockerRequirement
    dockerPull: 'mskaccess/fgbio_postprocessing:0.2.0'
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
'doap:release':
  - class: 'doap:Version'
    'doap:name': fgbio_postprocessing
    'doap:revision': 0.1.7
