#!/bin/bash

# delete_steam_shortcuts.sh - A script to delete .url files containing specific patterns
# TODO: Move this script to a better repository?
# This script deletes all .url files in the current directory that contain the text "URL=steam://rungameid/"
# See https://chatgpt.com/c/682b4179-b6f8-8007-97e4-bad2fa6230ab
# Usage: Run this script in the directory where you want to clean up .url files.
# E.g. to run on Desktop of current user:
# cd ~/Desktop && bash delete_steam_shortcuts.sh
# Or without having the script locally:
# cd ~/Desktop && curl -s https://raw.githubusercontent.com/Balfa/shellscripts/main/scripts/delete_steam_shortcuts.sh | bash


# Define the target patterns
STEAM_PATTERN="URL=steam://rungameid/"
EPIC_PATTERN="URL=com.epicgames.launcher://"

# Loop through all .url files in the current directory
for file in *.url; do
  # Make sure it's a regular file before checking content
  if [[ -f "$file" ]]; then
    if grep -q "$STEAM_PATTERN" "$file" || grep -q "$EPIC_PATTERN" "$file"; then
      echo "Deleting: $file"
      rm "$file"
    fi
  fi
done
