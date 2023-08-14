#!/bin/bash

pushd .
cd bin
./get_hugo
popd

pushd .
cd nbsite
../bin/hugo serve -D --noHTTPCache $*
popd

