# utility-tools
Small tools for users of Lumi

Shared settings are in `settings.sh`
Here you can set the timeouts, toggle if ssh to compute nodes is enabled
and change the name of the supercomputer. 



## start-jupyter
Will start a juptyer notebook and print connection information so that users can forward a port to Lumi and then connect to the 
notebook in their local browser. 

## VNC
Scripts for starting a minimal vnc server +  novnc proxy
- `_start_vnc` main script responsible for starting the VNC and proxy 
- `_get_vnc_display` runs the main script in the background and sets `DISPLAY`+some
utility functions. The utility function are
    - `stop-vnc` stops the vnc, resets `DISPLAY` and removes and related functions
    - `vnc-status` returns 0 if the vnc is running
    - `vnc-info` Prints the connection information for the vnc

`_get_vnc_display` has to be sourced so that the variables and utility
function can be set in the current shell. This can be achieved by:

1. `source /path/to/_get_vnc_display`
2. `alias start-vnc="source /path/to/_get_vnc_display"`
3. `function start-vnc { source /path/to/_get_vnc_display "$@"  ;} && export -f start-vnc`

Aliases are not exported to subshells + `shopt -s expand_aliases` does not help
us with sbatch scripts. So the alias needs to be set in the job file (e.g by loading a module)
and can not be inherited from the submission environment.

Note, the vnc script does not start any program so connecting
works but only a gray screen is shown before some programs are started
The base container includes `xterm` which can be used as a sanity check

As the vnc is sourced a job will end 
after the last command is done
If for some reason this is not wanted
and extra wait has to be added to the end of the script
