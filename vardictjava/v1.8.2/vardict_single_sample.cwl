class: Workflow
cwlVersion: v1.0
id: vardict
label: vardict
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: bedfile
    type: File?
    'sbg:x': 0
    'sbg:y': 426.4375
  - id: input_bam_control
    type: File?
    secondaryFiles:
      - ^.bai
    'sbg:x': 0
    'sbg:y': 213.21875
  - id: input_bam_case
    type: File
    secondaryFiles:
      - ^.bai
    'sbg:x': 0
    'sbg:y': 319.828125
  - id: reference_fasta
    type: File
    secondaryFiles:
      - .fai
    'sbg:x': 0
    'sbg:y': 106.609375
  - id: sample_name
    type: string
    'sbg:x': 0
    'sbg:y': 0
  - id: bed_file_column_for_region_start
    type: string?
    'sbg:x': 0
    'sbg:y': 533.109375
  - id: bed_file_column_for_region_end
    type: string?
    'sbg:x': 0
    'sbg:y': 639.84375
  - id: bed_file_column_for_gene_name
    type: string?
    'sbg:x': 0
    'sbg:y': 746.578125
  - id: bed_file_column_for_chromsome
    type: string?
    'sbg:x': 0
    'sbg:y': 853.25
  - id: control_sample_name
    type: string?
    'sbg:x': 742.6807250976562
    'sbg:y': 639.90625
  - id: filter_variants
    type: boolean?
    'sbg:x': 742.6807250976562
    'sbg:y': 533.296875
  - id: output_vcf
    type: string
    'sbg:x': 742.6807250976562
    'sbg:y': 319.953125
  - id: vardict_allele_frequency_threshold
    type: float?
    'sbg:x': 262.4856872558594
    'sbg:y': 727.823486328125
outputs:
  - id: output
    outputSource:
      - var_to_vcf/output
    type: File
    'sbg:x': 1332.159423828125
    'sbg:y': 426.625
steps:
  - id: teststrandbias
    in:
      - id: input_vardict
        source: vardict/output
    out:
      - id: output_var
    run: ./teststrandbias.cwl
    'sbg:x': 742.6807250976562
    'sbg:y': 213.34375
  - id: var_to_vcf
    in:
      - id: case_sample_name
        source: sample_name
      - id: control_sample_name
        source: control_sample_name
      - id: filter_variants
        source: filter_variants
      - id: minimum_allele_frequency
        source: vardict_allele_frequency_threshold
      - id: input_vcf
        source: teststrandbias/output_var
      - id: output_vcf
        source: output_vcf
    out:
      - id: output
    run: ./var_to_vcf.cwl
    'sbg:x': 1006.1338500976562
    'sbg:y': 391.4296875
  - id: vardict
    in:
      - id: bed_file_column_for_region_end
        source: bed_file_column_for_region_end
      - id: reference_fasta
        source: reference_fasta
      - id: sample_name
        source: sample_name
      - id: bed_file_column_for_region_start
        source: bed_file_column_for_region_start
      - id: input_bam_case
        source: input_bam_case
      - id: input_bam_control
        source: input_bam_control
      - id: bedfile
        source: bedfile
      - id: bed_file_column_for_chromsome
        source: bed_file_column_for_chromsome
      - id: allele_frequency_threshold
        source: vardict_allele_frequency_threshold
      - id: bed_file_column_for_gene_name
        source: bed_file_column_for_gene_name
    out:
      - id: output
    run: ./vardict_app.cwl
    'sbg:x': 317.125
    'sbg:y': 363.625
requirements: []
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
