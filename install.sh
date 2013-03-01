PHP_VERSION="${INTERNALCMD[1]}"
PHP_MAJORVER=`echo ${PHP_VERSION%%.*}`
PHP_MINORVER=`echo ${PHP_VERSION%.*}`
PHP_MINORVER=`echo ${PHP_MINORVER#*.}`
PHP_PATCHVER=`echo ${PHP_VERSION##*.}`
PHP_BRANCH="php-$PHP_MAJORVER.$PHP_MINORVER.$PHP_PATCHVER"


msg_info "Building prerequisites"
cmd "$MULTIVER_ROOT/build-requirements/$PHP_VERSION/build.sh"
export PATH="$MULTIVER_ROOT/built-requirements/$PHP_VERSION/bin":$PATH

msg_info "Preparing PHP"
pushd "$MULTIVER_ROOT/php-src"
cmd "git checkout $PHP_BRANCH"
cmd "./buildconf --copy --force"
cmd "./genfiles"
popd

msg_info "Configuring PHP"
cmd "mkdir -p $MULTIVER_ROOT/build/$PHP_VERSION"
pushd "$MULTIVER_ROOT/build/$PHP_VERSION"
cmd "$MULTIVER_ROOT/php-src/configure --prefix=$MULTIVER_ROOT/inst/$PHP_VERSION ${@:2}"
msg_info "Building PHP"
cmd "make"
msg_info "Installing PHP"
cmd "make install"
popd

msg_info "Cleaning up PHP source"
pushd "$MULTIVER_ROOT/php-src"
cmd "git clean -fdx"
cmd "git reset --hard master"
cmd "git checkout master"
popd

