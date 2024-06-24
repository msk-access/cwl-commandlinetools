class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: marianas_process_loop_umi_cwl
baseCommand:
  - java
inputs:
  - id: fastq1
    type: File
    inputBinding:
      position: 1
  - id: fastq2
    type: File
    inputBinding:
      position: 2
  - id: umi_length
    type: int
    inputBinding:
      position: 3
  - id: memory_per_job
    type: int?
    inputBinding:
      position: 0
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    inputBinding:
      position: 0
outputs:
  - id: marianas_process_loop_umi_processed_fastq_1
    type: File
    outputBinding:
      glob: '$(inputs.fastq1.basename.replace(''.fastq.gz'', ''_umi-clipped.fastq.gz''))'
  - id: marianas_process_loop_umi_processed_fastq_2
    type: File
    outputBinding:
      glob: '$(inputs.fastq2.basename.replace(''.fastq.gz'', ''_umi-clipped.fastq.gz''))'
  - id: marianas_process_loop_umi_clipping_info
    type: File
    outputBinding:
      glob: info.txt
  - id: marianas_process_loop_umi_composite_umi_frequencies
    type: File
    outputBinding:
      glob: composite-umi-frequencies.txt
label: marianas_process_loop_umi.cwl
arguments:
  - position: 0
    valueFrom: '-server'
  - position: 0
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xms" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xms" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xms8G"
        }
        else {
            return "-Xms8G"
        }
      }
  - position: 0
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xmx24G"
        }
        else {
            return "-Xmx24G"
        }
      }
  - position: 0
    prefix: '-cp'
    valueFrom: /usr/local/bin/Marianas-1.8.1.jar
  - position: 0
    valueFrom: org.mskcc.marianas.umi.duplex.fastqprocessing.ProcessLoopUMIFastq
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/marianas:1.8.1'
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
        'foaf:mbox': 'mailto:johnsoni@mskcc.org'
        'foaf:name': Ian Johnson
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': marianas
    'doap:revision': 1.8.1
  - class: 'doap:Version'
    'doap:name': cwl-wrapper
    'doap:revision': 1.0.0
