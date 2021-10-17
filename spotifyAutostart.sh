#!/bin/bash

# spotifyAutostart.sh - Turn on/off Spotify Autostart
# Parameters:
# $1 - "on" to turn on Spotify Autostart, "off" to turn it off, or "show" to show the contents of the prefs file.

# Based on https://gist.github.com/jlengrand/ec2fff0f741ae0a59a7f203d9ffee348
# Best practices informed by https://www.javacodegeeks.com/2013/10/shell-scripting-best-practices.html

set -e

usage() {
    echo "Invalid command entered. Please use '${BASH_SOURCE[0]##*/} on' or '${BASH_SOURCE[0]##*/} off'"
    exit 1
}

# $1 : on_off_show - "on" to turn on Spotify Autostart, "off" to turn it off, or "show" to show the contents of the prefs file.
main() {
    if [[ "${#@}" != "1" ]]; then
        usage
    fi
    local -r on_off_show="$1";  shift
    # Mac: spotify_prefsfile_location="$HOME/Library/Application Support/Spotify/prefs"
    local -r spotify_prefsfile_location="$HOME/AppData/Roaming/Spotify/prefs" # Windows (git bash)
    local -r autostart_on=app.autostart-mode=\"normal\"
    local -r autostart_off=app.autostart-mode=\"off\"

    if [[ ! -f "$spotify_prefsfile_location" ]]; then
        echo "Spotify preference file not found. Exiting"
        exit 1
    fi

    if [[ "$on_off_show" = "on" ]]
    then
        echo "Turning on Spotify Windows Autostart"
        sed -i -e "s/$autostart_off/$autostart_on/g" "$spotify_prefsfile_location"
    elif [[ "$on_off_show" = "off" ]]
    then
        echo "Turning off Spotify Windows Autostart"
        sed -i -e "s/$autostart_on/$autostart_off/g" "$spotify_prefsfile_location"
    elif [[ "$on_off_show" = "show" ]]
    then
        cat "$spotify_prefsfile_location"
        exit 1
    else
        usage
    fi
}

main "$@"
