#!/bin/bash

# Itch.io details.
ITCH_USERNAME="kraasch"
ITCH_GAME_ID="ur"
BUTLER_PATH="${HOME}/.local/bin/butler"
BUILD_DIR="./builds"

# Define builds.
WEB_BUILD="$BUILD_DIR/web"

# Upload builds.
$BUTLER_PATH push "$WEB_BUILD" "$ITCH_USERNAME/$ITCH_GAME_ID:web"
echo "All builds uploaded."
