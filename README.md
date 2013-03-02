A building environment for having multiple PHP versions on the same machine.

Unlike the alternatives, it's meant to work out building dependencies as well.

It also uses the git repository directly, no further downloads necessary. As
a consequence, incremental additions are easy.

PHP Multiver is aimed primarily at developers (particularily, PECL developers).

## Installation

    git clone --recursive git://github.com/flavius/php-multiver.git

This may take a while, because it fetches the PHP source too.

## Compiling a specific version of PHP

    ./multiver.sh install <version> <additional-parameters>

For example:

    ./multiver.sh install 5.4.12 --enable-maintainer-zts --enable-debug \
    --disable-cgi --enable-cli

## Using a specific version:

    export PATH=~/projects/php-multiver/inst/5.4.12/bin:$PATH

