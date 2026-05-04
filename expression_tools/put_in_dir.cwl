#!/usr/bin/env cwl-runner
# originally from https://github.com/mskcc/pluto-cwl

cwlVersion: v1.0
$namespaces:
  dct: 'http://purl.org/dc/terms/'
  doap: 'http://usefulinc.com/ns/doap#'
  foaf: 'http://xmlns.com/foaf/0.1/'
  sbg: 'https://www.sevenbridges.com/'
class: ExpressionTool
id: put-in-dir

inputs:
  output_directory_name:
    type: string
    doc: >-
      Put all `files` in a directory called `output_directory_name`.
  output_subdirectory_name:
    type: string?
    doc: >-
      If specified, nest all `files` within a directory called `output_subdirectory_name`, which itself is within `output_directory_name`.
  files:
    type:
      type: array
      items:
        - File
        - type: array
          items:
            - File
        - Directory
        - 'null'

outputs:
  directory:
    type: Directory

# This tool returns a Directory object,
# which holds all output files from the list
# of supplied input files
expression: |
  ${
    var output_files = [];
    var input_files = inputs.files.filter(function(single_file) {
      return String(single_file).toUpperCase() != 'NONE';
    });

    for (var i = 0; i < input_files.length; i++) {
      // Handle list of list of files
      if (input_files[i] && input_files[i].length) {
        for (var ii = 0; ii < input_files[i].length; ii++) {
          output_files.push(input_files[i][ii]);
        }
      // Handle list of files
      } else if (input_files[i]) {
        output_files.push(input_files[i]);
      }
    }

    if (inputs.output_subdirectory_name) {
      return {
        'directory': {
          'class': 'Directory',
          'basename': inputs.output_directory_name,
          'listing': [
          {
            'class': 'Directory',
            'basename': inputs.output_subdirectory_name,
            'listing': output_files
          }
          ]
        }
      };
    } else {
      return {
        'directory': {
          'class': 'Directory',
          'basename': inputs.output_directory_name,
          'listing': output_files
        }
      };
    }

  }

requirements:
  - class: ResourceRequirement
    ramMin: 2000
    coresMin: 1
    outdirMin: 20480
    tmpdirMin: 20480
  - class: InlineJavascriptRequirement
'dct:contributor':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
'dct:creator':
  - class: 'foaf:Organization'
    'foaf:member':
      - class: 'foaf:Person'
        'foaf:mbox': 'mailto:murphyc4@mskcc.org'
        'foaf:name': Charlie Murphy
    'foaf:name': Memorial Sloan Kettering Cancer Center
