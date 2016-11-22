#!/bin/sh
# Sets up the environment.
# Make sure to call verify.sh before setting things to non-existent stuff!

set -x

if [ "x$SHELL" != "x{{{SHELL}}}"]; then
	chsh -s {{{SHELL}}}
fi

{{#WITH_I3}}
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.cinnamon.desktop.default-applications.terminal exec {{{TERM}}}
{{/WITH_I3}}
