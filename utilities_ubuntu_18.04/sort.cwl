class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
baseCommand:
  - sort
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: input
    type: 'File[]'
    inputBinding:
      position: 4
  - id: key
    type:
      type: array
      items: string
      inputBinding:
        prefix: '-k'
    inputBinding:
      position: 1
    doc: |
      -k, --key=POS1[,POS2]
      start a key at POS1, end it at POS2 (origin 1)
  - id: output
    type: string
outputs:
  - id: sorted
    doc: The sorted file
    type: File
    outputBinding:
      glob: $(inputs.output)
doc: |
  linux-sort.cwl is developed for CWL consortium and modified by Ronak Shah as MSKCC
  Reference https://github.com/common-workflow-language/workflows/blob/master/tools/linux-sort.cwl
arguments:
  - position: 0
    prefix: '-S'
    valueFrom: |-
     ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "8G"
        }
        else {
            return "8G"
        }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ubuntu:18.04'
  - class: InlineJavascriptRequirement
stdout: $(inputs.output)
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
    'doap:name': sort
    'doap:revision': 18.04

