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

# keychain id_rsa id_dsa
#[ -z "$HOSTNAME" ] && HOSTNAME=‘uname -n‘
#[ -f $HOME/.keychain/$HOSTNAME-sh ] &&
#. $HOME/.keychain/$HOSTNAME-sh
#[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] &&
#. $HOME/.keychain/$HOSTNAME-sh-gpg
#
if [ -f .bashrc ]; then
  . .bashrc
fi

#source "$ADMIN_SCRIPTS"/ssh/manage_rootcanal.sh

# vim: set sw=2 ts=2 et:
