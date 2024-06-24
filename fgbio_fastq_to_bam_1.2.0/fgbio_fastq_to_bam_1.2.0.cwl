class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: fgbio_fastq_to_bam_1_2_0
baseCommand:
  - fgbio
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
    type: 'File[]'
    inputBinding:
      position: 2
      prefix: '--input'
      itemSeparator: ' '
      shellQuote: false
    label: PathToFastq
    doc: 'Fastq files corresponding to each sequencing read (e.g. R1, I1, etc.).'
  - id: output_file_name
    type: string?
    doc: The output SAM or BAM file to be written.
  - id: read-structures
    type: 'string[]?'
    inputBinding:
      position: 2
      prefix: '--read-structures'
      itemSeparator: ' '
      shellQuote: false
    doc: >-
      Read structures, one for each of the FASTQs.
      https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures
  - id: sort
    type: boolean?
    inputBinding:
      position: 2
      prefix: '--sort'
      shellQuote: false
    doc: 'If true, queryname sort the BAM file, otherwise preserve input order.'
  - id: umi-tag
    type: string?
    inputBinding:
      position: 2
      prefix: '--umi-tag'
      shellQuote: false
    doc: Tag in which to store molecular barcodes/UMIs
  - id: read-group-id
    type: string?
    inputBinding:
      position: 2
      prefix: '--read-group-id'
      shellQuote: false
    doc: Read group ID to use in the file header.
  - id: sample
    type: string?
    inputBinding:
      position: 2
      prefix: '--sample'
      shellQuote: false
    doc: The name of the sequenced sample.
  - id: library
    type: string?
    inputBinding:
      position: 2
      prefix: '--library'
      shellQuote: false
    doc: The name/ID of the sequenced library.
  - id: platform
    type: string?
    inputBinding:
      position: 2
      prefix: '--platform'
      shellQuote: false
    doc: Sequencing Platform
  - id: platform-unit
    type: string?
    inputBinding:
      position: 2
      prefix: '--platform-unit'
      shellQuote: false
    doc: Platform unit (e.g. ‘..')
  - id: platform-model
    type: string?
    inputBinding:
      position: 2
      prefix: '--platform-model'
      shellQuote: false
    doc: >-
      Platform model to insert into the group header (ex. miseq, hiseq2500,
      hiseqX)
  - id: sequencing-center
    type: string?
    inputBinding:
      position: 2
      prefix: '--sequencing-center'
      shellQuote: false
    doc: The sequencing center from which the data originated
  - id: predicted-insert-size
    type: int?
    inputBinding:
      position: 2
      prefix: '--predicted-insert-size'
      shellQuote: false
    doc: 'Predicted median insert size, to insert into the read group header'
  - id: description
    type: string?
    inputBinding:
      position: 2
      prefix: '--description'
    doc: Description of the read group.
  - id: comment
    type: string?
    inputBinding:
      position: 2
      prefix: '--comment'
    doc: Comment(s) to include in the output file’s header
  - id: run-date
    type: string?
    inputBinding:
      position: 2
      prefix: '--run-date'
      shellQuote: false
    doc: 'Date the run was produced, to insert into the read group header'
  - id: temporary_directory
    type: string?
    doc: 'Default value: null.'
  - id: async_io
    type: string?
    inputBinding:
      position: 0
      separate: false
      prefix: '--async-io='
    doc: >-
      'Use asynchronous I/O where possible, e.g. for SAM and BAM files [=true|false].'
outputs:
  - id: fgbio_fastq_to_bam_ubam
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.output_file_name)
                return inputs.output_file_name;
            return  inputs.input[0].basename.replace(/.fastq.gz/,'_ubam.bam');
        }
doc: >-
  Generates an unmapped BAM (or SAM or CRAM) file from fastq files. Takes in one
  or more fastq files (optionally gzipped), each representing a different
  sequencing read (e.g. R1, R2, I1 or I2) and can use a set of read structures
  to allocate bases in those reads to template reads, sample indices, unique
  molecular indices, or to designate bases to be skipped over.


  Read structures are made up of <number><operator> pairs much like the CIGAR
  string in BAM files. Four kinds of operators are recognized:


  1. T identifies a template read

  2. B identifies a sample barcode read

  3. M identifies a unique molecular index read

  4. S identifies a set of bases that should be skipped or ignored


  The last <number><operator> pair may be specified using a + sign instead of
  number to denote “all remaining bases”. This is useful if, e.g., fastqs have
  been trimmed and contain reads of varying length. For example to convert a
  paired-end run with an index read and where the first 5 bases of R1 are a UMI
  and the second five bases are monotemplate you might specify:
label: fgbio_fastq_to_bam_1.2.0
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
    valueFrom: '-XX:-UseGCOverheadLimit'
  - position: 1
    valueFrom: FastqToBam
  - position: 0
    prefix: '--tmp-dir='
    separate: false
    valueFrom: |-
      ${
          if(inputs.temporary_directory)
              return inputs.temporary_directory;
            return runtime.tmpdir
      }
  - position: 2
    prefix: '--output'
    shellQuote: false
    valueFrom: |-
      ${
          if(inputs.output_file_name)
              return inputs.output_file_name;
            return  inputs.input[0].basename.replace(/.fastq.gz/,'_ubam.bam');
      }
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/fgbio:1.2.0'
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
    'doap:name': fgbio FastqToBam
    'doap:revision': 1.2.0
