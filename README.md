This repo contains my dotfiles shared across all computers I use.

How this works
--------------

I share these dotfiles across various and varied machines, some of which have a GUI (like my laptop), some of which are FreeBSD, not Linux (like my server) and such. Therefore all my configuration is parametrized. The parameters for different setups are stored in `params/`, and the dotfile templates are in `templates/`.

The included `dotfiles.py` script can be used to generate actual dotfiles, symlink them from here to their locations in `~`, and verify that the expected programs exist on a system.

Setting this up
---------------

1. check out this repo somewhere like `~/.dotfiles`
2. make a new parameters file in `params/` if needed
3. if wanted: decrypt the bits which you had decided not to put on Github in cleartext:
  `./dotfiles.py decrypt`
4. generate the dotfiles from the templates, this will put them into `generated/`:
  `./dotfiles.py generate params/<something>.yml`
5. verify that the programs mentioned in the params are available:
  `./dotfiles.py verify params/<something>.yml`
6. setup the environment (set shell, install packages...):
  `./dotfiles.py setup`
7. symlink the files here into ~:
  `./dotfiles.py install`

Or just run `dotfiles.py setup_everything` with the appropriate options (see `--help`) to do steps 3-7 all at once.

Once the symlinks are in place, it is of course enough to edit templates and run `dotfiles.py generate`. Also see the `bin/redot.sh` script in my templates.

### When updating:

- edit the templates/params, not the generated files
- use `./dotfiles.py encrypt` to pack & encrypt the sensitive bits
