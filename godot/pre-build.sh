#!/usr/bin/env bash
set -euo pipefail

PROJECT=project.godot
VERSION="$(git describe --tags --abbrev=0)-$(date +%Y%m%d-%H%M)-$(git rev-parse --short=8 HEAD)$(git diff --quiet || echo -dirty)"

echo
echo "Current application config:"
grep -E '^config/(name|version)=' "$PROJECT"

echo
echo "Setting version to: $VERSION"
if grep -q '^config/version=' "$PROJECT"; then
	sed -i "s|^config/version=\".*\"$|config/version=\"$VERSION\"|" "$PROJECT"
else
	awk -v v="$VERSION" '
        {
            print
            if ($0 ~ /^config\/name="/)
                print "config/version=\"" v "\""
        }
    ' "$PROJECT" >"$PROJECT.tmp"

	mv "$PROJECT.tmp" "$PROJECT"
fi

echo
echo "Current application config:"
grep -E '^config/(name|version)=' "$PROJECT"
