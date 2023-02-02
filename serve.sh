#!/bin/bash

pushd .
cd bin
./get_zola
popd

pushd .
cd site
../bin/zola serve $*
popd

