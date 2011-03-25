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

if [ -f /unix ] ; then	
	alias ls='/bin/ls -CF'
else
	alias ls='/bin/ls -F --color=tty'
fi

if [ -z "$HOST" ] ; then
	export HOST=${HOSTNAME}
fi

export sinit=$HOME/etc/init
export sinit_local=$sinit/local


. "$sinit/bash/main/startup.simple.bash"

export CVSROOT=:pserver:akushner@cvsserver:/usr/local/cvsroot

export PYTHONSTARTUP=~/.pythonrc

#[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
#tty |egrep "^/dev/ptys/[0-9]*|^/dev/tty[0-9]" >& /dev/null && \
#    export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')


if [ -f ~/.aliases ];then
	. ~/.aliases
fi

# This sillyness is to get around the liblow bug in gpm
# where it fails on the following:
# if ((term=(char *)getenv("TERM")) && !strncmp(term,"xterm",5)) {
#
if [ x$TERM = "xEterm" ]
then    TERM=xtermc
        export TERM
fi

export LC_ALL=C

export PATH=$PATH:/opt/electriccloud/electriccommander/bin:/opt/ecloud/i686_Linux/bin
export PATH=$PATH:/usr/local/tools/i686_Linux/bin

# Set some history options
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTSIZE=5000
export HISTTIMEFORMAT='%a %T '
export LESS='-i -e -M -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
#export ARCH=i686_Linux

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

export PATH=$PATH:/usr/local/cuda/bin
export PATH=$PATH:/u01/akushner/build/depot_tools

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib

# vim:tw=70 ft=sh sw=4
