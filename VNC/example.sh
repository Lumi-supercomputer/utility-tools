#!/bin/bash
#SBATCH --partition=small
#SBATCH --time=00:15:00
#SBATCH --account=project_462000007


# The connection info will be shown
# in the output file of the job

# Here we assume that a function has been defined 
start-vnc

# As the vnc is sourced the job will end 
# after the last command is done
# If for some reason this is not wanted
# and extra wait has to be added to the end of the script
singularity exec vnc.sif xterm
