class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: oncokb_annotator
baseCommand:
  - python3
  - /oncokb/MafAnnotator.py
inputs:
  - id: inputMafFile
    type: File
    inputBinding:
      position: 0
      prefix: '-i'
    doc: input maf file for annotation
  - id: outputMafName
    type: string
    inputBinding:
      position: 0
      prefix: '-o'
  - id: apiToken
    type: string
    inputBinding:
      position: 0
      prefix: '-b'
    doc: OncoKB API token
  - id: previousResult
    type: File?
    inputBinding:
      position: 0
      prefix: '-p'
  - id: clinicalFile
    type: File?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: |-
      Essential clinical columns:
          SAMPLE_ID: sample ID
          ONCOTREE_CODE: tumor type code from oncotree (http://oncotree.mskcc.org)
  - id: tumorType
    type: string?
    inputBinding:
      position: 0
      prefix: '-t'
    doc: |-
      Cancer type will be assigned based on the following priority:
          1) ONCOTREE_CODE in clinical data file
          2) ONCOTREE_CODE exist in MAF
          3) default tumor type (-t)
  - id: referenceGenome
    type: string?
    inputBinding:
      position: 0
      prefix: '-r'
    doc: |-
      Reference Genome only allows the following values(case-insensitive):
          - GRCh37
            GRCh38
outputs:
  - id: outputMaf
    type: File?
    outputBinding:
      glob: $(inputs.outputMafName)
label: oncokb_annotator
requirements:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/oncokbannotator:3.2.2'
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
    'doap:name': oncoKb Annotator
    'doap:revision': 3.2.2
