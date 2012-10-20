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

if [ -f .bashrc ]; then
	. .bashrc
fi

ssh-add -l >/dev/null

if [ $? == 2 ]; then
  set -x
  # No agent was forwarded, set one up.
  hostname=$(/bin/hostname)
  ssh_env="$HOME/.ssh/ssh-agent-env-$hostname"
  pgrep -u $USER ssh-agent >/dev/null && {
    echo "SSH: Finding existing agent";
    . $ssh_env; }
  pgrep -u $USER ssh-agent >/dev/null || {
    echo "SSH: Starting new agent";
    ssh-agent > $ssh_env;
    . $ssh_env;
    chmod 600 $ssh_env; }
  set +x
fi

### START kerberos ###
if [ -f /usr/kerberos/bin/klist ]; then
    /usr/kerberos/bin/klist -s
    if [[ $? -ne 0 ]]; then
      /usr/kerberos/bin/kinit
    fi
fi

### END kerberos ###

# vim: set sw=2 ts=2 et:
