
load ~/Library/CloudStorage/OneDrive-Personal/PG Materials/Semester3/Structural_Phylogeny/Data/Structures/Alphafold/Alphafold_FliF.pdb

# show cartoon
show cartoon
color white


# Colour RBM1,2,3
select region, resi 48-100
color pink, region

select region, resi 125-215
color lime, region

select region, resi 236-427
color aquamarine, region

pseudoatom label_H1, selection=(resi 125-146 and name CA)
label label_H1, "α1"
translate [2,2,2], label_H1

