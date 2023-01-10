


### SETTINGS

# Does the system allow ssh to compute nodes
# yes/no
SSH_TO_COMPUTE="no"

#name of the supercomputer
SUPERCOMPUTER=lumi

#Frontend address of the supercomputer
MAIN_URL=$SUPERCOMPUTER.csc.fi

#How long to wait before quitting if no connection has been established
VNC_TIMEOUT=60
NOTEBOOK_TIMEOUT=60

# 
JOB_ONLY="no"

### END OF SETTINGS






if [[ "$SSH_TO_COMPUTE" == "yes" ]];then
    _HN=localhost
    _TARGET_HOST="$USER@$(hostname)"
    _JUMP_HOST=" -J $USER@$MAIN_URL"
    _IP="127.0.0.1"
elif [[ "$SSH_TO_COMPUTE" == "no" ]]; then
    # the name reported by just hostname might not be routable, find one which is
    names=($(hostname -A ))
    for n in "${names[@]}"; do 
       ping -c 1 -w 1 $n &>/dev/null && { export _HN=$n; break ;} 
    done
    _TARGET_HOST="$USER@$MAIN_URL"
    _JUMP_HOST=""
    _IP="0.0.0.0"
else
    echo "FATAL (internal error): Unsupported value for SSH_TO_COMPUTE "
    exit 1 
fi

