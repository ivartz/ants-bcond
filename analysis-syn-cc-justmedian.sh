: '
bash analysis.sh <model dir>

Analyse the difference between ground truth (model) displacements and ANTs SyN
estimated displacements computed with Cross-Correlation metric. Outcommented code is not necesary for final results.

For each nonzero tumor segment

Segmentation.nii.gz:

0: Outside of tumor
1: Necrosis
2: Edema
3: Enhancing
'
model=$1
synres="antssyncc"

# Get parent directory of model directory
patient=$(dirname $model)

# Calculate median of nonzero absolute error vector values in tumor segments, forward in time
c="python3 median-nonzero.py $patient/Segmentation.nii.gz $model/$synres/normdiff.nii.gz > $model/$synres/median-normdiff-segmentation.txt"
eval $c

# Calculate median of nonzero relative absolute error vector values in tumor segments, forward in time
c="python3 median-nonzero.py $patient/Segmentation.nii.gz $model/$synres/normdiff-relative.nii.gz > $model/$synres/median-normdiff-relative-segmentation.txt"
eval $c
