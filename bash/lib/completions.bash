#!/bin/sh
# File: "/u02/home_nfs/akushner/etc/init/bash/lib/completions.bash"
# Created: "Wed, 22 Mar 2006 07:42:58 -0800 (akushner)"
# Updated: "Wed, 22 Mar 2006 07:43:02 -0800 (akushner)"
# $Id$
# Copyright (C) 2006, Aaron Kushner <akushner@bitmover.com>

bkcomplete()
{
        BKPROGS='sccstool
        histtool
        fm3tool
	gvim
	vim
        fmtool
        difftool
        citool
	revtool
	pull
        csettool'

        complete -f -W "$BKPROGS" bk
}

case $BASH_VERSION in
        2.05*) bkcomplete;;
        2.04*) bkcomplete;;
        #2.03*) echo "Not available";;
esac

# START bash completion -- do not remove this line
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ] \
   && [ -f /etc/bash_completion ]; then # interactive shell
        # Source completion code
        . /etc/bash_completion
fi
unset bash bmajor bminor
# END bash completion -- do not remove this line
