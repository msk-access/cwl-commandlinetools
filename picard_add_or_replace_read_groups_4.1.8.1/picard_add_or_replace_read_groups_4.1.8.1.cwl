class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: picard_add_or_replace_read_groups_4.1.8.1
baseCommand:
  - java
inputs:
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: number_of_threads
    type: int?
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '-I'
    doc: Input file ( sam).  Required.
  - id: output_file_name
    type: string?
    doc: Output file name (bam or sam). Not Required
  - id: sort_order
    type: string?
    inputBinding:
      position: 0
      prefix: '-SO'
    doc: >-
      Optional sort order to output in. If not supplied OUTPUT is in the same
      order as INPUT.Default value: null. Possible values: {unsorted, queryname,
      coordinate}
  - id: read_group_identifier
    type: string
    inputBinding:
      position: 0
      prefix: '--RGID'
    doc: >-
      Read Group ID  Default value: 1. This option can be set to 'null' to clear
      the default value  Required
  - id: read_group_sequencing_center
    type: string
    inputBinding:
      position: 0
      prefix: '--RGCN'
    doc: 'Read Group sequencing center name  Default value: null. Required'
  - id: read_group_library
    type: string
    inputBinding:
      position: 0
      prefix: '--RGLB'
    doc: Read Group Library.  Required
  - id: read_group_platform_unit
    type: string
    inputBinding:
      position: 0
      prefix: '--RGPU'
    doc: Read Group platform unit (eg. run barcode)  Required.
  - id: read_group_sample_name
    type: string
    inputBinding:
      position: 0
      prefix: '--RGSM'
    doc: Read Group sample name.  Required
  - id: read_group_sequencing_platform
    type: string
    inputBinding:
      position: 0
      prefix: '--RGPL'
    doc: 'Read Group platform (e.g. illumina, solid)  Required.'
  - id: read_group_description
    type: string?
    inputBinding:
      position: 0
      prefix: '--RGDS'
    doc: 'Read Group description  Default value: null.'
  - id: read_group_run_date
    type: string?
    inputBinding:
      position: 0
      prefix: '--RGDT'
    doc: 'Read Group run date  Default value: null.'
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
  - id: bam_compression_level
    type: int?
    inputBinding:
      position: 0
      prefix: '--COMPRESSION_LEVEL'
    doc: >-
      Compression level for all compressed files created (e.g. BAM and GELI).
      Default value:5. This option can be set to 'null' to clear the default
      value.
  - id: use_jdk_deflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--USE_JDK_DEFLATER'
    doc: >-
      Use the JDK Deflater instead of the Intel Deflater for writing compressed
      output
  - id: use_jdk_inflater
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--USE_JDK_INFLATER'
    doc: >-
      Use the JDK Inflater instead of the Intel Inflater for reading compressed
      input
  - default: true
    id: create_bam_index
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--CREATE_INDEX'
    doc: >-
      Whether to create a BAM index when writing a coordinate-sorted BAM file.
      Default value:false. This option can be set to 'null' to clear the default
      value. Possible values:{true, false}
  - id: temporary_directory
    type: string?
    doc: 'Default value: null. This option may be specified 0 or more times.'
outputs:
  - id: picard_add_or_replace_read_groups_bam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name)
                return inputs.output_file_name;
            return inputs.input.basename.replace(/.sam$/, '_srt.bam');
        }
    secondaryFiles:
      - ^.bai
label: picard_add_or_replace_read_groups_4.1.8.1
arguments:
  - position: 0
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
    prefix: '-Djava.io.tmpdir='
    separate: false
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 0
    shellQuote: false
    valueFrom: '-XX:-UseGCOverheadLimit'
  - position: 0
    prefix: '-jar'
    valueFrom: /gatk/gatk-package-4.1.8.1-local.jar
  - position: 0
    valueFrom: AddOrReplaceReadGroups
  - position: 0
    prefix: '--TMP_DIR'
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 0
    prefix: '-O'
    valueFrom: |-
      ${
          if(inputs.output_file_name)
              return inputs.output_file_name;
            return inputs.input.basename.replace(/.sam$/, '_srt.bam');
      }
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/gatk:4.1.8.1'
  - class: InlineJavascriptRequirement
'dct:contributor':
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
        'foaf:mbox': 'mailto:shahr2@mskcc.org'
        'foaf:name': Ronak Shah
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': picard
    'doap:revision': 4.1.8.1
