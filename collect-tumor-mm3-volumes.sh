run_evals=1

dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

readarray -t files < <(find $dataset -type f -name Segmentation-mm3-volumes.txt | sort)

for file in ${files[*]}; do
    printf "%s\t%s\t%s\t%s\n" $(sed -n 1p $file | tr -d " ") $(sed -n 2p $file | tr -d " ") $(sed -n 3p $file | tr -d " ") $(sed -n 4p $file | tr -d " ")
done
