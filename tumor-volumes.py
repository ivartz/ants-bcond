import sys
import nibabel as nib
import numpy as np

d = nib.load(sys.argv[1]).get_fdata()
for i in range(np.int(d.max())):
    v = i+1
    m = (d == v)
    if not np.any(m):
        print("nan")
    else:
        print(m.sum())
