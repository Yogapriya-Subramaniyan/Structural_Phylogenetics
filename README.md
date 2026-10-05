# Structural Phylogeny of FliF
This repository contains the pipeline for performing the structural phylogeny of a protein.

## Methods Used

### Collection of Sequences
1. The sequences would be collected from the genomes available in the dropbox ().
2. From all the genomes, the protein fasta files are collected and stored in the file (), which is used for the further collection of homolog proteins.

### Homolog sequence identification 
#### Using Existing Profile downloaded from Pfam
1. The hmm(Hidded Markov Model) file for the protein families are downloaded from the website Pfam.
2. Using the hmm files, the homolog sequences was extracted from the protein fasta file using the hmmsearch function from Jackhmmer and concatenated.
3. From the concatenated fasta file, the duplicate sequences are removed and further analysis were carried out.

#### Using Manually Collected Start Sequences for protein family
1. From the start sequences, they are aligned, sto files are created, which are then used to create a hmm profile for each protein.
2. Using the hmm files, the same set of steps are carried out.

#### Using Jackhmmer to identify distant homologs of all the proteins
1. Using the hmm profile, the distant homolog of all the proteins are collected from a curated  genome of around 200 bacterial species.
2. The homologs identified for the proteins are concatenated to get a single fasta file of homologous sequences.

##### Script 
[01_Distant_Homolog_Extraction.Rmd](Script/01_Distant_Homolog_Extraction.Rmd)
##### Data
[02_Distant_Homolog_Extraction](Data/02_Distant_Homolog_Extraction)


### 3DI character extraction 
#### Alphafold sequence prediction
1. The 3D structure of all the homologous sequence are predicted using the AlphaFold tool.
2. Using the Foldseek tool, the 3DI structures of all sequences are predicted
##### Script 
[03_3di_Extraction.Rmd](Script/03_3di_Extraction.Rmd)
##### Data
[03_3di_Character_Extraction](Data/03_3di_Character_Extraction)

### Alignment of Homologous Sequences 
#### Amino Acid Sequence
1. The global alignment of the amino acid sequences of the homologous proteins were performed using the command line tool MAFFT.

#### 3dI sequence
1. The 3DI sequences of the homologous protein were aligned using the tool suchas famsa3di and US align. (Alignment from US align was found to be too gappy, so the alignment form famsa3di was used in further analysis)
2. Using the alignment of the 3di sequences, the amino acids were realigned correspondingly.
##### Script 
[04_Alignment.Rmd](Script/04_Alignment.Rmd)
##### Data
[04_Alignment](Data/04_Alignment)

### Structural Superposition 
1. The structural super positioning of the representative sequences were performed using the Matchmaker tool in ChimeraX and USalign structural alignment.
##### Script 
[06_Structural_Superposition_Analysis.Rmd](Script/06_Structural_Superposition_Analysis.Rmd)
##### Data
[Structures](Data/Structures)

### Structure Informed amino acid and 3di sequence alignment 
1. The alignment of the flagellar FliF, T3SS family and sporulation family proteins were manually modified such that the RBM1 in FliF and T3SS, RBM2 in FliF and T3SS and SpoIIIAH from sporulation, RBM3 in FliF and SpoIIIAG form sporulation were aligned correspondingly and concatenated to produce the final alignment.
##### Script 
[08_Split_Align_merge.Rmd](Script/08_Split_Align_merge.Rmd)
##### Data
[]()


