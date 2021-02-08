#!/bin/bash
set -o errexit

FORMULA=$1
if test -z "${FORMULA}"; then
    echo "ERROR: Formula must be specified."
    exit 1
fi

function brew() {
    docker run \
        --interactive \
        --rm \
        --user "$(id -u):$(id -g)" \
        --mount "type=bind,src=${PWD},dst=/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/${GITHUB_REPOSITORY}" \
        homebrew/brew \
        brew "$@"
}

brew style "${FORMULA}"
brew audit "${FORMULA}"
brew install --build-bottle "${FORMULA}"
brew test "${FORMULA}"
brew bottle "${FORMULA}"