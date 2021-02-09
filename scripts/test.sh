#!/bin/bash
set -o errexit

FORMULA=$1
if test -z "${FORMULA}"; then
    echo "ERROR: Formula must be specified."
    exit 1
fi

function run() {
    docker run \
        --interactive \
        --rm \
        --mount "type=bind,src=${PWD},dst=/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/${GITHUB_REPOSITORY}" \
        homebrew/brew \
        "$@"
}

function brew() {
    run brew "$@"
}

brew style "${FORMULA}"
brew audit "${FORMULA}"

brew install --build-bottle "${FORMULA}"
if grep "bottle :unneeded" "Formula/${FORMULA}.rb"; then
    brew bottle "${FORMULA}"
fi