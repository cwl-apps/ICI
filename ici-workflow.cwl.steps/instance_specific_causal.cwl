cwlVersion: v1.2
class: CommandLineTool
label: instance-specific-causal
doc: |-
  ```
   /opt/ICIQTMarginal -h    
  Usage: GenGlobalDriver -f inputGaMatrix -c VCFMatrix -d inputGeMatrix -o pathForOutputResults
  ```
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: DockerRequirement
  dockerPull: images.sb.biodatacatalyst.nhlbi.nih.gov/dave/ici:development
- class: InitialWorkDirRequirement
  listing:
  - entryname: ici.sh
    writable: false
    entry: |-
      mkdir -p ./DataSource
      mkdir -p ./Results/TCI

      cp $(inputs.genomic_data.path) DataSource
      cp $(inputs.phenotype_data.path) DataSource

      SGAori=./DataSource/$(inputs.genomic_data.basename)
      DEGori=./DataSource/$(inputs.phenotype_data.basename)

      dictPrefix=./DataSource/dict

      /opt/GenGlobDriver -c $SGAori -d $DEGori -o "$dictPrefix.csv"
      echo "completed GenGlobDriver"

      /opt/ICIQTMarginal -c $SGAori -d $DEGori -g "$dictPrefix.csv" -o ./Results/TCI/output.csv
      echo "completed ICIQTMarginal"



      # ./GenGlobDriver_0504 -c $SGAori -d $DEGori -o "$dictPrefix.csv";
      #./ICIQT_0504 -c $SGAori -d $DEGori -g $dictPrefix".csv" -o ./Results/TCI
- class: InlineJavascriptRequirement

inputs:
- id: genomic_data
  type: File
  inputBinding:
    position: 0
    shellQuote: false
- id: phenotype_data
  type: File
  inputBinding:
    position: 0
    shellQuote: false
- id: output_file_prefix
  type: string
  inputBinding:
    position: 0
    shellQuote: false

outputs:
- id: csv_output
  type: File?
  outputBinding:
    glob: Results/TCI/output.csv
- id: dict
  type: File?
  outputBinding:
    glob: DataSource/dict.csv

baseCommand:
- bash
- ici.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
id: dave/build-instance-specific-casual-inference/instance-specific-causal/16
sbg:appVersion:
- v1.2
sbg:content_hash: abc14e6c4939f5170b9c4623b42293e1a72b3ee99d1d2303c2f95e72750d28f9c
sbg:contributors:
- dave
sbg:createdBy: dave
sbg:createdOn: 1620320075
sbg:id: dave/build-instance-specific-casual-inference/instance-specific-causal/16
sbg:image_url:
sbg:latestRevision: 16
sbg:modifiedBy: dave
sbg:modifiedOn: 1621971631
sbg:project: dave/build-instance-specific-casual-inference
sbg:projectName: 'BUILD: Instance Specific Casual Inference'
sbg:publisher: sbg
sbg:revision: 16
sbg:revisionNotes: dict save
sbg:revisionsInfo:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1620320075
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1620321483
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621450947
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621452508
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621452548
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621452736
  sbg:revision: 5
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621453415
  sbg:revision: 6
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621453638
  sbg:revision: 7
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621453957
  sbg:revision: 8
  sbg:revisionNotes: no returns
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621454203
  sbg:revision: 9
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621559175
  sbg:revision: 10
  sbg:revisionNotes: copied on linux
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621560533
  sbg:revision: 11
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621561446
  sbg:revision: 12
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621970957
  sbg:revision: 13
  sbg:revisionNotes: dos2unix
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621971334
  sbg:revision: 14
  sbg:revisionNotes: output .csv corrected
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621971455
  sbg:revision: 15
  sbg:revisionNotes: echo
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621971631
  sbg:revision: 16
  sbg:revisionNotes: dict save
sbg:sbgMaintained: false
sbg:validationErrors: []
