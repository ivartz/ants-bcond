: '
bash analysis.sh <model dir>

Analyse the difference between ground truth (model) displacements and ANTs SyN
estimated displacements computed with Mutual Information metric. Outcommented code is not necesary for final results.

For each nonzero tumor segment

Segmentation.nii.gz:

0: Outside of tumor
1: Necrosis
2: Edema
3: Enhancing
'
model=$1
synres="antssynmi"

# Vectors to show the error: GT - estimated displacement
c="fslmaths $model/interp-field-*.*mm.nii.gz -sub $model/$synres/transform0InverseWarp-vec.nii.gz $model/$synres/diff.nii.gz"
eval $c

# Absolute value of error vectors
c="fslmaths $model/$synres/diff.nii.gz -sqr -Tmean -mul 3 -sqrt $model/$synres/normdiff.nii.gz"
eval $c
: '
# Opposite calculation, for correct visualization in ITK-SNAP
# Vectors to show the error: GT - estimated displacement
c="fslmaths $model/interp-neg-field-*.*mm.nii.gz -sub $model/$synres/transform0Warp-vec.nii.gz $model/$synres/negdiff.nii.gz"
eval $c

# Absolute value of error vectors, opposite
c="fslmaths $model/$synres/negdiff.nii.gz -sqr -Tmean -mul 3 -sqrt $model/$synres/normnegdiff.nii.gz"
eval $c
'
# Absolute value of estimated displacement
c="fslmaths $model/interp-field-*.*mm.nii.gz -sqr -Tmean -mul 3 -sqrt $model/$synres/normgt.nii.gz"
eval $c

# Relative absolute of error vectors
c="fslmaths $model/$synres/normdiff.nii.gz -div $model/$synres/normgt.nii.gz $model/$synres/normdiff-relative.nii.gz"
eval $c
: '
# Absolute value of estimated displacement, opposite
c="fslmaths $model/interp-neg-field-*.*mm.nii.gz -sqr -Tmean -mul 3 -sqrt $model/$synres/normneggt.nii.gz"
eval $c

# Relative absolute of error vectors, opposite
c="fslmaths $model/$synres/normnegdiff.nii.gz -div $model/$synres/normneggt.nii.gz $model/$synres/normnegdiff-relative.nii.gz"
eval $c
'
# Get parent directory of model directory
patient=$(dirname $model)

# Calculate mean of nonzero absolute error vector values in tumor segments, forward in time
c="fslstats -K $patient/Segmentation.nii.gz $model/$synres/normdiff.nii.gz -M > $model/$synres/mean-normdiff-segmentation.txt"
eval $c
: '
# Calculate mean of nonzero absolute error vector values in tumor segments, backwards in time
c="fslstats -K $patient/Segmentation.nii.gz $model/$synres/normnegdiff.nii.gz -M > $model/$synres/mean-normnegdiff-segmentation.txt"
eval $c
'
# Calculate mean of nonzero relative absolute error vector values in tumor segments, forward in time
c="fslstats -K $patient/Segmentation.nii.gz $model/$synres/normdiff-relative.nii.gz -M > $model/$synres/mean-normdiff-relative-segmentation.txt"
eval $c
: '
# Calculate mean of nonzero relative absolute error vector values in tumor segments, backwards in time
c="fslstats -K $patient/Segmentation.nii.gz $model/$synres/normnegdiff-relative.nii.gz -M > $model/$synres/mean-normnegdiff-relative-segmentation.txt"
eval $c
'
