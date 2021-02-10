#!/bin/bash

DATASOURCE=github-releases
REPO=rootless-containers/slirp4netns
VERSION=1.1.8

# Update url
for FORMULA in slirp4netns-bin; do
    if test -f "Formula/${FORMULA}.rb"; then
        echo "Updating URLs for formula ${FORMULA}"
        sed -E -i "s|/download/v([^/]+)/slirp4netns-|/download/v${VERSION}/slirp4netns-|" "Formula/${FORMULA}.rb"
    fi
done

# Update tag
for FORMULA in slirp4netns; do
    if test -f "Formula/${FORMULA}.rb"; then
        echo "Updating tag for formula ${FORMULA}"
        sed -E -i "s|^(\s+)tag: \"v(.+)\"|\1tag: \"v${VERSION}\"|" "Formula/${FORMULA}.rb"
    fi
done

# Update version
for FORMULA in slirp4netns-bin; do
    if test -f "Formula/${FORMULA}.rb"; then
        echo "Updating version for formula ${FORMULA}"
        sed -E -i "s|^(\s+)version \"(.+)\"$|\1version \"${VERSION}\"|" "Formula/${FORMULA}.rb"
    fi
done

# Update SHA256 for URL
for FORMULA in slirp4netns-bin; do
    if test -f "Formula/${FORMULA}.rb"; then
        echo "Updating SHA256 for URL in formula ${FORMULA}"

        URLS=$(grep -E "^\s+url" "Formula/${FORMULA}.rb" | sed -E "s/^\s+url\s\"(.+)\"$/\1/")
        for URL in ${URLS}; do
            echo "Processing ${URL}..."
            SHA256=$(
                curl --silent --location "${URL}" | \
                    sha256sum | \
                    cut -d' ' -f1
            )
            echo "Got SHA256 ${SHA256}"

            mv "Formula/${FORMULA}.rb" "Formula/${FORMULA}.rb.bak"
            cat "Formula/${FORMULA}.rb.bak" | tr '\n' '\r' | sed -E "s|(\s+)url \"${URL}\"\r(\s+)sha256 \"[0-9a-fA-F]+\"|\1url \"${URL}\"\r\2sha256 \"${SHA256}\"|" | tr '\r' '\n' >"Formula/${FORMULA}.rb"
            rm "Formula/${FORMULA}.rb.bak"
        done
    fi
done