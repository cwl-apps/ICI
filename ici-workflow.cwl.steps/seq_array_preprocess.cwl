cwlVersion: v1.2
class: CommandLineTool
label: seq-array-preprocess
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: DockerRequirement
  dockerPull: uwgac/topmed-master:2.10.0
- class: InitialWorkDirRequirement
  listing:
  - entryname: preprocess.R
    writable: false
    entry: |
      library(SeqArray)
      library(SeqVarTools)

      #phenotype_path
      #gds_path

      source("cwl_input.R")


      gds <- seqOpen(gds_path) ## GDS Load
      maf = seqAlleleFreq(gds,minor=TRUE)

      table(maf==0)
      seqSetFilter(gds,variant.sel=(maf>0),action='intersect') # MAF>0 apply into gds function
      seqSummary(gds,check='default') # Check summary


      filter <- seqGetData(gds,"annotation/filter") # Get Filter Data
      print(length(filter)) 
      print(head(filter))
      table(filter == "PASS")


      seqSetFilter(gds,variant.sel=(filter=="PASS"),action='intersect') # Apply Pass filter
      seqSummary(gds,check='default') # 1276192
      num_allel <- seqNumAllele(gds)
      table(num_allel) # all 1276192 are biallelic, MAF>0, Filter=PASS, 
      seqSetFilter(gds,variant.sel=(num_allel==2),action='intersect') # Apply if allele are biallelic 
      seqSummary(gds,check='default')
      position<-seqGetData(gds,"position")
      print(length(position)) #1276192
      uni_pos <- unique(position)
      print(length(uni_pos)) #1263689

      ## Unique position filtration, from next line start, no direct function found to remove duplicate position number  
      position_p<-seqGetData(gds,"position")
      print(length(position_p)) #1276192
      uni_pos_p <- unique(position)
      print(length(uni_pos_p)) #1263689

      position_v<-seqGetData(gds,"variant.id")
      print(length(position_v))
      uni_pos_v <- unique(position_v)
      print(length(uni_pos_v))

      df <- data.frame(p = position_p, v = position_v)
      head(df)
      df <- df[!duplicated(df[c(1,1)]),]
      variantlist <- df$v
      positionlist <- df$p

      head(variantlist)
      length(variantlist)
      head(positionlist)
      length(positionlist)
      length(unique(positionlist))

      seqSetFilter(gds, variant.id=variantlist,action='intersect')

      ## Unique position filtration, finish on previous line

      ## Sample filtration based on phenotype, start from next line
      phenod<-read.csv(phenotype_path)
      phenod<-data.frame(phenod)

      idsToKeep <- phenod$index


      seqSetFilter(gds, sample.id=idsToKeep,action='intersect')
      seqSummary(gds,check='default')

      ## Sample filtration based on phenotype,, finish on previous line


      seqGDS2VCF(gds,'final_without_dup.gz',use_Rsamtools=FALSE) # saving result as vcf.gz format
  - entryname: cwl_input.R
    writable: false
    entry: "\n\nphenotype_path = \"$(inputs.phenotypes.path)\"\ngds_path = \"$(inputs.gds.path)\"\
      \n\n"
- class: InlineJavascriptRequirement

inputs:
- id: phenotypes
  type: File
- id: gds
  type: File

outputs:
- id: processed_vcf
  type: File?
  outputBinding:
    glob: '*.vcf'
stdout: standard.out

baseCommand:
- Rscript
- -e
- "'source(\"preprocess.R\","
- echo=TRUE)'

hints:
- class: sbg:SaveLogs
  value: standard.out
- class: sbg:SaveLogs
  value: '*.R'
id: dave/build-instance-specific-casual-inference/seq-array-preprocess/8
sbg:appVersion:
- v1.2
sbg:content_hash: a87ebf61e309d607655a92bbb85e9908c6118600dcb2a26b5c2804e2de6522840
sbg:contributors:
- dave
sbg:createdBy: dave
sbg:createdOn: 1620320115
sbg:id: dave/build-instance-specific-casual-inference/seq-array-preprocess/8
sbg:image_url:
sbg:latestRevision: 8
sbg:modifiedBy: dave
sbg:modifiedOn: 1625852241
sbg:project: dave/build-instance-specific-casual-inference
sbg:projectName: 'BUILD: Instance Specific Casual Inference'
sbg:publisher: sbg
sbg:revision: 8
sbg:revisionNotes: rm some commented lines
sbg:revisionsInfo:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1620320115
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621973151
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621973270
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621974187
  sbg:revision: 3
  sbg:revisionNotes: .R
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1621975256
  sbg:revision: 4
  sbg:revisionNotes: cwl input
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625850592
  sbg:revision: 5
  sbg:revisionNotes: remove minor = T
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625851315
  sbg:revision: 6
  sbg:revisionNotes: topmed docker 2.10.0
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625851561
  sbg:revision: 7
  sbg:revisionNotes: Rscript -e 'source("", echo=TRUE)'
- sbg:modifiedBy: dave
  sbg:modifiedOn: 1625852241
  sbg:revision: 8
  sbg:revisionNotes: rm some commented lines
sbg:sbgMaintained: false
sbg:validationErrors: []
