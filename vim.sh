#! /usr/bin/env bash

set -x

buildRoot=$1
onavimDir=$2

git clone https://github.com/vim/vim.git
(cd vim
git checkout "v9.1.1868"
sed -i '1s:/usr/bin/python:/usr/bin/python3:' runtime/tools/demoserver.py
(cd src
make \
    DESTDIR="$buildRoot" \
    prefix="$onavimDir" \
    VIMRCLOC="$onavimDir/vim" \
    VIMRUNTIMEDIR="$onavimDir/vim/vim91" \
    BINDIR="$onavimDir/bin" \
    MANDIR="$onavimDir/man" \
    DATADIR="$onavimDir" \
    MAKE="make -e" \
    install
))
