# bash synregister-models-patient.sh <patient models dir>

run_evals=1

patientdir=$1
fixedimg="$patientdir/T1c.nii.gz"
brainmask="$patientdir/BrainExtractionMask.nii.gz"

# Make array of patient models, full paths
readarray -t models < <(find $patientdir -mindepth 1 -maxdepth 1 -type d)

for model in ${models[*]}; do
    #echo $model
    outdir="$model/antssyncc"
    c="mkdir -p $outdir"
    #echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
    movingimg="$model/warped.nii.gz"
    c="bash synregistration.sh $fixedimg $movingimg $brainmask $outdir"
    #echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done
