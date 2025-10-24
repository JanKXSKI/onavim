#! /usr/bin/env bash

buildRoot="$1"
onavimDir="$2"

export VIM="$buildRoot$onavimDir/etc/vim"
export VIMRUNTIME="$buildRoot$onavimDir/vim/vim91"
export VIMINIT=":"
export LANG=en_US.UTF-8
$buildRoot$onavimDir/bin/vim -i NONE -c "PlugInstall | qa"
