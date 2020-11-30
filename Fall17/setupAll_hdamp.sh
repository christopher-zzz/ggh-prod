#!/bin/bash

htype=${1}
hmass=${2}
hwidth=${3}
tanb=${4}
alpha=${5}
hfact_t=${6}
hfact_b=${7}
hfact_tb=${8}
njobs=${9}

hfact_up_t=$((2*hfact_t))
hfact_up_b=$((2*hfact_b))
hfact_up_tb=$((2*hfact_tb))
hfact_down_t=$(awk -v h=${hfact_t} 'BEGIN { print (h/2) }')
hfact_down_b=$(awk -v h=${hfact_b} 'BEGIN { print (h/2) }')
hfact_down_tb=$(awk -v h=${hfact_tb} 'BEGIN { print (h/2) }')

./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} t t ${hfact_up_t} ${alpha} ${njobs} up
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} b b ${hfact_up_b} ${alpha} ${njobs} up
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} tb tb ${hfact_up_tb} ${alpha} ${njobs} up
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} t tb ${hfact_up_tb} ${alpha} ${njobs} up
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} b tb ${hfact_up_tb} ${alpha} ${njobs} up

./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} t t ${hfact_down_t} ${alpha} ${njobs} down
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} b b ${hfact_down_b} ${alpha} ${njobs} down
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} tb tb ${hfact_down_tb} ${alpha} ${njobs} down
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} t tb ${hfact_down_tb} ${alpha} ${njobs} down
./setup_hdamp.sh ${htype} ${hmass} ${hwidth} ${tanb} b tb ${hfact_down_tb} ${alpha} ${njobs} down

