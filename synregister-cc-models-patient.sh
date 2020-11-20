# bash synregister-models-patient.sh <patient models dir>

run_evals=1

patientdir=$1
fixedimg="$patientdir/T1c.nii.gz"
brainmask="$patientdir/BrainExtractionMask.nii.gz"

# Make array of patient models, full paths
readarray -t models < <(find $patientdir -mindepth 1 -maxdepth 1 -type d)

for model in ${models[*]}; do
    outdir="$model/antssyncc"
    c="mkdir -p $outdir"
    if [ $run_evals == 1 ]; then
        eval $c
    fi
    movingimg="$model/warped.nii.gz"
    c="bash synregistration-cc.sh $fixedimg $movingimg $brainmask $outdir"
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done
