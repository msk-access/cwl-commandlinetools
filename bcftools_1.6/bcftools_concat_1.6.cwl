
class: CommandLineTool
cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  doap: http://usefulinc.com/ns/doap#
  foaf: http://xmlns.com/foaf/0.1/
  sbg: https://www.sevenbridges.com/

id: bcftools_concat_v1_6

baseCommand:
  - /usr/bin/bcftools
  - concat

doc: |
  concatenate VCF/BCF files from the same set of samples

inputs:

  memory_per_job:
    type: ["null",int]
    doc: Memory per job in megabytes

  memory_overhead:
    type: ["null",int]
    doc: Memory overhead per job in megabytes

  threads:
    type: ["null", string]
    doc: <int> Number of extra output compression threads [0]
    inputBinding:
      prefix: --threads

  compact_PS:
    type: ["null", boolean]
    default: false
    doc: Do not output PS tag at each site, only at the start of a new phase set block.
    inputBinding:
      prefix: --compact-PS

  remove_duplicates:
    type: ["null", boolean]
    default: false
    doc: Alias for -d none
    inputBinding:
      prefix: --remove-duplicates

  ligate:
    type: ["null", boolean]
    default: false
    doc: Ligate phased VCFs by matching phase at overlapping haplotypes
    inputBinding:
      prefix: --ligate

  output_type:
    type: ["null", string]
    doc: <b|u|z|v> b - compressed BCF, u - uncompressed BCF, z - compressed VCF, v - uncompressed VCF [v]
    inputBinding:
      prefix: --output-type

  no_version:
    type: ["null", boolean]
    default: false
    doc: do not append version and command line to the header
    inputBinding:
      prefix: --no-version

  naive:
    type: ["null", boolean]
    default: false
    doc: Concatenate BCF files without recompression (dangerous, use with caution)
    inputBinding:
      prefix: --naive

  allow_overlaps:
    type: ["null", boolean]
    default: false
    doc: First coordinate of the next file can precede last record of the current file.
    inputBinding:
      prefix: --allow-overlaps

  min_PQ:
    type: ["null", string]
    doc: <int> Break phase set if phasing quality is lower than <int> [30]
    inputBinding:
      prefix: --min-PQ

  regions_file:
    type: ["null", string]
    doc: <file> Restrict to regions listed in a file
    inputBinding:
      prefix: --regions-file

  regions:
    type: ["null", string]
    doc: <region> Restrict to comma-separated list of regions
    inputBinding:
      prefix: --regions

  rm_dups:
    type: ["null", string]
    doc: <string> Output duplicate records present in multiple files only once - <snps|indels|both|all|none>
    inputBinding:
      prefix: --rm-dups

  output:
    type: string
    doc: <file> Write output to a file [standard output]
    default: "bcftools_concat.vcf"
    inputBinding:
      prefix: --output

  list:
    type: ['null', string]
    doc: <file> Read the list of files from a file.
    inputBinding:
      prefix: --file-list

  vcf_files_tbi:
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
        - .tbi
    doc: Array of vcf files to be concatenated into one vcf
    inputBinding:
        position: 1

  vcf_files_csi:
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - ^.bcf.csi
    doc: Array of vcf files to be concatenated into one vcf
    inputBinding:
        position: 1

outputs:
  bcftools_concat_vcf_output_file:
    type: File
    outputBinding:
      glob: |-
        ${
          if (inputs.output)
            return inputs.output;
          return null;
        }

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    ramMin: 24000
    coresMin: 3
  DockerRequirement:
    dockerPull: ghcr.io/msk-access/bcftools:1.6


dct:contributor:
  - class: foaf:Organization
    foaf:member:
      - class: foaf:Person
        foaf:mbox: mailto:kumarn1@mskcc.org
        foaf:name: Nikhil Kumar
    foaf:name: Memorial Sloan Kettering Cancer Center
dct:creator:
  - class: foaf:Organization
    foaf:member:
      - class: foaf:Person
        foaf:mbox: mailto:kumarn1@mskcc.org
        foaf:name: Nikhil Kumar
    foaf:name: Memorial Sloan Kettering Cancer Center
doap:release:
  - class: doap:Version
    doap:name: bcftools
    doap:revision: 1.6
