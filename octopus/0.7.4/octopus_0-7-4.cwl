class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
id: octopus_0_7_4
baseCommand:
  - octopus
inputs:
  - id: input
    type: 'File[]'
    inputBinding:
      position: 0
      prefix: '-I'
    secondaryFiles: ^.bai
    doc: Tumor and normal  bam files with .bai
  - id: normalId
    type: string?
    inputBinding:
      position: 0
      prefix: '-N'
    doc: add the name of the normal sample
  - id: tumorOnlySample
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-C'
    doc: mention this parameter if it is tumor only sample.
  - id: somaticOnlyCalls
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--somatics-only'
    doc: if somatics only call is required. Use this with -f ON parameter
  - id: targettedCalling_singleEntry
    type: string?
    inputBinding:
      position: 0
      prefix: '-T'
    doc: >-
      list of regions to call variants from.

      eg 1. chr1: all of chr1.

      2. chr2:10,000,000: the single position 10000000 in chr2.

      chr3:5,000,000-: everything from 3. chr3:5,000,000 onwards.

      4. chr4:100,000,000-200,000,000: everything between chr4:100,000,000 and
      chr4:200,000,000. The interval is half open so position chr4:200,000,000
      is not included.
  - id: skipRegions_singleEntry
    type: string?
    inputBinding:
      position: 0
      prefix: '-K'
    doc: to skip a set of regions
  - id: targettedCalling_file
    type: File?
    inputBinding:
      position: 0
      prefix: '-t'
    doc: regions in a text or bed file
  - id: skipRegions_file
    type: File?
    inputBinding:
      position: 0
      prefix: '-k'
    doc: regions in text or bed file format
  - id: error_models
    type: string?
    inputBinding:
      position: 0
      prefix: '--sequence-error-model'
    doc: >-
      error model will be in the format - [library preparation]<.sequencer>
      eg: PCR.NOVASEQ
  - id: reference
    type: File
    inputBinding:
      position: 0
      prefix: '-R'
    secondaryFiles:
      - .fai
  - id: output_file_name
    type: string
    inputBinding:
      position: 0
      prefix: '-o'
outputs:
  - id: outputVCF
    type: File
    outputBinding:
      glob: '${   if (inputs.output)     return inputs.output;   return null; }'
label: octopus
requirements:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/octopus:0.7.4'
  - class: InlineJavascriptRequirement
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
    'doap:name': octopus
    'doap:revision': 0.7.4

