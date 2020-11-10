# bash synregister-models-dataset.sh 2>&1 | tee <dataset>/runlog.txt

run_evals=1

# Directory of generated models from cancer-sim (on NREC VMs)
#dataset="/home/ubuntu/data"
# Directory of generated models from cancer-sim (on z600)
dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-antscc"

# Log the repository version
echo "https://github.com/ivartz/ants-bcond/commits/master" > $dataset/ants-bcond-version.txt
# shortened hash
echo $(git log --pretty=format:'%h' -n 1) >> $dataset/ants-bcond-version.txt

# Make array of patient directories, full paths
readarray -t patients < <(find $dataset -mindepth 1 -maxdepth 1 -type d)

for patient in ${patients[*]}; do
    c="bash synregister-models-patient.sh $patient"
    #echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done
