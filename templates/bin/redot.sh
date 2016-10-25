#!/bin/sh
# Regenerates the previously-installed dotfiles.

cd {{_DOTFILES_DIR}}
[ -f venv/bin/activate ] && . venv/bin/activate
./dotfiles.py generate {{_DOTFILES_PARAMS_FILE}}
./dotfiles.py install --overwrite
