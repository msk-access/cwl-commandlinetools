class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fastp_0_24_0
baseCommand:
  - fastp
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
    doc: 'worker thread number, default is 2 (int [=2])'
  - id: read1_input
    type: File
    inputBinding:
      position: 0
      prefix: '--in1'
    doc: |
      read1 input file name
  - id: read1_output_path
    type: string
    inputBinding:
      position: 0
      prefix: '--out1'
    doc: |
      read1 output file name
  - id: read2_input
    type: File?
    inputBinding:
      position: 0
      prefix: '--in2'
    doc: |
      read2 input file name, for PE data
  - id: read2_output_path
    type: string?
    inputBinding:
      position: 0
      prefix: '--out2'
    doc: |
      read2 output file name
  - id: unpaired1_path
    type: string?
    inputBinding:
      position: 0
      prefix: '--unpaired1'
    doc: >
      for PE input, if read1 passed QC but read2 not, it will be written to
      unpaired1.
  - id: unpaired2_path
    type: string?
    inputBinding:
      position: 0
      prefix: '--unpaired2'
    doc: >
      for PE input, if read2 passed QC but read1 not, it will be written to
      unpaired2.
  - id: failed_reads_path
    type: string?
    inputBinding:
      position: 0
      prefix: '--failed_out'
    doc: |
      specify the file to store reads that cannot pass the filters.
  - id: read1_adapter_sequence
    type: string?
    inputBinding:
      position: 0
      prefix: '--adapter_sequence'
    doc: >
      the adapter for read1. For SE data, if not specified, the adapter will be
      auto-detected. For PE data, this is used if R1/R2 are found not
      overlapped.
  - id: read2_adapter_sequence
    type: string?
    inputBinding:
      position: 0
      prefix: '--adapter_sequence_r2'
    doc: >
      the adapter for read2. For PE data, this is used if R1/R2 are found not
      overlapped.
  - id: minimum_read_length
    type: int?
    inputBinding:
      position: 0
      prefix: '--length_required'
    doc: |
      reads shorter than length_required will be discarded, default is 15.
  - id: maximum_read_length
    type: int?
    inputBinding:
      position: 0
      prefix: '--length_limit'
    doc: >
      reads longer than length_limit will be discarded, default 0 means no
      limitation.
  - id: trim_tail1
    type: int?
    inputBinding:
      position: 0
      prefix: '--trim_tail1'
    doc: >-
      trimming how many bases in tail for read1, default is 0 (int [=0])
  - id: --trim_tail2
    type: int?
    inputBinding:
      position: 0
      prefix: '--trim_tail2'
    doc: >-
      trimming how many bases in tail for read2. If it's not specified, it will follow read1's settings (int [=0])
  - id: max_len_read1
    type: int?
    inputBinding:
      position: 0
      prefix: '--max_len1'
    doc: >-
      if read1 is longer than max_len1, then trim read1 at its tail to make it
      as long as max_len1. Default 0 means no limitation
  - id: max_len_read2
    type: int?
    inputBinding:
      position: 0
      prefix: '--max_len2'
    doc: >-
      if read2 is longer than max_len2, then trim read2 at its tail to make it
      as long as max_len2. Default 0 means no limitation. If it's not specified,
      it will follow read1's settings
  - default: fastp.json
    id: json_output_path
    type: string
    inputBinding:
      position: 0
      prefix: '--json'
    doc: |
      the json format report file name
  - default: fastp.html
    id: html_output_path
    type: string
    inputBinding:
      position: 0
      prefix: '--html'
    doc: |
      the html format report file name
  - id: disable_quality_filtering
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable_quality_filtering'
    doc: >-
      quality filtering is enabled by default. If this option is specified,
      quality filtering is disabled
  - id: disable_trim_poly_g
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable_trim_poly_g'
    doc: >-
      disable polyG tail trimming, by default trimming is automatically enabled
      for Illumina NextSeq/NovaSeq data
  - id: disable_adapter_trimming
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable_adapter_trimming'
    doc: >-
      adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled
  - id: dont_eval_duplication
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--dont_eval_duplication'
    doc: >-
      don't evaluate duplication rate to save time and use less memory.
  - id: disable_length_filtering
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--disable_length_filtering'
  - id: verbose
    type: File?
    inputBinding:
      position: 0
      prefix: '--verbose'
    doc: output verbose log information (i.e. when every 1M reads are processed)
outputs:
  - id: fastp_json_output
    type: File
    outputBinding:
      glob: $(inputs.json_output_path)
  - id: fastp_html_output
    type: File
    outputBinding:
      glob: $(inputs.html_output_path)
  - id: fastp_read1_output
    type: File
    outputBinding:
      glob: $(inputs.read1_output_path)
  - id: fastp_read2_output
    type: File?
    outputBinding:
      glob: $(inputs.read2_output_path)
  - id: fastp_unpaired1_output
    type: File?
    outputBinding:
      glob: $(inputs.unpaired1_path)
  - id: fastp_unpaired2_output
    type: File?
    outputBinding:
      glob: $(inputs.unpaired2_path)
doc: Setup and execute Fastp
label: fastp_0.24.0
arguments:
  - position: 0
    prefix: '--thread'
    valueFrom: |-
      ${
          if(inputs.number_of_threads)
              return inputs.number_of_threads
          return (runtime.cores - 4)
      }
requirements:
  - class: ResourceRequirement
    ramMin: 24000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/fastp:0.20.1--h8b12597_0'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:fraihaa@mskcc.org'
        'foaf:name': Adrian Fraiha
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
    'doap:revision': 0.24.0
