#!/bin/sh
# Evil magic: parses the active window title, looking for something that looks
# like a path, and opens a terminal in that directory.

# from the first / to the end -- works for both terminal & file manager
DIR="$(xdotool getactivewindow getwindowname | grep -o '/.*$')"
[ -d "$DIR" ] || DIR="$HOME"
{{{REAL_TERM}}} -d "$DIR"
