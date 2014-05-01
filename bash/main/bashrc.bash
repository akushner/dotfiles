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
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE=ls:cd:df:du:fg
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

<<<<<<< HEAD
case `hostname -d` in
=======

if [ -f /usr/facebook/scripts/db/dba_lib.sh ]; then
    . /usr/facebook/scripts/db/dba_lib.sh
fi


# set variable identifying the chroot you work in (used in the prompt
# below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

if [ -f /mnt/vol/engshare/admin/scripts/scm-prompt ]; then
        . /mnt/vol/engshare/admin/scripts/scm-prompt
elif [ -f $sinit/bin/scm-prompt ];then
        . $sinit/bin/scm-prompt
fi

# Show current git branch or hg bookmark
export PS1='\u@\h:\W {$(_dotfiles_scm_info)}\$ '

case `hostname -f` in
>>>>>>> Updates for macosx at fb
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
