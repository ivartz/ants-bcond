# First, with run_evals=0
# cd /cygdrive/z/code/ants-bcond
# bash distribute-data.sh >> "/cygdrive/z/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-distributed/distributed-log.txt"

# Copy data to ants nodes from the machine with SSH access

#dataset_dist="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-distributed"
dataset_dist="/cygdrive/z/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-distributed"

run_evals=1

#for ((i = 1; i<10; i++)); do c="mkdir $i"; eval $c; done

readarray -t splits < <(find $dataset_dist -mindepth 1 -maxdepth 1 -type d | sort | head -n 4)

# NREC Ubuntu 18.04 LTS VMs
ips=("158.39.77.86" "158.39.77.109" "158.39.77.161" "158.39.77.209")

num_ips=${#ips[*]}

num_splits=${#splits[*]}


for ((i=0; i<num_ips; i++)); do
    ip=${ips[$i]}
    data=${splits[$i]}
    c="ssh-keygen -R $ip"
    if [ $run_evals == 1 ]; then
        #eval $c
        :
    else
        #echo $c
        :
    fi
    c="rsync -avh --info=progress2 -e 'ssh -o StrictHostKeyChecking=no -i /home/ivar/craiivar.key' $data/* ubuntu@$ip:/home/ubuntu/data2"
    if [ $run_evals == 1 ]; then
        eval $c
    else
        echo $c
    fi
done
