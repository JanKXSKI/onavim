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
export VIM="$buildRoot$onavimDir/vim"
export VIMRUNTIME="$VIM/vim91"
curl -fLo "$VIM/vim91/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

cp -r "$(dirname $0)/src/vim" "$buildRoot$onavimDir"

#"$buildRoot$onavimDir/bin/vim" --cmd "set runtimepath=$VIMRUNTIME" -u "$VIM/vimrc" -c "PlugInstall | qa"
