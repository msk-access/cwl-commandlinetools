class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
baseCommand:
  - bwa
  - mem
inputs:
  - id: A
    type: int?
    inputBinding:
      position: 0
      prefix: '-A'
    doc: 'INT score for a sequence match [1]'
  - id: B
    type: int?
    inputBinding:
      position: 0
      prefix: '-B'
    doc: 'INT penalty for a mismatch [4]'
  - default: false
    id: C
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-C'
    doc: append FASTA/FASTQ comment to SAM output
  - id: E
    type: int?
    inputBinding:
      position: 0
      prefix: '-E'
    doc: 'INT gap extension penalty; a gap of size k cost {-O} + {-E}*k [1]'
  - id: L
    type: int?
    inputBinding:
      position: 0
      prefix: '-L'
    doc: 'INT penalty for clipping [5]'
  - default: true
    id: M
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-M'
    doc: mark shorter split hits as secondary (for Picard/GATK compatibility)
  - id: O
    type: int?
    inputBinding:
      position: 0
      prefix: '-O'
    doc: 'INT gap open penalty [6]'
  - default: false
    id: P
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-P'
    doc: skip pairing; mate rescue performed unless -S also in use
  - id: R
    type: string?
    inputBinding:
      position: 0
      prefix: '-R'
    doc: 'STR read group header line such as ''@RG\tID -foo\tSM -bar'' [null]'
  - default: false
    id: S
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-S'
    doc: skip mate rescue
  - id: T
    type: int?
    inputBinding:
      position: 0
      prefix: '-T'
    doc: 'INT minimum score to output [30]'
  - id: U
    type: int?
    inputBinding:
      position: 0
      prefix: '-U'
    doc: 'INT penalty for an unpaired read pair [17]'
  - default: false
    id: a
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-a'
    doc: output all alignments for SE or unpaired PE
  - id: c
    type: int?
    inputBinding:
      position: 0
      prefix: '-c'
    doc: 'INT skip seeds with more than INT occurrences [10000]'
  - id: d
    type: int?
    inputBinding:
      position: 0
      prefix: '-d'
    doc: 'INT off-diagonal X-dropoff [100]'
  - id: k
    type: int?
    inputBinding:
      position: 0
      prefix: '-k'
    doc: 'INT minimum seed length [19]'
  - id: output
    type: string?
  - id: p
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-p'
    doc: first query file consists of interleaved paired-end sequences
  - id: r
    type: float?
    inputBinding:
      position: 0
      prefix: '-r'
    doc: 'FLOAT look for internal seeds inside a seed longer than {-k} * FLOAT [1.5]'
  - id: v
    type: int?
    inputBinding:
      position: 0
      prefix: '-v'
    doc: 'INT verbose level - 1=error, 2=warning, 3=message, 4+=debugging [3]'
  - id: w
    type: int?
    inputBinding:
      position: 0
      prefix: '-w'
    doc: 'INT band width for banded alignment [100]'
  - id: reads
    type: 'File[]'
    inputBinding:
      position: 3
  - id: reference
    type: File
    inputBinding:
      position: 2
    secondaryFiles:
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - .fai
outputs:
  - id: sam
    type: File
    outputBinding:
      glob: |-
        ${
          if (inputs.output)
            return inputs.output;
          return inputs.reads[0].basename.replace(/(fastq.gz)|(fq.gz)/, 'sam');
        }
doc: |
  bwa mem
label: bwa-mem
arguments:
  - position: 0
    prefix: '-t'
    valueFrom: $(runtime.cores - 4)
requirements:
  - class: ResourceRequirement
    ramMin: 48000
    coresMin: 24
  - class: DockerRequirement
    dockerPull: 'mskcc/bwa_mem:0.7.5a'
  - class: InlineJavascriptRequirement
stdout: |-
  ${
    if (inputs.output)
      return inputs.output;
    return inputs.reads[0].basename.replace(/(fastq.gz)|(fq.gz)/, 'sam');
  }
$schemas:
  - 'http://dublincore.org/2012/06/14/dcterms.rdf'
  - 'http://xmlns.com/foaf/spec/20140114.rdf'
  - 'http://usefulinc.com/ns/doap#'
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:chunj@mskcc.org'
        'foaf:name': Jaeyoung Chun
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:chunj@mskcc.org'
        'foaf:name': Jaeyoung Chun
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': bwa-mem
    'doap:revision': 0.7.5a
  - class: 'doap:Version'
    'doap:name': bwa-mem-cwl
    'doap:revision': 1.0.0
