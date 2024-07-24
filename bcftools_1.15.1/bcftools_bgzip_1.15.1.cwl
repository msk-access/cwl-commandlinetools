class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: bgzip
baseCommand:
  - bgzip
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: stdout
    type: boolean
    inputBinding:
      position: 0
      prefix: '-c'
    doc: Stdandard output for bgzip
  - id: input
    type: File
    inputBinding:
      position: 10
    doc: input VCF file
  - id: output_file_name
    type: string?
    doc: Name of the output file
outputs:
  - id: zippedVcf
    type: File?
    outputBinding:
      glob: |-
        ${
            if (inputs.output_file_name) {
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.vcf/, '.vcf.gz')
            }
        }
label: bgzip
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 3
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/bcftools:1.15.1'
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
  - class: InlineJavascriptRequirement
stdout: |-
  ${
      if (inputs.output_file_name) {
          return inputs.output_file_name
      } else {
          return inputs.input.basename.replace(/.vcf/, '.vcf.gz')
      }
  }
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sivaprk@mskcc.org'
        'foaf:name': Karthigayini Sivaprakasam
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
    'doap:name': bgzip
    'doap:revision': 1.15.1
