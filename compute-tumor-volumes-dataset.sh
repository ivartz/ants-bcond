run_evals=1

dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

readarray -t segments < <(find $dataset -type f -name Segmentation.nii.gz | sort)

num_segments=${#segments[*]}

i=1

for segment in ${segments[*]}; do
    echo "$i/$num_segments"
    patientdir=$(dirname $segment)
    patient=$(basename $patientdir)
    c1="echo $patient > $patientdir/Segmentation-mm3-volumes.txt"
    c2="python3 tumor-volumes.py $segment >> $patientdir/Segmentation-mm3-volumes.txt"
    if [ $run_evals == 1 ]; then
        eval $c1
        eval $c2
    fi
    i=$(($i+1))
done
