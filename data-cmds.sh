# Copy data to ants nodes from the machine with SSH access

#dataset_dist="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-distributed"
dataset_dist="/cygdrive/z/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-distributed"

run_evals=1

#for ((i = 1; i<10; i++)); do c="mkdir $i"; eval $c; done

readarray -t splits < <(find $dataset_dist -mindepth 1 -maxdepth 1 -type d)

ips=("158.39.77.109")

num_ips=${#ips[*]}

num_splits=${#splits[*]}


for ((i=0; i<num_ips; i++)); do
    ip=${ips[$i]}
    data=${splits[$i]}
    c="rsync -avh --info=progress2 -e 'ssh -i /home/ivar/craiivar.key' $data/* ubuntu@$ip:/home/ubuntu/data"
    echo $c
    if [ $run_evals == 1 ]; then
        eval $c
    fi
done

: '
for ((i=0; i<num_splits; i++)); do
    echo ${splits[$i]}
done
'
