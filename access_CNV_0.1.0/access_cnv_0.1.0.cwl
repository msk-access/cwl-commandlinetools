class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - copynumber_tm.batchdiff_cfdna.R
inputs:
  - id: do_full
    type: string
    inputBinding:
      position: 5
    doc: either 'FULL' or 'MIN'
  - id: loess_normals
    type: File
    inputBinding:
      position: 2
    doc: normal_ALL_intervalnomapqcoverage_loess.txt
  - id: loess_tumors
    type: File
    inputBinding:
      position: 4
    doc: tumor_ALL_intervalnomapqcoverage_loess.txt
  - id: project_name_cnv
    type: string
    inputBinding:
      position: 1
    doc: e.g. ACCESSv1-VAL-20180001
  - id: targets_coverage_annotation
    type: File
    inputBinding:
      position: 3
    doc: >-
      ACCESS_targets_coverage.txt Full Path to text file of target annotations.
      Columns = (Chrom, Start, End, Target, GC_150bp, GeneExon, Cyt, Interval)
outputs:
  - id: copy_pdf
    type: File
    outputBinding:
      glob: $('*copynumber_segclusp.pdf')
  - id: copy_standard_err
    type: stderr
  - id: copy_standard_out
    type: stdout
  - id: genes_file
    type: File
    outputBinding:
      glob: $('*copynumber_segclusp.genes.txt')
  - id: intragenic_file
    type: File
    outputBinding:
      glob: $('*copynumber_segclusp.intragenic.txt')
  - id: probes_file
    type: File
    outputBinding:
      glob: $('*copynumber_segclusp.probes.txt')
  - id: seg_files
    type: 'File[]'
    outputBinding:
      glob: $('*.seg')
requirements:
  - class: ResourceRequirement
    ramMin: 10000
    coresMin: 1
  - class: DockerRequirement
    dockerPull: 'mskaccess/access_CNV_0.1.0:0.1.0'
  - class: InlineJavascriptRequirement
stdout: copy_number.stdout
stderr: copy_number.stderr
