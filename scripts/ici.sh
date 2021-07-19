mkdir -p ./DataSource
mkdir -p ./Results/TCI
cp $(inputs.genomic_data.path) DataSource
cp $(inputs.phenotype_data.path) DataSource
SGAori=./DataSource/$(inputs.genomic_data.basename)
DEGori=./DataSource/$(inputs.phenotype_data.basename)
dictPrefix=./DataSource/dict
/opt/GenGlobDriver -c $SGAori -d $DEGori -o "$dictPrefix.csv";
/opt/ICIQTMarginal -c $SGAori -d $DEGori -g "$dictPrefix.csv" -o ./Results/TCI
# ./GenGlobDriver_0504 -c $SGAori -d $DEGori -o "$dictPrefix.csv";
#./ICIQT_0504 -c $SGAori -d $DEGori -g $dictPrefix".csv" -o ./Results/TCI
