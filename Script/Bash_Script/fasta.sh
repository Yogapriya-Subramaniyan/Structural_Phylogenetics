#!/bin/bash
csv_file="./Data/02_Distant_Homolog_Extraction/sto_files.csv"

tail -n +2 "$csv_file" | while IFS=',' read -r protein sto_files hmm_files || [ -n "$protein" ]; do

      mkdir ./Data/02_Distant_Homolog_Extraction/$protein
      cp ./Data/01_Seed_Sequence/$protein.fasta ./Data/02_Distant_Homolog_Extraction/$protein/$protein.fasta
      
done
