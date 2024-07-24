class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: gatk_mean_quality_by_cycle_4_1_8_0
baseCommand:
  - gatk
  - MeanQualityByCycle
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
    doc: An aligned SAM or BAM file.  Required.
  - id: output_file_name
    type: string?
    doc: The output file to write the metrics to.
  - id: chart_output
    type: string?
    doc: A file (with .pdf extension) to write the chart to.
  - id: assume_sorted
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--ASSUME_SORTED'
    doc: |
      If true (default), then the sort order in the header file will be ignored.
  - id: pf_reads_only
    type: boolean?
    inputBinding:
      position: 1
      prefix: '--PF_READS_ONLY'
    doc: |
      If set to true calculate mean quality over PF reads only.  Default value: false. Possible values: {true, false}
  - id: reference
    type: File?
    inputBinding:
      position: 0
      prefix: '-R'
    doc: >-
      Reference sequence file. Note that while this argument is not required,
      without it only a small subset of the metrics will be calculated. Note
      also that if a reference sequence is provided, it must be accompanied by a
      sequence dictionary.  Default value: null.
    secondaryFiles:
      - ^.fasta.fai
      - ^.dict
  - id: validation_stringency
    type: string?
    inputBinding:
      position: 0
      prefix: '--VALIDATION_STRINGENCY'
    doc: >-
      Validation stringency for all SAM files read by this program.  Setting
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need
      to be decoded.  Default value: STRICT. This option can be set to 'null' to
      clear the default value. Possible values: {STRICT,LENIENT, SILENT}
  - id: create_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_INDEX'
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value: false. Possible values: {true, false}
  - id: create_md5_file
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_MD5_FILE'
    doc: >-
      Whether to create an MD5 digest for any BAM or FASTQ files created.
      Default value: false. Possible values: {true, false}
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: temporary_directory
    type: string?
    doc: >-
      Directory with space available to be used by this program for temporary storage of working files.
outputs:
  - id: gatk_mean_quality_by_cycle_output
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name){
                return inputs.output_file_name
            } else {
                return inputs.input.basename.replace(/.bam/, '_mean_quality_by_cycle.txt')
            }
        }
  - id: gatk_mean_quality_by_cycle_chart_output
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.chart_output){
                return inputs.chart_output
            } else {
                return inputs.input.basename.replace(/.bam/, '_mean_quality_by_cycle.pdf')
            }
        }
label: GATK-MeanQualityByCycle
arguments:
  - position: 0
    prefix: '--java-options'
    valueFrom: |-
      ${
        if(inputs.memory_per_job && inputs.memory_overhead) {
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if (inputs.memory_per_job && !inputs.memory_overhead){
          if(inputs.memory_per_job % 1000 == 0) {
            return "-Xmx" + (inputs.memory_per_job/1000).toString() + "G"
          }
          else {
            return "-Xmx" + Math.floor((inputs.memory_per_job/1000)).toString() + "G"
          }
        }
        else if(!inputs.memory_per_job && inputs.memory_overhead){
          return "-Xmx24G"
        }
        else {
            return "-Xmx24G"
        }
      }
  - position: 0
    prefix: '--TMP_DIR'
    valueFrom: |-
      ${
          if(inputs.temporary_directory) {
            return inputs.temporary_directory;
          }
          return runtime.tmpdir;
      }
  - position: 0
    prefix: '-O'
    valueFrom: |-
      ${
          if(inputs.output_file_name){
              return inputs.output_file_name
          } else {
              return inputs.input.basename.replace(/.bam/, '_mean_quality_by_cycle.txt')
          }
      }
  - position: 0
    prefix: '--CHART_OUTPUT'
    valueFrom: |-
      ${
          if(inputs.chart_output){
              return inputs.chart_output
          } else {
              return inputs.input.basename.replace(/.bam/, '_mean_quality_by_cycle.pdf')
          }
      }

requirements:
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gatk:4.1.8.0'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charles Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charles Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': gatk4
    'doap:revision': 4.1.8.0
