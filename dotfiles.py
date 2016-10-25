#!/usr/bin/env python3

"""dotfiles.py: *the* dotfiles management utility.

URL: https://github.com/AnotherKamila/dotfiles

Run with --help for usage.
"""

import os
import subprocess
import stat
import sys

import click
import pystache
import yaml

try:
    conf = yaml.load(open('conf.yml'))
except Exception as e:
    click.echo('Cannot load conf.yml: {}'.format(repr(e)))
    sys.exit(1)

### helper functions ###

def template(in_f, params, out_f):
    out_f.write(pystache.render(in_f.read(), params))

def run_generated_script(filename):
    script = os.path.join(conf['out_dir'], filename)
    click.echo(' -- running script: {} --'.format(script))
    subprocess.call(['/bin/sh', script])

def find_files_in(dirpath):
    for dpath, dnames, fnames in os.walk(dirpath):
        for file_path in [os.path.join(dpath, fname) for fname in fnames]:
            yield file_path

### commands ###

@click.group()
def cli():
    pass

@cli.command()
def decrypt():
    """Decrypt sensitive files."""
    os.makedirs(conf['decrypted_dir'], exist_ok=True)
    cmd = 'gpg -d {encrypted_tar} | tar -C {decrypted_dir} -xzm'.format(**conf)
    subprocess.run(cmd, shell=True) # if your conf contains bad stuff, you're doomed anyway :D

@cli.command()
def encrypt():
    """Encrypt sensitive files to prepare for inclusion in a public repo."""
    cmd = 'tar -C {decrypted_dir} -cz . | gpg -c > {encrypted_tar}'.format(**conf)
    subprocess.run(cmd, shell=True) # if your conf contains bad stuff, you're doomed anyway :D

@cli.command()
def verify():
    """Verify that the expected programs exist."""
    run_generated_script(conf['verify_script_filename'])

@cli.command()
def setup_env():
    """Sets up the environment (installs packages, sets shell...)"""
    run_generated_script(conf['setup_env_script_filename'])

@cli.command()
@click.argument('params', type=click.File('r'))
def generate(params):
    """Generate config files from the templates and params."""
    os.makedirs(conf['out_dir'], exist_ok=True)
    params_obj = yaml.load(params)
    params_obj['_DOTFILES_DIR'] = os.path.dirname(os.path.abspath(sys.argv[0]))
    params_obj['_DOTFILES_PARAMS_FILE'] = params.name
    for tpldir in conf['template_dirs']:
        for in_file_path in find_files_in(tpldir):
            base_file_path = os.path.relpath(in_file_path, tpldir)
            out_file_path = os.path.join(conf['out_dir'], base_file_path)
            os.makedirs(os.path.dirname(out_file_path), exist_ok=True)
            with open(in_file_path, 'r') as infile, open(out_file_path, 'w') as outfile:
                template(infile, params_obj, outfile)
                os.chmod(outfile.name, stat.S_IMODE(os.stat(infile.name).st_mode))
                click.echo('.', nl=False)
    click.echo()

@cli.command()
@click.option('--overwrite/--no-overwrite', default=False, help="Overwrite existing config files?")
def install(overwrite):
    """Symlink the generated config files into ~."""
    FROM = conf['out_dir']
    TO   = os.getenv('HOME')
    for src in find_files_in(FROM):
        base = os.path.relpath(src, FROM)
        dest = os.path.join(TO, base)
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        try:
            os.symlink(os.path.abspath(src), dest)
        except FileExistsError:
            if not (overwrite or click.confirm("Overwrite `{}'?".format(dest))):
                continue
            os.remove(dest)
            os.symlink(os.path.abspath(src), dest)
        click.echo(' * {}'.format(base))


@cli.command()
@click.pass_context
@click.argument('params', type=click.File('r'))
@click.option('--sensitive/--no-sensitive', default=False, help='Decrypt and use the sensitive files?')
@click.option('--overwrite/--no-overwrite', default=False, help="Overwrite existing config files?")
def do_everything(ctx, params, sensitive, overwrite):
    """Setup everything."""
    if sensitive: ctx.invoke(decrypt)
    ctx.invoke(generate, params=params)
    ctx.invoke(verify)
    ctx.invoke(setup_env)
    ctx.invoke(install, overwrite=overwrite)

### main ###

if __name__ == '__main__':
    cli.main()
