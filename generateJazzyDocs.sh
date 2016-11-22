#!/bin/bash
# Script to generate docs with jazzy. More info: https://github.com/realm/jazzy
# Date&Author : 20161123 by AlbertArroyo

jazzy \
  --clean \
  --author AlbertArroyo \
  --author_url http://www.albertarroyo.com \
  --github_url https://github.com/jimmyaat10 \
  --xcodebuild-arguments -scheme,AATTools \
  --module AATTools \
  --framework-root . \
  --output docs/swift_output \