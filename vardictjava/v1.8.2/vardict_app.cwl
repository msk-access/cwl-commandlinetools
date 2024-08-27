class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: vardict
baseCommand:
  - /usr/bin/vardict/bin/VarDict
inputs:
  - id: bed_file_column_for_region_end
    type: string?
    inputBinding:
      position: 0
      prefix: '-E'
    doc: 'The column for region end, e.g. gene end'
  - id: reference_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '-G'
    doc: The reference fasta. Should be indexed (.fai)
    secondaryFiles:
      - .fai
  - id: sample_name
    type: string?
    inputBinding:
      position: 0
      prefix: '-N'
    doc: The sample name of the case to be used directly.  Will overwrite -n option
  - id: bed_file_column_for_region_start
    type: string?
    inputBinding:
      position: 0
      prefix: '-S'
    doc: 'The column for region start, e.g. gene start'
  - id: input_bam_case
    type: File
    doc: The indexed BAM file for case
    secondaryFiles:
      - ^.bai
  - id: input_bam_control
    type: File?
    doc: The indexed BAM file for control
    secondaryFiles:
      - ^.bai
  - id: bedfile
    type: File?
    inputBinding:
      position: 1
  - id: bed_file_column_for_chromsome
    type: string?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: The column for chromosome
  - id: allele_frequency_threshold
    type: float?
    inputBinding:
      position: 0
      prefix: '-f'
      valueFrom: '${ return inputs.allele_frequency_threshold.toString(); }'
    doc: 'The threshold for allele frequency, default - 0.01 or 1%%'
  - id: bed_file_column_for_gene_name
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
          if(inputs.input_bam_control)
              return inputs.input_bam_case + "|" + inputs.input_bam_control;
          return inputs.input_bam_case

      }
requirements:
  - class: EnvVarRequirement
    envDef:
      JAVA_OPTS: '"-Xms8g" "-Xmx24g"'
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 16
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
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': Vardictjava
    'doap:revision': 1.8.2
