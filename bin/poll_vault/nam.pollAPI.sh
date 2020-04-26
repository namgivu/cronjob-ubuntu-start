#!/usr/bin/env bash
SH=$(cd `dirname $BASH_SOURCE` && pwd)  # SH aka SCRIPT_HOME the containing folder of this script
AH=$(cd "$SH/../.." && pwd)  # AH aka APP_HOME

cd $AH
    PYTHONPATH=$AH  ./.venv/bin/python ./src/main.py
    #                                  app entry point
cd - 1>/dev/null

#TODO move nam.pollAPI .sh script and py app into folder ./bin/poll_vault/nam.pollAPI/
