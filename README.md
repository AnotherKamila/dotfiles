This repo contains my dotfiles shared across all computers I use.

Sharing Setup
-------------

I usually check it out somewhere like `~/.dotfiles`. The included `bootstrap.sh`
script then creates symlinks in `~` for all files/directories here. I also keep
`*.local` files with machine-specific stuff as I find necessary and source them
from the scripts here.
