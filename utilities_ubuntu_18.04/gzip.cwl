class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
id: gzip
baseCommand:
  - gzip
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: input
    type: File
    inputBinding:
      position: 100
    doc: Input file.
  - id: to_stdout
    type: boolean?
    default: true
    inputBinding:
      position: 0
      prefix: '-c'
    doc: 'write to stdout, keep original files'
  - id: decompress
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-d'
    doc: uncompress files
  - id: recursive
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-r'
    doc: recursively compress files in directories
  - id: output
    type: string?
    doc: output file name (optional)
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: |-
        ${
          if (inputs.output) {
              return inputs.output;
          }
          else if (inputs.to_stdout && !inputs.decompress){
              return (inputs.input.basename + '.gz');
          }
          else if (inputs.to_stdout && inputs.decompress) {
              return inputs.input.basename.replace('.gz', '');
          }
          else{
              return (inputs.input.basename + '.gz');
          }
        }
label: gzip
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ubuntu:18.04'
  - class: InlineJavascriptRequirement
stdout: |-
  ${
    if (inputs.output) {
        return inputs.output;
    }
    else if (inputs.to_stdout && !inputs.decompress){
        return (inputs.input.basename + '.gz');
    }
    else if (inputs.to_stdout && inputs.decompress) {
        return inputs.input.basename.replace('.gz', '');
    }
    else{
        return (inputs.input.basename + '.gz');
    }
  }
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
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': gzip
    'doap:revision': 18.04
