#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/.." && pwd)  # AH aka APP_HOME

LOG="$AH/log/log.txt"

cd $AH
    PYTHONPATH=$AH  pipenv run python "./src/main.py"  | tee -a $LOG
    #                                 app entry point        log file
cd - 1>/dev/null
