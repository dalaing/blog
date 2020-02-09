#!/usr/bin/env bash

cabal new-build
git submodule init
git submodule update
pushd _site && git checkout master && popd
cabal new-run site -- build  
