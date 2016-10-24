#!/bin/bash

EXCLUDE="README.md .git/ .gitignore `basename $0`"

if [[ $(readlink -f $PWD) != $(readlink -f `dirname $0`) ]] ; then
	echo "This script must be run from the dotfiles dir (`dirname $0`)."
	exit 1
fi

REAL_EXCLUDE="${EXCLUDE// /\|}"

for F in $(find . -type f -printf '%P\n' | grep -v -E "^$REAL_EXCLUDE") ; do
	echo -n "$F"
	SF="`readlink -m $F`" ; TF="$HOME/$F"
	if rm -f "$TF" && mkdir -p "`dirname $TF`" && ln -s "$SF" "$TF"
		then echo ' ✔' ; else echo ' ✘'
	fi
done
