class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
id: vcf2maf_v1_6_21
baseCommand:
  - perl
  - /opt/vcf2maf-1.6.21/vcf2maf.pl
inputs:
  - id: any_allele
    type: string?
    inputBinding:
      position: 0
      prefix: '--any-allele'
    doc: 'When reporting co-located variants, allow mismatched variant alleles too'
  - default: 5000
    id: buffer_size
    type: int?
    inputBinding:
      position: 0
      prefix: '--buffer-size'
    doc: Number of variants VEP loads at a time; Reduce this for low memory systems
  - default: '105'
    id: cache_version
    type: string?
    inputBinding:
      position: 0
      prefix: '--cache-version'
    doc: Version of VEP and its cache to use
  - id: custom_enst
    type: File?
    inputBinding:
      position: 0
      prefix: '--custom-enst'
    doc: 'List of custom ENST IDs that override canonical selection, in a file'
  - id: input_vcf
    type:
      - File
    inputBinding:
      position: 0
      prefix: '--input-vcf'
    doc: 'Path to input file in VCF format , gzipped'
  - default: mskcc.org
    id: maf_center
    type: string?
    inputBinding:
      position: 0
      prefix: '--maf-center'
    doc: Variant calling center to report in MAF
  - id: memory_overhead
    type: int?
    doc: Memory overhead per job in megabytes
  - id: memory_per_job
    type: int?
    doc: Memory per job in megabytes
  - default: 0.7
    id: min_hom_vaf
    type: float?
    inputBinding:
      position: 0
      prefix: '--min-hom-vaf'
    doc: >-
      If GT undefined in VCF, minimum allele fraction to call a variant
      homozygous
  - default: GRCh37
    id: ncbi_build
    type: string?
    inputBinding:
      position: 0
      prefix: '--ncbi-build'
    doc: Genome build of variants in input
  - default: NORMAL
    id: normal_id
    type: string?
    inputBinding:
      position: 0
      prefix: '--normal-id'
    doc: Matched_Norm_Sample_Barcode to report in the MAF
  - id: output_maf
    type: string?
    inputBinding:
      position: 0
      prefix: '--output-maf'
    doc: Path to output MAF file
  - default: '/.vep/homo_sapiens/105_GRCh37/Homo_sapiens.GRCh37.dna.toplevel.fa.gz'
    id: ref_fasta
    type: string?
    inputBinding:
      position: 0
      prefix: '--ref-fasta'
    doc: Reference FASTA file
  - id: remap_chain
    type: string?
    inputBinding:
      position: 0
      prefix: '--remap-chain'
    doc: Chain file to remap variants to a different assembly before running VEP
  - id: retain_fmt
    type: string?
    inputBinding:
      position: 0
      prefix: '--retain-fmt'
    doc: >-
      Comma-delimited names of FORMAT fields to retain as extra columns in MAF
      []
  - id: retain_info
    type: string?
    inputBinding:
      position: 0
      prefix: '--retain-info'
    doc: Comma-delimited names of INFO fields to retain as extra columns in MAF
  - default: homo_sapiens
    id: species
    type: string?
    inputBinding:
      position: 0
      prefix: '--species'
    doc: Species of variants in input
  - default: TUMOR
    id: tumor_id
    type: string?
    inputBinding:
      position: 0
      prefix: '--tumor-id'
    doc: Tumor_Sample_Barcode to report in the MAF
  - default: NORMAL
    id: vcf_normal_id
    type: string?
    inputBinding:
      position: 0
      prefix: '--vcf-normal-id'
    doc: Matched normal ID used in VCFs genotype columns
  - default: TUMOR
    id: vcf_tumor_id
    type: string?
    inputBinding:
      position: 0
      prefix: '--vcf-tumor-id'
    doc: Tumor sample ID used in VCFs genotype columns
  - default: '/.vep/ '
    id: vep_data
    type: string?
    inputBinding:
      position: 0
      prefix: '--vep-data'
    doc: VEPs base cache/plugin directory
  - default: 4
    id: vep_forks
    type: int?
    inputBinding:
      position: 0
      prefix: '--vep-forks'
    doc: Number of forked processes to use when running VEP
  - default: '/usr/local/bin/'
    id: vep_path
    type: string?
    inputBinding:
      position: 0
      prefix: '--vep-path'
    doc: Folder containing variant_effect_predictor.pl or vep binary
outputs:
  - id: vcf2maf_maf
    type: File
    outputBinding:
      glob: |
        ${
          if (inputs.output_maf)
            return inputs.output_maf;
          return null;
        }
arguments:
  - position: 0
    prefix: '--tmp-dir'
    shellQuote: false
    valueFrom: $(runtime.tmpdir)
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 2
  - class: DockerRequirement
    dockerPull: 'ghcr.io/msk-access/vcf2maf:1.6.21'
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:vurals@mskcc.org'
        'foaf:name': Suleyman Vural
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:sivaprk@mskcc.org'
        'foaf:name': Karthigayini Sivaprakasam
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
    'doap:name': vcf2maf
    'doap:revision': 1.6.21
