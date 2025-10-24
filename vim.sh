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
cp -r "$(dirname $0)/src/vim" "$etc"
curl -fLo "$etc/vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

export VIM="$etc/vim"
export VIMRUNTIME="$buildRoot$onavimDir/vim/vim91"
"$buildRoot$onavimDir/bin/vim" --cmd "set runtimepath=$etc/vim,$VIMRUNTIME" -c "PlugInstall | qa"
