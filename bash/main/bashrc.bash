#
# bashrc
#

if [ -z "$PS1" ]; then
    return
fi

case "$PS1$XSESSION" in
  '' ) return 0 ;;
esac

if [ -f ~/.debug ];then
    echo "in .bashrc"
fi

if [ -z "$HOST" ] ; then
    export HOST=${HOSTNAME}
fi

export sinit=$HOME/etc/init
export sinit_local=$sinit/local

if [ -f /usr/bin/lsb_release ];then 
    export release=$(lsb_release -r | awk '{print $2}')
fi

# Need to get arround some of Noah's checks
export LOGGED=t

. "$sinit/bash/main/startup.simple.bash"

set-path

export PYTHONSTARTUP=~/.pythonrc

#[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
#tty |egrep "^/dev/ptys/[0-9]*|^/dev/tty[0-9]" >& /dev/null && \
#    export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')


if [ -f ~/.aliases ];then
    . ~/.aliases
fi

if [ -f /etc/bash_completion ];then
    . /etc/bash_completion
fi

# Set some history options
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=5000
export HISTTIMEFORMAT='%a %T '
export LESS='-R -i -e -M -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=pk-KX4A5VTATRPTC6HDZROTBAXUD5MNLQHK.pem
export EC2_CERT=cert-KX4A5VTATRPTC6HDZROTBAXUD5MNLQHK.pem
export JAVA_HOME=/usr/lib/jvm/jdk1.5.0_2
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_21
export PAGER=less

export GOROOT=$HOME/go
export GOOS=linux
export GOARCH=amd64

export VIMRUNTIME=/usr/share/vim/vimcurrent
export VIM=~akushner/etc/init/vim

# Source Facebook definitions
if [ -f /home/engshare/admin/scripts/master.bashrc ]; then
    . /home/engshare/admin/scripts/master.bashrc
fi

case `hostname -d` in
    *facebook.com)
        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        export PERL5LIB="/home/akushner/etc/perl/lib/perl5/site_perl/5.8.8/"
        ;;
    *)
        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        #export PS1='\h:\w\$ '
        ;;
esac

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

### START ssh-agent ###
mkdir -p ~/.ssh/agent-state
SSHPROFILE=~/.ssh/agent-state/${HOSTNAME}
OLDSSHPROFILE=~/.ssh_agent_state_${HOSTNAME}
if [[ -f ${OLDSSHPROFILE} ]] && ! [[ -f ${SSHPROFILE} ]] ; then
  mv ${OLDSSHPROFILE} ${SSHPROFILE}
fi

# Try to attach to a currently running agent
if [[ -e "${SSHPROFILE}" ]] ; then
  . "${SSHPROFILE}" > /dev/null
fi

# Make sure we succeeded
if [ -z "${SSH_AGENT_PID}" ] || ! (ps -p "${SSH_AGENT_PID}" -o ruser,comm | grep -E "^(${USER}|${UID}) " | grep -q " ssh-agent\ *$") ; then
  echo "Starting ssh-agent"
  ssh-agent -s > "$SSHPROFILE"
  . "${SSHPROFILE}" > /dev/null

  echo "Adding ssh keys to ssh-agent"
  ssh-add
fi
### END ssh-agent ###

### START kerberos ###
/usr/kerberos/bin/klist -s
if [[ $? -ne 0 ]]; then
  /usr/kerberos/bin/kinit
fi
### END kerberos ###

# vim:tw=70 ft=sh sw=4
