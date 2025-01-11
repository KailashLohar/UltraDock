#!/bin/bash

folder_name="$1"
input_sdf="$folder_name/pipeline_files/1_sdf"

output_mol1="$folder_name/pipeline_files/2_mol2"

mkdir -p "$output_mol1"


# Minimize structures in batches of 20000
batch_num=1
batch_size=20000
for i in $(seq 1 20000 $(find "$input_sdf" -maxdepth 1 -type f -name "*.sdf" | wc -l)); do
    batch_files=("$input_sdf"/*.sdf)
    for file in "${batch_files[@]:i:20000}"; do
        obminimize -ff MMFF94 -n 1000 "$file" > /dev/null 2>&1
    done
    ((batch_num++))
done

# Convert to MOL2 in batches of 20000
batch_num=1
sdf_files=("$input_sdf"/*.sdf)
total_files="${#sdf_files[@]}"
for (( i=0; i<total_files; i+=batch_size )); do
    batch_files=("${sdf_files[@]:i:batch_size}")
    obabel "${batch_files[@]}" -omol2 -O "$output_mol1"/.mol2 -m > /dev/null 2>&1
    ((batch_num++))
done


echo -e "\033[1m\033[34mSDF to MOL2 conversion completed and files saved in folder: \033[91m$output_mol1\033[0m" >&1
