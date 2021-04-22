#!/bin/bash

set -e
set -x

# configure variables
mag_inv1=`jq -r '.mag_inv1' config.json`
mag_inv2=`jq -r '.mag_inv2' config.json`
phase_inv1=`jq -r '.phase_inv1' config.json`
phase_inv2=`jq -r '.phase_inv2' config.json`
unit1=`jq -r '.unit1' config.json`
t1=`jq -r '.t1' config.json`
crop=`jq -r '.crop' config.json`

# make output directory
[ ! -d ./output ] && mkdir -p output

# identify the volumes in mp2rage datatype
echo "identifying mp2rage volumes"
volumes=""
potential_volumes="mag_inv1 mag_inv2 phase_inv1 phase_inv2 unit1"
for i in ${potential_volumes}
do
	test_vol=$(eval "echo \$${i}")
	if [ -f ${test_vol} ]; then
		volumes=${volumes}" ${i}"
	fi
done

# if crop == True, crop images. else, just copy with name "cropped" to make it easier
if [[ ${crop} == 'true' ]]; then
	echo "cropping data"
	robustfov -i ${unit1} -r unit1.cropped.nii.gz > fov_log.txt
	fov=`cat fov_log.txt`
	fov=`echo ${fov#*: }`
	for i in ${volumes}
	do
		if [[ ! ${i} == 'unit1' ]]; then
			vol=$(eval "echo \$${i}")
			fslroi ${vol} ${i}.cropped.nii.gz `echo ${fov}`
		fi
	done
else
	echo "data already cropped. copying to working dir"
	for i in ${volumes}
	do
		vol=$(eval "echo \$${i}")
		cp ${vol} ./${i}.cropoped.nii.gz
	done
fi

# compute t1 brainmask
echo "computing t1 brainmask"
bet ${t1} t1_brain -R -m

# compute transformation matrix between mp2rage and t1
echo "computing transform between uni t1 and t1"
flirt -in unit1.cropped.nii.gz -ref t1_brain.nii.gz -omat mp2rage2t1.mat -out ./output/unit1.nii.gz

# loop through remanining volumes and apply transform
echo "applying transform to remaining mp2rage volumes"
for i in ${volumes}
do
	if [[ ! ${i} == 'unit1' ]]; then
		flirt -in ${i}.cropped.nii.gz -ref t1_brain.nii.gz -init mp2rage2t1.mat -applyxfm -out ./output/${i}.nii.gz
	fi
done

echo "alignment complete!"




