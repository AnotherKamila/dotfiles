#!/bin/sh
# Sets up the environment.
# Make sure to call verify.sh before setting things to non-existent stuff!

set -x

chsh -s {{SHELL}}

{{#WITH_I3}}
gsettings set org.nemo.desktop show-desktop-icons false
gsettings set org.cinnamon.desktop.default-applications.terminal exec {{TERM}}
{{/WITH_I3}}

{{#packages_to_install}}
{{package_install_command}} {{.}}
{{/packages_to_install}}
