#!/bin/bash
#SBATCH --partition=small
#SBATCH --time=00:15:00
#SBATCH --account=project_462000007

# The connection info will be shown
# in the output file of the job

# Here we assume that a function has been defined 
# e.g 
# function start-vnc { source /some/path/_get_vnc_display "$@"  ;} && export -f start-vnc`
# Hopefully this is part of a module
# Note though that the module most 
# likely has to be loaded in the batch job
# as there is no way to export functions from lmod
# module load vnc
start-vnc
singularity exec vnc.sif xterm
