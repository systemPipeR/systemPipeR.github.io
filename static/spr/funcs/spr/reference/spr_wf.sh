#!/bin/bash
set -e

# Step 1_2
echo "Running step 1_2"
Rscript ./spr_bash/rscript_step1_2.R


# Step 3
echo "Running step 3"
gzip -c  results/setosa.csv > results/SE.csv.gz
gzip -c  results/versicolor.csv > results/VE.csv.gz
gzip -c  results/virginica.csv > results/VI.csv.gz


# Step 4
echo "Running step 4"
gunzip -c  results/SE.csv.gz > results/SE.csv
gunzip -c  results/VE.csv.gz > results/VE.csv
gunzip -c  results/VI.csv.gz > results/VI.csv


# Step 5
echo "Running step 5"
Rscript ./spr_bash/rscript_step5.R


