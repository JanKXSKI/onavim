#! /usr/bin/env bash

set -x

buildRoot=$1
onavimDir=$2

mkdir -p $buildRoot/$onavimDir
cd $buildRoot/$onavimDir
npm install pyright
