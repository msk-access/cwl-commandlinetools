class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vardict_var2vcf
baseCommand:
  - perl
  - /usr/bin/vardict/bin/var2vcf_valid.pl
inputs:
  - id: 'N'
    type: string?
    doc: Tumor Sample Name
  - id: S
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-S'
    doc: If set variants that didnt pass filters will not be present in VCF file.
  - id: f
    type: float?
    inputBinding:
      position: 0
      prefix: '-f'
    doc: 'The threshold for allele frequency, default - 0.05 or 5%%'
  - id: input_vcf
    type: File?
  - id: vcf
    type: string
    doc: output vcf file
outputs:
  - id: output
    type: File
    outputBinding:
      glob: '${ return inputs.vcf; }'
arguments:
  - position: 0
    prefix: '-N'
    valueFrom: |-
      ${
          return inputs.N + "|" + inputs.N2;
      }
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/vardictjava:1.8.2'
  - class: InlineJavascriptRequirement
stdin: $(inputs.input_vcf.path)
stdout: '${ return inputs.vcf; }'
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
