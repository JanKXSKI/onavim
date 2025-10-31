#! /usr/bin/env bash

set -e
set -x

onavim=$(dirname $0)
read version <$onavim/src/version
$onavim/source.sh
cp $onavim/onavim.spec ~/rpmbuild/SPECS
mv onavim-$version.tar.gz ~/rpmbuild/SOURCES
rpmbuild -ba ~/rpmbuild/SPECS/onavim.spec
