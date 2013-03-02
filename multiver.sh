#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
MULTIVER_ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

INTERNALCMD=()
EXTENDEDPARAMS=()
for arg in "$@"
do
    if [[ "--" == "${arg:0:2}" ]]; then
        EXTENDEDPARAMS+=("$arg")
    else
        INTERNALCMD+=("$arg")
    fi
done

MAINCMD="${INTERNALCMD[0]}"
INTERNALCMD="${INTERNALCMD[@]:1}"

source "$MULTIVER_ROOT/bsfl"
source "$MULTIVER_ROOT/commands/$MAINCMD.sh"

