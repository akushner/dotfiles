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


. "$sinit/bash/main/startup.simple.bash"

export PYTHONSTARTUP=~/.pythonrc

#[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
#tty |egrep "^/dev/ptys/[0-9]*|^/dev/tty[0-9]" >& /dev/null && \
#    export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')


if [ -f ~/.aliases ];then
	. ~/.aliases
fi

export LC_ALL=C

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
export PAGER=less

export GOROOT=$HOME/go
export GOOS=linux
export GOARCH=amd64
#export GOBIN=

export VIMRUNTIME=/usr/share/vim/vim72
export VIM=/u01/akushner/etc/init/vim

# Source Facebook definitions
if [ -f /home/engshare/admin/scripts/master.bashrc ]; then
	. /home/engshare/admin/scripts/master.bashrc
fi


case `hostname -d` in
    *.facebook.com)
        echo "in facebook"
        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        ;;
    *)
        echo "not in facebook"
        ;;
esac

# vim:tw=70 ft=sh sw=4
