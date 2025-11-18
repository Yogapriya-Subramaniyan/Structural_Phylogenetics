library(readxl)
library(dplyr)
library(rentrez)

entrez_email <- "s.yogapriya@outlook.com"

# ✅ read taxon IDs from Excel
taxon_df <- read_excel("Data/Genome/taxon_ids.xlsx")
taxon_ids <- as.character(taxon_df$TaxonID)

results <- data.frame(TaxonID = character(),
                      AssemblyAccession = character(),
                      FTPpath = character(),
                      RefSeqCategory = character(),
                      Source = character(),
                      stringsAsFactors = FALSE)

for (taxid in taxon_ids) {
  cat("\n🔍 Taxon ID:", taxid, "\n")
  
  name <- NA
  ftppath <- NA
  category <- NA
  source <- NA
  
  # 1️⃣ First: Try to get REFERENCE genome only
  search_ref <- entrez_search(
    db = "assembly",
    term = paste0("txid", taxid , "[Organism:exp] AND \"reference genome\"[refseq_category]"),
    retmax = 1
  )
  
  if (length(search_ref$ids) > 0) {
    # ✅ Found a reference genome
    summaries <- entrez_summary(db = "assembly", id = search_ref$ids)
    name <- summaries$assemblyaccession
    ftppath <- summaries$ftppath_genbank
    category <- "reference genome"
    source <- "RefSeq"
    cat("   ✅ Found REFERENCE genome:", accession, "\n")
    
  } else if (TRUE) {
    # 2️⃣ If no REFERENCE genome, get ALL RefSeq assemblies
    search_all <- entrez_search(
      db = "assembly",
      term = paste0("txid", taxid , "[Organism:exp]"),
      retmax = 1000
    )
    
    if (length(search_all$ids) > 0) {
      summaries <- entrez_summary(db = "assembly", id = search_all$ids)
      
      # 🔍 Handle single vs multiple entries
      if (length(search_all$ids) == 1) {
        # ✅ Only ONE summary returned
        refseq_cat <- summaries$refseq_category
          name <- summaries$assemblyaccession
          ftppath <- summaries$ftppath_genbank
          category <- "latest (single entry)"
          source <- "RefSeq"
          cat("   ⚠️ Only one RefSeq found:", accession, "\n")
        
      } else {
        # ✅ MULTIPLE summaries returned
        
        refseq_cats <- sapply(summaries, function(x) x$refseq_category)
        name <- summaries[[1]]$assemblyaccession
        ftppath <- summaries[[1]]$ftppath_genbank
          category <- "latest (no reference/rep)"
          source <- "RefSeq"
          cat("   ⚠️ Using latest RefSeq:", accession, "\n")
        
      }
      
    } else {
      # 3️⃣ If no RefSeq found at all
      accession <- "No genome found"
      category <- "None"
      source <- "None"
      cat("   ❌ No genome found for this taxon.\n")
    }
  }
  
  # ✅ Save the result
  results <- rbind(results,
                   data.frame(TaxonID = taxid,
                              AssemblyAccession = name,
                              FTPpath = ftppath,
                              RefSeqCategory = category,
                              Source = source,
                              stringsAsFactors = FALSE))
  
  Sys.sleep(0.5)  # polite pause for NCBI
}
write.csv(results, "Data/Genome/taxon_accessions.csv", row.names = FALSE)
cat("\n✅ Done! Saved to genome_accessions_with_categories.csv\n")
