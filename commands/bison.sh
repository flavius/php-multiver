BISON_VER=2.3
BISON_PREFIX="$MULTIVER_ROOT/build-requirements/bison-$BISON_VER"
BISON_BUILDIR="$MULTIVER_ROOT/build"

if [[ -x "$BISON_PREFIX/bin/bison" ]]; then
    return 0
fi

mkdir -p "$BISON_BUILDIR"
pushd "$BISON_BUILDIR"
if [[ ! -f "bison-$BISON_VER.tar.bz2" ]]; then
    cmd "wget http://ftp.gnu.org/gnu/bison/bison-$BISON_VER.tar.bz2"
fi
cmd "tar xjf bison-$BISON_VER.tar.bz2"
cd "bison-$BISON_VER"

start=`now`
cmd "./configure --prefix=$BISON_PREFIX"
DURATION=$(( $(now) - $start ))
msg_info "Configure took $DURATION seconds"

start=`now`
cmd "make"
DURATION=$(( $(now) - $start ))
msg_info "Make took $DURATION seconds"

start=`now`
cmd "make install"
DURATION=$(( $(now) - $start ))
msg_info "Install took $DURATION seconds"

popd
