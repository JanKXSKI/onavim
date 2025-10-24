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

etc="$buildRoot$onavimDir/etc"
mkdir -p "$etc"
cp -r "$(dirname $0)/src/etc/vim" "$etc"

export VIMRUNTIME="$buildRoot$onavimDir/vim/vim91"
export VIMINIT=":set runtimepath=$etc/vim,$VIMRUNTIME|:source $etc/vim/vimrc"
"$buildRoot$onavimDir/bin/vim" -c "PlugInstall | qa"
