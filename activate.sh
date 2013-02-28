#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
MULTIVER_ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

PHP_VERSION=$1
PHP_MAJORVER=`echo ${PHP_VERSION%%.*}`
PHP_MINORVER=`echo ${PHP_VERSION%.*}`
PHP_MINORVER=`echo ${PHP_MINORVER#*.}`
PHP_PATCHVER=`echo ${PHP_VERSION##*.}`
PHP_BRANCH="php-$PHP_MAJORVER.$PHP_MINORVER.$PHP_PATCHVER"

echo "Building prerequisites"
source "$MULTIVER_ROOT/build-requirements/$PHP_VERSION/build.sh"
export PATH="$MULTIVER_ROOT/built-requirements/$PHP_VERSION/bin":$PATH

echo "Preparing PHP"
pushd "$MULTIVER_ROOT/php-src"
git checkout $PHP_BRANCH
./buildconf --copy --force
./genfiles
popd

echo "Configuring PHP"
mkdir -p "$MULTIVER_ROOT/build/$PHP_VERSION"
pushd "$MULTIVER_ROOT/build/$PHP_VERSION"
"$MULTIVER_ROOT/php-src/configure" --prefix="$MULTIVER_ROOT/inst/$PHP_VERSION" ${@:2}
echo "Building PHP"
make
echo "Installing PHP"
make install
popd

echo "Cleaning up PHP source"
pushd "$MULTIVER_ROOT/php-src"
git clean -fdx
git reset --hard master
git checkout master
popd
