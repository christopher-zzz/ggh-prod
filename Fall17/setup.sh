#!/bin/bash

htype=${1}	# h, H or A
hmass=${2}
hwidth=${3}	# in GeV
tanb=${4}
contrib=${5}	# incl, t, b or tb # Combinations are (contrib-scale): incl-t/b/tb, t-t, b-b, tb-tb, t-tb, b-tb 
scale=${6}	# t, b ot tb, scale at which the hfact is chosen, this parameter is only used for naming the run
hfact=${7}
alpha=${8}
njobs=${9}

run="gg_H_2HDM_${htype}${hmass}_${contrib}-${scale}_tanb${tanb}"


if [ "${htype}" = "h" ]; then
        htypeint=25
elif [ "${htype}" = "H" ]; then
        htypeint=35
elif [ "${htype}" = "A" ]; then
        htypeint=36
else
        echo "Invalid htype: ${htype}"
fi

if [ -d ${run} ]; then
    echo "Run already exists, control arguments!"
    exit 1
else
    mkdir ${run}
fi

cd ${run}
mkdir tarball
#PATH# cp /nfs/dust/cms/user/zimmerc/ggh_production/Fall17/template_2HDM/* ./tarball

cd tarball
sed -i "s/XRUNX/${run}/g" *
sed -i "s/XHMASSX/${hmass}/g" *
sed -i "s/XHWIDTHX/${hwidth}/g" *
sed -i "s/XHTYPEX/${htpye}/g" *
sed -i "s/XHTYPEINTX/${htypeint}/g" *
sed -i "s/XTANBX/${tanb}/g" *
sed -i "s/XHFACTX/${hfact}/g" *
sed -i "s/XALPHAX/${alpha}/g" *
sed -i "s/XNJOBSX/${njobs}/g" *

if [ "${htype}" = "h" ]; then
        sed -i "s/higgstype/higgstype 1/g" powheg.input
	sed -i "s/#SM-ON#//g" gen.py
elif [ "${htype}" = "H" ]; then
        sed -i "s/higgstype/higgstype 2/g" powheg.input
	sed -i "s/#2HDM-ON#//g" gen.py
elif [ "${htype}" = "A" ]; then
        sed -i "s/higgstype/higgstype 3/g" powheg.input
	sed -i "s/#2HDM-ON#//g" gen.py
fi

if [ "${contrib}" = "t" ]; then
	echo "nobot 1" >> powheg.input
elif [ "${contrib}" = "b" ]; then
        echo "notop 1" >> powheg.input
fi

mv gen.py ..
mv *.conf ..

tar czf ${run}.tar.gz *
#PATH# mv ${run}.tar.gz /nfs/dust/cms/user/zimmerc/ggh_production/Fall17/CMSSW_9_3_6/src/
cd ..


