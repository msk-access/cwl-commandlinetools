class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_downsamplesam_4_1_8_1
baseCommand:
  - gatk
  - DownsampleSam
inputs:
  - id: input
    type: File
    inputBinding:
      position: 3
      prefix: '--INPUT'
    doc: BAM/SAM file containing reads
    secondaryFiles:
      - ^.bai
  - id: reference
    type: File
    inputBinding:
      position: 3
      prefix: '--REFERENCE_SEQUENCE'
    doc: Reference sequence file
    secondaryFiles:
      - .fai
      - ^.dict
  - id: output_file_name
    type: string?
    doc: Output file name. Not Required
  - id: output_metrics_file_name
    type: string?
    doc: Output file name for metrics file. Not Required
  - id: probability
    type: float?
    inputBinding:
      position: 4
      prefix: '--PROBABILITY'
    doc: 'The probability of keeping any individual read, between 0 and 1.'
  - id: random_seed
    type: int?
    inputBinding:
      position: 4
      prefix: '--RANDOM_SEED'
    doc: >-
      Random seed used for deterministic results. Setting to null will cause
      multiple invocations to produce different results.
  - id: strategy
    type: string?
    inputBinding:
      position: 4
      prefix: '--STRATEGY'
    doc: >-
      The --STRATEGY argument is an enumerated type (Strategy), which can have
      one of the following values:


      HighAccuracy

      ConstantMemory

      Chained

      default Strategy  ConstantMemory
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          position: 0
          prefix: '--arguments_file'
  - id: create_output_bam_index
    type: boolean?
    inputBinding:
      position: 10
      prefix: '--CREATE_INDEX'
  - id: create_output_bam_md5
    type: boolean?
    inputBinding:
      position: 10
      prefix: '--CREATE_MD5_FILE'
  - id: QUIET
    type: boolean?
    inputBinding:
      position: 10
      prefix: '--QUIET'
  - id: "validation_stringency"
    type: string?
    inputBinding:
      position: 6
      prefix: '--VALIDATION_STRINGENCY'
  - id: number_of_threads
    type: int?
  - id: memory_per_job
    type: int?
  - id: memory_overhead
    type: int?
  - id: temporary_directory
    type: string?
    doc: 'Default value: null.'
outputs:
  - id: gatk_downsamplesam_output_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_downsamplesam.bam')
            }
        }
    secondaryFiles:
      - ^.bai
  - id: gatk_downsamplesam_output_metrics
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_metrics_file_name){
                return inputs.output_metrics_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_downsamplesam.metrics')
            }
        }
label: gatk_downsample_sam_4.1.8.1
arguments:
  - position: 0
    prefix: '--java-options'
    valueFrom: |-
      ${
           if(inputs.memory_per_job && inputs.memory_overhead){
              if(inputs.memory_per_job % 1000 == 0){
                  return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
              } else {
                  return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
              }
           } else if (inputs.memory_per_job && !inputs.memory_overhead){
              if(inputs.memory_per_job % 1000 == 0) {
                  return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
              } else {
                  return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
              }
           } else if(!inputs.memory_per_job && inputs.memory_overhead){
              return "-Xmx24G"
           } else {
              return "-Xmx24G"
           }
      }
  - position: 2
    prefix: '--TMP_DIR'
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 2
    prefix: '--OUTPUT'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_downsamplesam.bam')
          }
      }
  - position: 2
    prefix: '--METRICS_FILE'
    valueFrom: |-
      ${
          if(inputs.output_metrics_file_name){
              return inputs.output_metrics_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_downsamplesam.metrics')
          }
      }
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gatk:4.1.8.1'
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
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
