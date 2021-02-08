#!/bin/bash

DATASOURCE=github-tags
REPO=docker/cli
VERSION=20.10.2

# Update version
for FORMULA in docker-bin docker-rootless-bin; do
    if test -f "Formula/${FORMULA}.rb"; then
        sed -E -i "s|/docker-((.+)-)?([^-]+).tgz|/docker-\1${VERSION}.tgz|" "Formula/${FORMULA}.rb"
    fi
done

# Update SHA256
#TODO