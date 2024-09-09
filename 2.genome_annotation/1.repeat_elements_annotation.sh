genome_name=$1
genome_path=$2
results_dir=$3

mkdir ${genome_name}.db
BuildDatabase -name ${genome_name}.db/${genome_name} -engine rmblast $genome_path

RepeatModeler -pa 2 -database ${genome_name}.db/${genome_name} -engine rmblast
##########
mkdir $results_dir

RepeatMasker -pa 6 -lib ${genome_name}.db/${genome_name} -e rmblast -dir $results_dir $results_dir -poly -html -gff
#######


