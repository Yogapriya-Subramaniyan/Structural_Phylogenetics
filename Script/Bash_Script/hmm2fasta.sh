#!/bin/bash

csv_file="./Data/02_Distant_Homolog_Extraction/sto_files.csv"

tail -n +2 "$csv_file" | while IFS=','  read -r protein sto_files hmm_files; do
      cd ./Data/02_Distant_Homolog_Extraction/$protein
      output="$protein.txt"
      tableoutput="${protein}_hits_table.txt"
      domaintableoutput="${protein}_domains_table.txt"
      hmmsearch --cpu 4 -E 0.01 \
      -o $output \
      --tblout $tableoutput \
      --domtblout $domaintableoutput \
      $hmm_files /Users/Yoga/Library/CloudStorage/OneDrive-Personal/PG\ Materials/Semester3/Structural_Phylogeny/Data/Genome/protein_20250805.fasta
      cd -
done