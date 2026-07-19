#!/bin/bash

# Itch.io details.
ITCH_USERNAME="kraasch"
ITCH_GAME_ID="ur"
BUTLER_PATH="${HOME}/.local/bin/butler"
BUILD_DIR="./builds"

# Define builds.
WIN_BUILD="$BUILD_DIR/windows"
LIN_BUILD="$BUILD_DIR/linux"
WEB_BUILD="$BUILD_DIR/web"

# Upload builds.
$BUTLER_PATH push "$WIN_BUILD" "$ITCH_USERNAME/$ITCH_GAME_ID:windows"
$BUTLER_PATH push "$LIN_BUILD" "$ITCH_USERNAME/$ITCH_GAME_ID:linux"
$BUTLER_PATH push "$WEB_BUILD" "$ITCH_USERNAME/$ITCH_GAME_ID:web"
echo "All builds uploaded."
