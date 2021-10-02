#!/bin/bash
set -e

# Step 1
echo "Running step 1"
Rscript ./spr_bash/rscript_step1.R


# Step 2
echo "Running step 2"
gzip -c  results/setosa.csv > results/SE.csv.gz
gzip -c  results/versicolor.csv > results/VE.csv.gz
gzip -c  results/virginica.csv > results/VI.csv.gz


# Step 3
echo "Running step 3"
gunzip -c  results/SE.csv.gz > results/SE.csv
gunzip -c  results/VE.csv.gz > results/VE.csv
gunzip -c  results/VI.csv.gz > results/VI.csv


# Step 4
echo "Running step 4"
Rscript ./spr_bash/rscript_step4.R


