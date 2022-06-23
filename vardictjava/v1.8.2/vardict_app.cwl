class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vardict
baseCommand:
  - /usr/bin/vardict/bin/VarDict
inputs:
  - id: E
    type: string?
    inputBinding:
      position: 0
      prefix: '-E'
    doc: 'The column for region end, e.g. gene end'
  - id: G
    type: File
    inputBinding:
      position: 0
      prefix: '-G'
    doc: The reference fasta. Should be indexed (.fai)
    secondaryFiles:
      - .fai
  - id: 'N'
    type: string?
    doc: Tumor Sample Name
  - id: S
    type: string?
    inputBinding:
      position: 0
      prefix: '-S'
    doc: 'The column for region start, e.g. gene start'
  - id: b
    type: File?
    doc: Tumor bam
    secondaryFiles:
      - ^.bai
  - id: bedfile
    type: File?
    inputBinding:
      position: 1
  - id: c
    type: string?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: The column for chromosome
  - id: f
    type: int?
    inputBinding:
      position: 0
      prefix: '-f'
    doc: 'The threshold for allele frequency, default - 0.01 or 1%%'
  - id: g
    type: string?
    inputBinding:
      position: 0
      prefix: '-g'
    doc: 'The column for gene name, or segment annotation'
outputs:
  - id: output
    type: File
    outputBinding:
      glob: vardict_app_output.vcf
arguments:
  - position: 1
    prefix: '-b'
    valueFrom: |-
      ${
          return inputs.b.path;
      }
requirements:
  - class: EnvVarRequirement
    envDef:
      JAVA_OPTS: '"-Xms8g" "-Xmx95g"'
  - class: ResourceRequirement
    ramMin: 64000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/vardictjava:1.8.2'
  - class: InlineJavascriptRequirement
stdout: vardict_app_output.vcf
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:vurals@mskcc.org'
        'foaf:name': Suleyman Vural
    'foaf:name': Memorial Sloan Kettering Cancer Center
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': Vardictjava
    'doap:revision': 1.8.2
