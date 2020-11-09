# bash synregister-models-dataset.sh 2>&1 | tee <dataset>/runlog.txt

run_evals=1

# Directory of generated models from cancer-sim
dataset="/home/ubuntu/data"

# Log the repository version
#echo "https://github.com/ivartz/ants-bcond/commits/master" > $outdir/ants-bcond-version.txt
# shortened hash
#echo $(git log --pretty=format:'%h' -n 1) >> $dataset/ants-bcond-version.txt

# Make array of patient directories, full paths
readarray -t patients < <(find $dataset -mindepth 1 -maxdepth 1 -type d)

for patient in ${patients[*]}; do
    c="bash synregister-models-patient.sh $patient"
    #echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done
