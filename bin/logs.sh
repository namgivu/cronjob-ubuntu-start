#!/bin/bash
docstring='
logs.sh will run poll_vault/:SCRIPT and expand log lines to log file ./log/:SCRIPT.log

**sample usage**
SCRIPT=echoNow.sh ./bin/logs.sh
'

SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

[ -z $SCRIPT ] && (echo echo "Param :SCRIPT is required as \$1 - please pick one file in $SH/poll_vault/" ; kill $$) 

cmd="$SH/poll_vault/$SCRIPT"
log="$AH/log/$SCRIPT.log"

eval $cmd >> $log
