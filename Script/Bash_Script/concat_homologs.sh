#!/bin/bash

find ./ -name "*_matched_hits.fasta" -execdir cat '{}' \; > ./Data/02_Distant_Homolog_Extraction/homologs.fasta