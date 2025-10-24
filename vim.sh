#! /usr/bin/env bash

set -x

buildRoot=$1
onavimDir=$2

git clone https://github.com/vim/vim.git
sed -i '1s:/usr/bin/python:/usr/bin/python3:' vim/runtime/tools/demoserver.py
cd vim/src
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
