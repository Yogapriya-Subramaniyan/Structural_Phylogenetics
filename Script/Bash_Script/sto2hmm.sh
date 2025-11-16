#!/bin/bash

csv_file="./Data/02_Distant_Homolog_Extraction/sto_files.csv"

tail -n +2 "$csv_file" | while IFS=','  read -r protein sto_files hmm_files; do
      cd ./Data/02_Distant_Homolog_Extraction/$protein
      hmmbuild "$hmm_files" "$sto_files"
      cd -
done 