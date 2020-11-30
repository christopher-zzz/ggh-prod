#!/bin/bash

hmass=$1
hwidth=$2
tanb=$3
alpha=$4
hfact=$5

if [[ $hmass -le 125 ]] ; then
	htype="h"
	htypeint=1
else
	htype="H"
	htypeint=2
fi

run="gg_H_2HDM_${htype}${hmass}_tanb${tanb}"
mkdir $run

input="./inputs/powheg.input_${run}"
cp "./inputs/powheg.input.template" $input

sed -i "s/XHMASSX/$hmass/g" $input
sed -i "s/XHWIDTHX/$hwidth/g" $input
sed -i "s/XHTYPEINTX/$htypeint/g" $input
sed -i "s/XTANBX/$tanb/g" $input
sed -i "s/XALPHAX/$alpha/g" $input
sed -i "s/XHFACTX/$hfact/g" $input

echo `date` "Starting gridpack production."
python ./run_pwg.py -p f -i $input -m gg_H_2HDM -f $run -d 1 -n 1000

echo `date` "Searching for gridpack..."
# check if tarball has been created
while ! ls ./*${run}.tgz > /dev/null 2>&1
do
	echo -e "\e[1A\e[K`date` Searching for gridpack..."
	sleep 10
done

echo `date` "Finished! Gridpack has been created."
