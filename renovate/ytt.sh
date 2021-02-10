#!/bin/bash

DATASOURCE=github-releases
REPO=opencontainers/runc
VERSION=1.0.0-rc93

brew bump-formula-pr "--version=${VERSION}" nicholasdille/tap/ytt
