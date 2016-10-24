This repo contains my dotfiles shared across all computers I use.

How this works
--------------

I share these dotfiles across various and varied machines, some of which have a GUI (like my laptop), some of which are FreeBSD, not Linux (like my server) and such. Therefore all my configuration is parametrized. The parameters for different setups are stored in `params/`, and the dotfile templates are in `templates/`.

The included `dotfiles.sh` script can be used to generate actual dotfiles, symlink them from here to their locations in `~`, and verify that the expected programs exist on a system.

Setting this up
---------------

- check out this repo somewhere like `~/.dotfiles`
- if wanted: decrypt the sensitive bits which you had decided not to put on Github in cleartext:
  `./dotfiles.sh decrypt`
- make a new parameters file in `params/` if needed
- verify that the programs mentioned in the params are available:
  `./dotfiles.sh verify params/<something>.yml`
- generate the dotfiles from the templates, this will put them into `generated/`:
  `./dotfiles.sh generate params/<something>.yml`
- symlink the files here into ~:
  `./dotfiles.sh install`

Or just run `dotfiles.sh` after checking it out, as this list of actions is what happens by default.

### When updating:

- edit the templates/params, not the generated files
- use `./dotfiles.sh encrypt` to pack & encrypt the sensitive bits
