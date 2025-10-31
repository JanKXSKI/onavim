#! /usr/bin/env bash

set -e
set -x

onavim=$(dirname $0)
read version <$onavim/src/version
[[ -d onavim-$version ]] && rm -rf onavim-$version
mkdir onavim-$version
trap "rm -rf onavim-$version" EXIT
cp --parents $(git ls-files) onavim-$version
tar --create --file onavim-$version.tar.gz onavim-$version

