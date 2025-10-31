#! /usr/bin/env bash

set -x

onavim=$(dirname $0)
read version <$onavim/src/version
[[ ! -e onavim-$version.tar.gz ]] && $onavim/source.sh
podman build -f Dockerfile.pd --build-arg=BASE_IMAGE=$1 -t=$2
