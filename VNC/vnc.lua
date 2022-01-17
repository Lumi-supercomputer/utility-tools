-- This will not be inherited from the sumbission env
-- to a batch job script
set_shell_function("start-vnc",'source /path/to/install/_get_vnc_display "$@"')
