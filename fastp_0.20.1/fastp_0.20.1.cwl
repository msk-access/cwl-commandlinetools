class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fastp_0_20_1
baseCommand:
  - fastp
inputs:
  - id: read1_input
    type: File
    inputBinding:
      prefix: '--in1'
    doc: |
        read1 input file name
  - id: read1_output_path
    type: string
    inputBinding:
      prefix: '--out1'
    doc: |
        read1 output file name
  - id: read2_input
    type: File?
    inputBinding:
      prefix: '--in2'
    doc: |
        read2 input file name, for PE data
  - id: read2_output_path
    type: string?
    inputBinding:
      prefix: '--out2'
    doc: |
        read2 output file name
  - id: unpaired1_path
    type: string?
    inputBinding:
      prefix: '--unpaired1'
    doc: |
        for PE input, if read1 passed QC but read2 not, it will be written to unpaired1. 
  - id: unpaired2_path
    type: string?
    inputBinding:
      prefix: '--unpaired2'
    doc: |
        for PE input, if read2 passed QC but read1 not, it will be written to unpaired2.
  - id: failed_reads_path
    type: string?
    inputBinding:
      prefix: '--failed_out'
    doc: |
        specify the file to store reads that cannot pass the filters.
  - id: read1_adapter_sequence
    type: string?
    inputBinding:
        prefix: '--adapter_sequence'
    doc: |
         the adapter for read1. For SE data, if not specified, the adapter will be auto-detected. For PE data, this is used if R1/R2 are found not overlapped.
  - id: read2_adapter_sequence
    type: string?
    inputBinding:
        prefix: '--adapter_sequence_r2'
    doc: |
         the adapter for read2. For PE data, this is used if R1/R2 are found not overlapped.
  - id: minimum_read_length
    type: int?
    inputBinding:
        prefix: '--length_required'
    doc: |
        reads shorter than length_required will be discarded, default is 15.

  - id: json_output_path 
    type: string
    inputBinding:
        prefix: '--json'
    doc: |
         the json format report file name
  - id: html_output_path 
    type: string
    inputBinding:
        prefix: '--html'
    doc: |
         the html format report file name

outputs:
  - id: json_output
    type: File
    outputBinding:
      glob: $(inputs.json_output_path)
  - id: html_output
    type: File
    outputBinding:
      glob: $(inputs.html_output_path)
  - id: read1_output
    type: File
    outputBinding:
      glob: $(inputs.read1_output_path)
  - id: read2_output
    type: File?
    outputBinding:
      glob: $(inputs.read2_output_path)

doc: Setup and execute Fastp
label: fastp_0.20.1
requirements:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/fastp:0.20.1--h8b12597_0'
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
'doap:release':
  - class: 'doap:Version'
    'doap:name': fastp
    'doap:revision': 0.20.1
