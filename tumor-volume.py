import sys
import nibabel as nib

d = nib.load(sys.argv[1]).get_fdata()
print((d != 0).sum())
