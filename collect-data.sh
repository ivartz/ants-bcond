
#target_dir="/cygdrive/z/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-antsmi/nrec-done"
target_dir="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01-antsmi/nrec-done"

run_evals=1

# NREC Ubuntu 18.04 LTS VMs
ips=("158.39.77.86" "158.39.77.109" "158.39.77.161" "158.39.77.209")

num_ips=${#ips[*]}

for ((i=0; i<num_ips; i++)); do
    ip=${ips[$i]}
    c="ssh-keygen -R $ip"
    if [ $run_evals == 1 ]; then
        #eval $c
        :
    else
        #echo $c
        :
    fi
    #c="rsync -avh --info=progress2 -e 'ssh -o StrictHostKeyChecking=no -i /home/ivar/craiivar.key' ubuntu@$ip:/home/ubuntu/data2/* $target_dir"
    c="rsync -avh --info=progress2 ubuntu@$ip:/home/ubuntu/data2/* $target_dir"
    if [ $run_evals == 1 ]; then
        eval $c
    else
        echo $c
    fi
done
