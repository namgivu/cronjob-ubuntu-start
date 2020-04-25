#!/bin/bash
docstring='
tick.sh will run poll_vault/:POLL_SCRIPT and expand log lines to log file ./log/:POLL_SCRIPT.log

**sample usage**
POLL_SCRIPT=trang-echoNow.sh ./bin/tick.sh
'

SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

if [[ -z POLL_SCRIPT ]]; then echo "Param :POLL_SCRIPT is required as \$1 - please pick one file in $SH/poll_vault/"; exit 1; fi

cmd="$SH/poll_vault/$POLL_SCRIPT"
log="$AH/log/$POLL_SCRIPT.log"
    echo "$cmd >> $log"
    eval $cmd >> $log
    tail $log -n11
