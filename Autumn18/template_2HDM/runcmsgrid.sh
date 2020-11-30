#!/bin/bash

nevt=${1}
rnum=${2}	# SEED

scram_arch_version=slc6_amd64_gcc530
cmssw_version=CMSSW_8_0_22

LHEWORKDIR=`pwd`

#PATH#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/afs/desy.de/user/z/zimmerc/chaplin/lib

export SCRAM_ARCH=$scram_arch_version
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r ${cmssw_version}/src ] ; then
	echo release ${cmssw_version} already exists
else
	scram p CMSSW ${cmssw_version}
fi
cd ${cmssw_version}/src
eval `scram runtime -sh`
cd -

sed -i "s/NEVENTS/${nevt}/g" powheg.input
sed -i "s/SEED/${rnum}/g" powheg.input

echo "Start generating events on " `date`
echo $rnum | ./pwhg_main > lhe_generation.log 2>&1 &
wait
cat pwgevents.lhe | grep -v "Random number generator exit values" > cmsgrid_final.lhe
python mod_scalup.py cmsgrid_final.lhe XHFACTX
cp cmsgrid_final*.lhe ..
mv cmsgrid_final_mod.lhe cmsgrid_final.lhe

xmllint --noout cmsgrid_final.lhe > /dev/null 2>&1; test $? -eq 0 || fail_exit "xmllint integrity check failed on pwgevents.lhe"

echo "End of job on " `date`
