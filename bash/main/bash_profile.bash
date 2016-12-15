### When bash is invoked as an interactive login shell, it looks for 
###
### ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order.
###
### /bin/sh simply looks at ~/.profile
###
### %W%
###

if [ -f ~/.debug ]; then
  echo "in .bash_profile"
fi

# ===========
# Bash-profile
# ===========

umask 022
# rw-r--r-- files
# rwxr-xr-x directories

#
# Startup file for bash login shells.
#

if [ -n "$PS1" ]; then
  PS1='\u@\h(\#)\$ '
  IGNOREEOF=10
fi

[ -z "$HOSTNAME" ] && HOSTNAME=‘uname -n‘
if [ -f .bashrc ]; then
  . .bashrc
fi

#source "$ADMIN_SCRIPTS"/ssh/manage_rootcanal.sh

# vim: set sw=2 ts=2 et:

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# BEGIN: Block added by chef, to set environment strings
# Please see https://fburl.com/AndroidProvisioning if you do not use bash
# or if you would rather this bit of code 'live' somewhere else
. ~/.fbchef/environment
# END: Block added by chef
