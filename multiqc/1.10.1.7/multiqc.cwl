class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - multiqc
arguments:
  - valueFrom: .
    position: 999
inputs:
  - id: qc_files_dir
    type: Directory?
    doc: |
      qc files in a Directory
  - default: multiqc_1.10.1.7
    id: report_name
    type: string
    inputBinding:
      position: 0
      prefix: '--filename'
    doc: name used for the html report and the corresponding zip file
  - id: config
    type: File?
    inputBinding:
      position: 0
      prefix: '--config'
outputs:
  - id: multiqc_output_dir
    type: Directory
    outputBinding:
      glob: .
      outputEval: |-
        ${
            self[0].basename = inputs.report_name.replace('.html', '');
            return self[0]
        }
  - id: multiqc_html
    type: File
    outputBinding:
      glob: |-
        ${
            if (inputs.report_name) {
                return inputs.report_name + ".html"
            } else {
                return "multiqc_1.10.1.7.html"
            }
        }
  - id: multiqc_zip
    type: File?
    outputBinding:
      glob: $(inputs.report_name)_data.zip
doc: |
  Run multiqc on log files from supported bioinformatic tools.
hints:
  - class: ResourceRequirement
    ramMin: 16000
    coresMin: 16
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/multiqc:v1.10.1.7'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      LC_ALL: en_US.utf-8
      LANG: en_US.utf-8
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.qc_files_dir)
        writable: true
  - class: InlineJavascriptRequirement
