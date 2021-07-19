cwlVersion: v1.2
class: Workflow
label: ici-workflows
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: SubworkflowFeatureRequirement
- class: MultipleInputFeatureRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: vcf_file
  label: Variants Files
  doc: Input Variants Files.
  type: File[]?
  sbg:fileTypes: VCF, VCF.GZ, BCF, BCF.GZ
  sbg:x: -399
  sbg:y: -230
- id: phenotype_data
  type: File
  sbg:x: -189.47531127929688
  sbg:y: -316.4203186035156
- id: custom_input
  label: RUN VCF 2 GDS
  type: boolean
  sbg:x: -405.90972900390625
  sbg:y: 20.418041229248047
- id: gds
  type: File
  sbg:x: -157.79391479492188
  sbg:y: 195.00299072265625

outputs:
- id: csv_output
  type: File?
  outputSource:
  - instance_specific_causal/csv_output
  sbg:x: 527.6246948242188
  sbg:y: -22.258909225463867
- id: dict
  type: File?
  outputSource:
  - instance_specific_causal/dict
  sbg:x: 490.1069030761719
  sbg:y: -299.4132995605469

steps:
- id: instance_specific_causal
  label: instance-specific-causal
  in:
  - id: genomic_data
    source: unzip/unzipped_file
    pickValue: the_only_non_null
  - id: phenotype_data
    source: phenotype_data
  - id: output_file_prefix
    default: test
  run: ici-workflow.cwl.steps/instance_specific_causal.cwl
  out:
  - id: csv_output
  - id: dict
  sbg:x: 252.208740234375
  sbg:y: -211.32017517089844
- id: vcf_to_gds
  label: VCF to GDS converter
  in:
  - id: vcf_file
    source:
    - vcf_file
  - id: check_gds_1
    default: No
  - id: custom_input
    source: custom_input
  run: ici-workflow.cwl.steps/vcf_to_gds.cwl
  when: $(inputs.custom_input)
  out:
  - id: unique_variant_id_gds_per_chr
  sbg:x: -221
  sbg:y: -131
- id: seq_array_preprocess
  label: seq-array-preprocess
  in:
  - id: phenotypes
    source: phenotype_data
  - id: gds
    source:
    - vcf_to_gds/unique_variant_id_gds_per_chr
    - gds
    pickValue: the_only_non_null
  run: ici-workflow.cwl.steps/seq_array_preprocess.cwl
  out:
  - id: processed_vcf
  sbg:x: -38.37094497680664
  sbg:y: -141.0281982421875
- id: unzip
  label: gunzip
  in:
  - id: input_file
    source: seq_array_preprocess/processed_vcf
  run: ici-workflow.cwl.steps/unzip.cwl
  out:
  - id: unzipped_file
  sbg:x: 115.94216918945312
  sbg:y: -122.71649932861328
sbg:appVersion:
- v1.2
- v1.1
sbg:content_hash: acacb964451ee2d83db405955abca0c8a287e833963e2a0139af1b6fc50d9afde
sbg:contributors:
- dave
sbg:createdBy: dave
sbg:createdOn: 1620320385
sbg:id: dave/build-instance-specific-casual-inference/ici-workflows/17
sbg:image_url: |-
  https://platform.sb.biodatacatalyst.nhlbi.nih.gov/ns/brood/images/dave/build-instance-specific-casual-inference/ici-workflows/17.png
sbg:latestRevision: 17
sbg:modifiedBy: dave
sbg:modifiedOn: 1626725658
sbg:original_source: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/dave/build-instance-specific-casual-inference/ici-workflows/17/raw/
sbg:project: dave/build-instance-specific-casual-inference
sbg:projectName: 'BUILD: Instance Specific Casual Inference'
sbg:publisher: sbg
sbg:revision: 17
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1620320385
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1620320532
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621972158
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621972244
  sbg:revision: 3
  sbg:revisionNotes: added conditional
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621972294
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621972638
  sbg:revision: 5
  sbg:revisionNotes: single element
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621972691
  sbg:revision: 6
  sbg:revisionNotes: no scatter
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621973366
  sbg:revision: 7
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621973413
  sbg:revision: 8
  sbg:revisionNotes: added preprocess.r
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621973515
  sbg:revision: 9
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621974202
  sbg:revision: 10
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621975273
  sbg:revision: 11
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625850605
  sbg:revision: 12
  sbg:revisionNotes: '"remove minor = T"'
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625851572
  sbg:revision: 13
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625852253
  sbg:revision: 14
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625853557
  sbg:revision: 15
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1626725555
  sbg:revision: 16
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1626725658
  sbg:revision: 17
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
