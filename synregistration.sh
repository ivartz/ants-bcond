run_evals=1
fixedimg=$1
movingimg=$2
brainmask=$3
outdir=$4
#ANTsDirectory="/cygdrive/e/ANTs" # Windows
ANTsDirectory=$(dirname $(which antsRegistration)) # Linux

# Elies suggested but with 1 instead of 0.25 on MI metric
# since it did not slow down the registration any significant
command="$ANTsDirectory/antsRegistration \
    --dimensionality 3 \
    --float 0 \
    --output $outdir/transform \
    --interpolation Linear \
    --winsorize-image-intensities [0.001,0.999] \
    --use-histogram-matching 0 \
    --transform SyN[0.1,3,0] \
    --metric MI[$fixedimg,$movingimg,1,32,Regular,1] \
    --convergence [100x70x50x20,1e-6,10] \
    --shrink-factors 8x4x2x1 \
    --smoothing-sigmas 3x2x1x0vox \
    -x $brainmask \
    --verbose 0"

# Without brainmask
commandnobm="$ANTsDirectory/antsRegistration \
    --dimensionality 3 \
    --float 0 \
    --output $outdir/transform \
    --interpolation Linear \
    --winsorize-image-intensities [0.001,0.999] \
    --use-histogram-matching 0 \
    --transform SyN[0.1,3,0] \
    --metric MI[$fixedimg,$movingimg,1,32,Regular,0.25] \
    --convergence [100x70x50x20,1e-6,10] \
    --shrink-factors 8x4x2x1 \
    --smoothing-sigmas 3x2x1x0vox \
    --verbose 0"

# CC instead
commandcc="$ANTsDirectory/antsRegistration \
    --dimensionality 3 \
    --float 0 \
    --output $outdir/transform \
    --interpolation Linear \
    --winsorize-image-intensities [0.001,0.999] \
    --use-histogram-matching 0 \
    --transform SyN[0.1,3,0] \
    --metric CC[$fixedimg,$movingimg,1,4] \
    --convergence [100x70x50x20,1e-6,10] \
    --shrink-factors 8x4x2x1 \
    --smoothing-sigmas 3x2x1x0vox \
    -x $brainmask \
    --verbose 0"

echo $command
if [ $run_evals == 1 ]; then
    eval $command
fi
