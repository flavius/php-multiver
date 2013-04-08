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

    ./multiver.sh install 5.4.13 --enable-maintainer-zts --enable-debug \
    --disable-cgi --enable-cli

## Using a specific version:

    source activate_5.4.13.sh

Now using:

    which php

should show you the new binary instead. Simply spawn a new terminal to quickly
revert to the system's default.

## TODO

* More error handling
* Installing more build dependencies (currently only bison 2.3)
* Generate gdb "file" script and various other gdb scripts
* Suggestions?

## Screenshot

![Screenshot](http://i.imm.io/XXKn.png)

## License

    /*
     * ----------------------------------------------------------------------------
     * "THE BEER-WARE LICENSE" (Revision 42):
     * <flavius.as@gmail.com> wrote this file. As long as you retain this notice you
     * can do whatever you want with this stuff. If we meet some day, and you think
     * this stuff is worth it, you can buy me a beer in return
     *
     * Flavius Aspra
     * ----------------------------------------------------------------------------
     */
