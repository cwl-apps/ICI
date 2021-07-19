cwlVersion: v1.2
class: CommandLineTool
label: gunzip
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: DockerRequirement
  dockerPull: ubuntu:xenial
- class: InlineJavascriptRequirement

inputs:
- id: input_file
  type: File
  inputBinding:
    position: 1
    shellQuote: false

outputs:
- id: unzipped_file
  type: stdout
stdout: $(inputs.input_file.nameroot).vcf

baseCommand:
- gunzip
arguments:
- -c
id: dave/build-instance-specific-casual-inference/unzip/3
sbg:appVersion:
- v1.2
sbg:content_hash: ad4d2bdc85ad37a7c3b61834df37c11f9c81465a9ebf5286b68f30d768cb3bb7e
sbg:contributors:
- dave
sbg:createdBy: dave
sbg:createdOn: 1625853080
sbg:id: dave/build-instance-specific-casual-inference/unzip/3
sbg:image_url:
sbg:latestRevision: 3
sbg:modifiedBy: dave
sbg:modifiedOn: 1626725643
sbg:project: dave/build-instance-specific-casual-inference
sbg:projectName: 'BUILD: Instance Specific Casual Inference'
sbg:publisher: sbg
sbg:revision: 3
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625853080
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625853459
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1626725508
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1626725643
  sbg:revision: 3
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
