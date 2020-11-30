# ggh-prod

## Instructions for GEN step

1. Install CHAPLIN libraries on your system https://chaplin.hepforge.org/
2. `cd ggh-prod/<era>`
3. change all the paths in the setup scripts and those in the template directory according to your setup. Lines conatining paths that need to be changed begin with `#PATH#` 
4. The grid-control config in the template folder is configured for usage on NAF, change this according to your setup
5. Setup the CMSSW version corresponding to table 1.

You can now setup a single run using `setup.sh` with the arguments defined in the first lines of the script. The script `setupAll.sh` automatically initializes 4 directories for each of the contributions.
For hdamp/hfact variations, the script `setup_hdamp.sh` in the `Fall17` directory can be used to add `_hdampup` or `_hdampdown` to the name of the run, the scale needs to be changed by hand.
The script `setupALL_hdamp.sh` again initializes two directories for each of the contributions, one for downwards and one for upwards variations of the damping scale. The damping parameters in the input are the **central** ones, the script automatically performs the variations of the scale. 

After a run directory is initialized, you can submit the jobs using the config in the specific directory. If Powheg fails, you can try to compile it and replace the old `pwhg_main` in the template directory.

## Instructions for miniAOD (GENSIM + RECO)
1. Produce a gridpack of the desired run (inclusive) (see next section)
2. Setup the CMSSW version corresponding to table 1 and copy your gridpack to `CMSSW_X_Y_Z/src/`
3. Each run folder needs to be setup by hand `mkdir <run-name> ; cd <run-name>`
4. Copy files from miniAOD folder `cp ../miniAOD/* .` and change the paths and filenames marked by `#PATH#` accroding to your setup
5. `cmsenv` in the CMSSW version from table 1 for the GENSIM step and submit the jobs
6. `dataset_list_from_gc.py -o filelist_gensim.txt <grid-control config>
7. `cmsenv` in the CMSSW version from table 1 for the miniAOD step and submit the jobs

You can first run the GEN step and then the SIM+RECO step (without using gridpacks), tbut this needs to be done by hand. Use the scripts from the two steps and modify them as needed.

## Instructions for gridpack production
https://twiki.cern.ch/twiki/bin/viewauth/CMS/PowhegBOXPrecompiled#Step_1_Compiling_the_POWHEG_sour
1. Setup `CMSSW_9_3_6` and `cd CMSSW_9_3_6/src`
2. `cp -r ../../gridpack/* .`
3. run `setup.sh` with the necessary arguments (lines 3-7 in the script)

**Table 1:**
|step|Summer16|Fall17|Autumn18|
|----|--------|------|--------|
|GEN/GENSIM|CMSSW_7_1_32_patch1|CMSSW_9_3_6|CMSSW_10_2_3|
|miniAOD| |CMSSW_9_4_7| |
