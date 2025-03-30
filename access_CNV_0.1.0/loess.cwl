class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - loessnormalize_nomapq_cfdna.R
inputs:
  - id: coverage_file
    type: File
    inputBinding:
      position: 3
    doc: 'coverage files, targets_nomapq.covg_interval_summary'
  - id: project_name_cnv
    type: string
    inputBinding:
      position: 1
    doc: e.g. ACCESSv1-VAL-20180001
  - id: run_type
    type: string
    inputBinding:
      position: 4
    doc: tumor or normal
  - id: targets_coverage_annotation
    type: File
    inputBinding:
      position: 2
    doc: >-
      ACCESS_targets_coverage.txt Full Path to text file of target annotations.
      Columns = (Chrom, Start, End, Target, GC_150bp, GeneExon, Cyt, Interval)
outputs:
  - id: loess_pdf
    type: File
    outputBinding:
      glob: $('*_loessnorm.pdf')
  - id: loess_text
    type: File
    outputBinding:
      glob: $('*_ALL_intervalnomapqcoverage_loess.txt')
  - id: standard_err
    type: stderr
  - id: standard_out
    type: stdout
arguments:
  - $(runtime.outdir)
requirements:
  - class: ResourceRequirement
    ramMin: 10000
    coresMin: 1
  - class: DockerRequirement
    dockerPull: 'mskaccess/access_CNV_0.1.0:0.1.0'
  - class: InlineJavascriptRequirement
stdout: $(inputs.run_type + '_loess.stdout')
stderr: $(inputs.run_type + '_loess.stderr')
