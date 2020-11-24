run_evals=1

dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

readarray -t files < <(find $dataset -type f -name Segmentation-total-mm3-volume.txt | sort)

for file in ${files[*]}; do
    printf "%s\t%s\n" $(head -n 1 $file) $(tail -n 1 $file)
done
