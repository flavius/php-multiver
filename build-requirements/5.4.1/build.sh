#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
MY_PATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

BISON_VER=2.3

if [[ -x "$MY_PATH/bin/bison" ]]; then
    echo "bison $BISON_VER already installed"
    return 0
fi

pushd "$MY_PATH"
wget http://ftp.gnu.org/gnu/bison/bison-$BISON_VER.tar.bz2
tar xjf bison-$BISON_VER.tar.bz2
pushd bison-$BISON_VER
./configure --prefix="$MY_PATH" && make && make install
popd
rm -rf bison-$BISON_VER*
popd
