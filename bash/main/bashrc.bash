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

if [ -d $HOME/opt/$release/go ];then
    export GOROOT=$HOME/opt/$release/go
elif [ -d $HOME/go ];then
    export GOROOT=$HOME/go
fi

# Need to get arround some of Noah's checks
export LOGGED=t

. "$sinit/bash/main/startup.simple.bash"

set-path

export PYTHONSTARTUP=~/.pythonrc

#[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
#tty |egrep "^/dev/ptys/[0-9]*|^/dev/tty[0-9]" >& /dev/null && \
#    export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')

HISTDIR=~/.bash_histdir
[ ! -d $HISTDIR ] && mkdir $HISTDIR
tty |egrep "^/dev/pts/[0-9]*|^/dev/tty[0-9]" >& /dev/null && {
    h_tty=$(tty | sed -e 's/.*\///')
    export HISTFILE=$HISTDIR/history.$(hostname).${h_tty}
    for i in $HISTDIR/history.$(hostname).*
    do
        cat $i >> $HISTFILE
    done
    history -r
}

if [ -f ~/.aliases ];then
    . ~/.aliases
fi

if [ -f /etc/bash_completion ];then
    . /etc/bash_completion
fi

# Set some history options
shopt -s histappend
<<<<<<< HEAD
export HISTCONTROL=ignoredups:erasedups:ignorespace
=======
export HISTCONTROL=erasedups
export HISTIGNORE=ls:cd:df:du:fg
>>>>>>> bash and vim fixes
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

export PYTHONPATH=$PYTHONPATH:/home/akushner/opt/5.2/lib/python

if [ -h /usr/share/vim/vimcurrent ]; then
    export VIMRUNTIME=/usr/share/vim/vimcurrent
elif [ -f /usr/share/vim/vim72 ]; then
    export VIMRUNTIME=/usr/share/vim/vim72
fi

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

<<<<<<< HEAD
# Try to attach to a currently running agent
#if [[ -e "${SSHPROFILE}" ]] ; then
#  . "${SSHPROFILE}" > /dev/null
#fi
#
## Make sure we succeeded
#if [ -z "${SSH_AGENT_PID}" ] || ! (ps -p "${SSH_AGENT_PID}" -o ruser,comm | grep -E "^(${USER}|${UID}) " | grep -q " ssh-agent\ *$") ; then
#  echo "Starting ssh-agent"
#  ssh-agent -s > "$SSHPROFILE"
#  . "${SSHPROFILE}" > /dev/null
#
#  echo "Adding ssh keys to ssh-agent"
#  ssh-add
#fi
#### END ssh-agent ###

### START kerberos ###
if [ -f /usr/kerberos/bin/klist ]; then
    /usr/kerberos/bin/klist -s
    if [[ $? -ne 0 ]]; then
      /usr/kerberos/bin/kinit
    fi
fi
### END kerberos ###
=======

export GOROOT=$HOME/go
export GOOS=linux
export GOARCH=amd64
export GOBIN=$HOME/bin

export PATH=$PATH:$GOBIN

ulimit -s 8192
export LD_LIBRARY_PATH=/home/akushner/opt/5.2/lib

# Added 08AUG2012
# https://our.intern.facebook.com/intern/wiki/index.php/DevInternetProxy
if [ 0 = 1 ];then
    export http_proxy='http://172.31.255.99:8080'
    export https_proxy="$http_proxy"
    export no_proxy='*.fb.com,*.facebook.com,*.tfbnw.net'
fi

function ldi()
{
  lds "(|(uid=$1)(cn=$1))" dn uid cn homeDirectory loginShell
  automountInformation
}

>>>>>>> bash and vim fixes

# vim:tw=70 ft=sh sw=4
