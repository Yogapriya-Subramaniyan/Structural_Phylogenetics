#!/bin/bash
csv_file="./Data/02_Distant_Homolog_Extraction/sto_files.csv"

tail -n +2 "$csv_file" | while IFS=',' read -r protein sto_files hmm_files; do

     cd ./Data/02_Distant_Homolog_Extraction/$protein
     mafft --maxiterate 1000 --localpair $protein.fasta | esl-reformat stockholm -> $sto_files
     cd -
     
done