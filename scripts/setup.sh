#!/usr/bin/env bash

cabal new-update
cabal new-configure
cabal new-build --only-dependencies
