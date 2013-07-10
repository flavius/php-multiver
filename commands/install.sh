PHP_VERSION="${INTERNALCMD[1]}"
PHP_MAJORVER=`echo ${PHP_VERSION%%.*}`
PHP_MINORVER=`echo ${PHP_VERSION%.*}`
PHP_MINORVER=`echo ${PHP_MINORVER#*.}`
PHP_PATCHVER=`echo ${PHP_VERSION##*.}`
PHP_BRANCH="php-$PHP_MAJORVER.$PHP_MINORVER.$PHP_PATCHVER"


msg_info "Building bison 2.3"
source "$MULTIVER_ROOT/commands/bison.sh"
#TODO bison versions
export PATH="$MULTIVER_ROOT/build-requirements/bison-$BISON_VER/bin":$PATH

start=`now`
msg_info "Preparing PHP"
pushd "$MULTIVER_ROOT/php-src"
cmd "git checkout $PHP_BRANCH"
cmd "./buildconf --copy --force"
cmd "./genfiles"
DURATION=$(( $(now) - $start ))
msg_info "Preparing PHP took $DURATION seconds"
popd

start=`now`
msg_info "Configuring PHP"
cmd "mkdir -p $MULTIVER_ROOT/build/$PHP_VERSION"
cmd "mkdir -p $MULTIVER_ROOT/inst/$PHP_VERSION"
pushd "$MULTIVER_ROOT/build/$PHP_VERSION"
cmd "$MULTIVER_ROOT/php-src/configure --prefix=$MULTIVER_ROOT/inst/$PHP_VERSION ${EXTENDEDPARAMS[*]}"
DURATION=$(( $(now) - $start ))
msg_info "Configuring PHP took $DURATION seconds"

start=`now`
msg_info "Building PHP"
cmd "make"
DURATION=$(( $(now) - $start ))
msg_info "Making PHP took $DURATION seconds"

start=`now`
msg_info "Installing PHP"
cmd "make install"
DURATION=$(( $(now) - $start ))
msg_info "Installing PHP took $DURATION seconds"

popd

start=`now`
msg_info "Cleaning up PHP source"
pushd "$MULTIVER_ROOT/php-src"
cmd "git clean -fdx"
cmd "git reset --hard master"
cmd "git checkout master"
popd
DURATION=$(( $(now) - $start ))
msg_info "Cleaning the PHP source took $DURATION seconds"

echo "export PATH=$MULTIVER_ROOT/inst/$PHP_VERSION/bin:\$PATH" > "activate_$PHP_VERSION.sh"
echo "-------------------------------------------------------------------------"
echo "you can now type the following to activate php $PHP_VERSION:"
echo "source activate_$PHP_VERSION.sh"
echo "-------------------------------------------------------------------------"
