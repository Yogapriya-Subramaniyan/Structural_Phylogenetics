#!/bin/bash

csv_file="./Data/02_Distant_Homolog_Extraction/sto_files.csv"

tail -n +2 "$csv_file" | while IFS=',' read -r protein sto_files hmm_files; do
      cd ./Data/02_Distant_Homolog_Extraction/$protein
      tableoutput="${protein}_hits_table.txt"
      output="${protein}_hit_ids.txt"
      matched_hits="${protein}_matched_hits.fasta"
      
grep -v '^#' $tableoutput | awk '{print $1}' | sort -u > $output

seqkit grep -f $output /Users/Yoga/Library/CloudStorage/OneDrive-Personal/PG\ Materials/Semester3/Structural_Phylogeny/Data/Genome/protein_20250805.fasta > $matched_hits

cd -

done