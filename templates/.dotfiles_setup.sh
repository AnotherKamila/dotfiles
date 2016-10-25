#!/bin/sh
# Sets up the environment.
# Make sure to call verify.sh before setting things to non-existent stuff!

set -x

chsh -s {{SHELL}}

{{#packages_to_install}}
{{package_install_command}} {{.}}
{{/packages_to_install}}
