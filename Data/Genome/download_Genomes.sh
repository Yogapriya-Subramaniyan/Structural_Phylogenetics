#!/bin/bash

# Path to CSV file with 5 columns; accession is column 2, FTP path is column 3
CSV_FILE="taxon_accessions.csv"

# Skip header and read CSV line by line
tail -n +2 "$CSV_FILE" | while IFS=',' read -r col1 accession ftp_path col4 col5; do
    # Skip rows without FTP path
    [[ -z "$ftp_path" || "$ftp_path" == "No genome found" ]] && continue

    echo "🔽 Downloading ALL files for $accession ..."

    # Make output directory named after accession
    mkdir -p "$accession"

    # Download all files from the FTP path into the folder
    wget -r -nd -np -P "$accession" "$ftp_path/"

    echo "✅ Done with $accession"
done
