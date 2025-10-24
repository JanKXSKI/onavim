#! /usr/bin/env bash

set -x

buildRoot=$1
onavimDir=$2

cd $buildRoot/$onavimDir
npm install pyright
