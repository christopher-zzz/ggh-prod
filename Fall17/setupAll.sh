#!/bin/bash

htype=${1}
hmass=${2}
hwidth=${3}
tanb=${4}
alpha=${5}
hfact_t=${6}	# hdamp value for top scale
hfact_b=${7}	# " for bottom scale
hfact_tb=${8} 	# " for interference scale
njobs=${9}

./setup.sh ${htype} ${hmass} ${hwidth} ${tanb} t t ${hfact_t} ${alpha} ${njobs}
./setup.sh ${htype} ${hmass} ${hwidth} ${tanb} b b ${hfact_b} ${alpha} ${njobs} 
./setup.sh ${htype} ${hmass} ${hwidth} ${tanb} tb tb ${hfact_tb} ${alpha} ${njobs} 
./setup.sh ${htype} ${hmass} ${hwidth} ${tanb} t tb ${hfact_tb} ${alpha} ${njobs} 
./setup.sh ${htype} ${hmass} ${hwidth} ${tanb} b tb ${hfact_tb} ${alpha} ${njobs} 
