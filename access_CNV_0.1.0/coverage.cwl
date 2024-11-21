class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - cfdna_scna
inputs:
  - id: normal_sample_list
    type: File
    inputBinding:
      position: 0
      prefix: '--normalManifest'
    doc: >-
      normal_manifest.txt Full path to the normal sample manifest, tab
      serparated BAM path, patient sex
  - id: project_name_cnv
    type: string
    inputBinding:
      position: 0
      prefix: '--runID'
    doc: e.g. ACCESSv1-VAL-20180001
  - id: reference_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '--genomeReference'
    doc: Homo_Sapeins_hg19.fasta Full Path to the reference fasta file
  - id: targets_coverage_bed
    type: File
    inputBinding:
      position: 0
      prefix: '--bedTargets'
    doc: ACCESS_targets_coverage.bed Full Path to BED file of panel targets
  - id: threads
    type: int
    inputBinding:
      position: 0
      prefix: '--threads'
    doc: Number of Threads to be used to generate coverage metrics
  - id: tumor_sample_list
    type: File
    inputBinding:
      position: 0
      prefix: '--tumorManifest'
    doc: >-
      tumor_manifest.txt Full path to the tumor sample manifest, tab serparated
      BAM path, patient sex
outputs:
  - id: bam_list
    type: 'File[]'
    outputBinding:
      glob: $('*_bams.list')
  - id: normals_covg
    type: File
    outputBinding:
      glob: $('*normals_targets_nomapq.covg_interval_summary')
  - id: standard_err
    type: stderr
  - id: standard_out
    type: stdout
  - id: tumors_covg
    type: File
    outputBinding:
      glob: $('*tumors_targets_nomapq.covg_interval_summary')
requirements:
  - class: ResourceRequirement
    ramMin: 10000
    coresMin: 8
  - class: DockerRequirement
    dockerPull: 'mskaccess/access_CNV_0.1.0:0.1.0'
  - class: InlineJavascriptRequirement
stdout: coverage.stdout
stderr: coverage.stderr
