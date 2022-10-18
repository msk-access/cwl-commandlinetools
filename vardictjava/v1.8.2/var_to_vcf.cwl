class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: vardict_var2vcf
baseCommand:
  - perl
  - /usr/bin/vardict/bin/var2vcf_valid.pl
inputs:
  - id: case_sample_name
    type: string
    doc: The case sample name to be used directly.
  - id: control_sample_name
    type: string?
    doc: The case sample name to be used directly.
  - id: filter_variants
    type: boolean?
    inputBinding:
      position: 0
      prefix: '-S'
    doc: If set variants that didnt pass filters will not be present in VCF file.
  - id: minimum_allele_frequency
    type: float?
    inputBinding:
      position: 0
      prefix: '-f'
      valueFrom: return inputs.allele_frequency_threshold.toString();
    doc: 'The threshold for allele frequency, default - 0.05 or 5%%'
  - id: input_vcf
    type: File
  - id: output_vcf
    type: string?
    doc: output vcf file
outputs:
  - id: output
    type: File
    outputBinding:
      glob: |-
        ${ 
            if(inputs.output_vcf)
                return inputs.output_vcf; 
            return inputs.case_sample_name + "_vardict.vcf"
        }
arguments:
  - position: 0
    prefix: '-N'
    valueFrom: |-
      ${
          if(inputs.control_sample_name)
              return inputs.case_sample_name + "|" + inputs.control_sample_name;
          return inputs.case_sample_name
      }
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/vardictjava:1.8.2'
  - class: InlineJavascriptRequirement
stdin: $(inputs.input_vcf.path)
stdout: |-
  ${ 
      if(inputs.output_vcf)
          return inputs.output_vcf; 
      return inputs.case_sample_name + "_vardict.vcf"
  }
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:vurals@mskcc.org'
        'foaf:name': Suleyman Vural
    'foaf:name': Memorial Sloan Kettering Cancer Center
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
    'foaf:name': Memorial Sloan Kettering Cancer Center
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
        'foaf:mbox': 'mailto:kumarn1@mskcc.org'
        'foaf:name': Nikhil Kumar
    'foaf:name': Memorial Sloan Kettering Cancer Center
'doap:release':
  - class: 'doap:Version'
    'doap:name': Vardictjava
    'doap:revision': 1.8.2
