dataset="/mnt/HDD3TB/derivatives/cancer-sim-SAILOR_PROCESSED_MNI-01"

bash synregister-cc-models-dataset.sh
bash synregister-mi-models-dataset.sh

bash analyse-syn-cc-dataset.sh
bash analyse-syn-mi-dataset.sh

bash collect-syn-cc-estimation-error-segments.sh 0 > $dataset/syn-cc-estimation-error-segments.txt
bash collect-syn-mi-estimation-error-segments.sh 0 > $dataset/syn-mi-estimation-error-segments.txt

bash collect-syn-cc-estimation-error-segments.sh 1 > $dataset/syn-cc-estimation-error-relative-segments.txt
bash collect-syn-mi-estimation-error-segments.sh 1 > $dataset/syn-mi-estimation-error-relative-segments.txt
