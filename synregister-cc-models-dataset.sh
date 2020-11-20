# bash synregister-cc-models-dataset.sh

run_evals=1

# Directory of generated models from cancer-sim, copied and ready
# to be processed and results added to it
dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

# Make array of patient directories, full paths
readarray -t patients < <(find $dataset -mindepth 1 -maxdepth 1 -type d)

for patient in ${patients[*]}; do
    c="bash synregister-cc-models-patient.sh $patient"
    #echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done
