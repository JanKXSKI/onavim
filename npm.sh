#! /usr/bin/env bash

set -x

buildRoot=$1
onavimDir=$2

cd $bulidRoot/$onavimDir
npm install pyright
