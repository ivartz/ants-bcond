dir="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

synres="antssyncc"

#readarray -t transforms < <(find $dir -type f -name transform0Warp.nii.gz)

readarray -t transforms < <(find $dir -type f -wholename *$synres/transform0Warp.nii.gz)

num_files=${#transforms[*]}

i=1

for transform in ${transforms[*]}; do
    echo "$i/$num_files"
    d=$(dirname $transform)
    f=$(basename $transform)
    fwoe=${f%.*.*}
    c1="c3d -mcs $transform -oo $d/${fwoe}-vecx.nii.gz $d/${fwoe}-vecy.nii.gz $d/${fwoe}-vecz.nii.gz"
    eval $c1
    c2="fslmerge -t $d/${fwoe}-vec.nii.gz $d/${fwoe}-vecx.nii.gz $d/${fwoe}-vecy.nii.gz $d/${fwoe}-vecz.nii.gz"
    eval $c2
    r="rm $d/${fwoe}-vec[x,y,z].nii.gz"
    eval $r
    i=$(($i+1))
done

readarray -t transforms < <(find $dir -type f -wholename *$synres/transform0InverseWarp.nii.gz)

num_files=${#transforms[*]}

i=1

for transform in ${transforms[*]}; do
    echo "$i/$num_files"
    d=$(dirname $transform)
    f=$(basename $transform)
    fwoe=${f%.*.*}
    c1="c3d -mcs $transform -oo $d/${fwoe}-vecx.nii.gz $d/${fwoe}-vecy.nii.gz $d/${fwoe}-vecz.nii.gz"
    eval $c1
    c2="fslmerge -t $d/${fwoe}-vec.nii.gz $d/${fwoe}-vecx.nii.gz $d/${fwoe}-vecy.nii.gz $d/${fwoe}-vecz.nii.gz"
    eval $c2
    r="rm $d/${fwoe}-vec[x,y,z].nii.gz"
    eval $r
    i=$(($i+1))
done
