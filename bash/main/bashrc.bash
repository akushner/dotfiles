#
# bashrc
#

#echo "bad idea! ***** bad idea *****"

#export PATH=/opt/git/libexec/git-core:$PATH:$HOME/bin
#export LD_LIBRARY_PATH=/opt/git/lib
#export GIT_EXEC_PATH=/opt/git/libexec/git-core
#export GIT_TEMPLATE_DIR=/opt/git/share/git-core/templates

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

#export PROMPT_COMMAND='history -a'

# http://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
HISTDIR=~/.bash_histdir
[ ! -d $HISTDIR ] && mkdir $HISTDIR


if [ -f ~/.aliases ];then
    . ~/.aliases
fi

if [ -f /etc/bash_completion ];then
    . /etc/bash_completion
fi

# Set some history options
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTFILE=$HISTDIR/history
export HISTIGNORE=ls:cd:df:du:fg
export HISTSIZE=500000
export HISTTIMEFORMAT='%a %T '
export LESS='-R -i -e -M -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

export EC2_HOME=~/.ec2
export EC2_PRIVATE_KEY=pk-KX4A5VTATRPTC6HDZROTBAXUD5MNLQHK.pem
export EC2_CERT=cert-KX4A5VTATRPTC6HDZROTBAXUD5MNLQHK.pem
export PAGER=less

export PYTHONSTARTUP=~/.pythonrc

#if [ -h /usr/share/vim/vimcurrent ]; then
#    export VIMRUNTIME=/usr/share/vim/vimcurrent
#elif [ -f /usr/share/vim/vim72 ]; then
#    export VIMRUNTIME=/usr/share/vim/vim72
#fi

#export VIM=~akushner/etc/init/vim
#export VIM=~/etc/init/vim

# Source Facebook definitions
if [[ $(uname -s) != Darwin ]]; then
  if [ -f /home/engshare/admin/scripts/master.bashrc ]; then
      . /home/engshare/admin/scripts/master.bashrc
  fi
  if [ -f /home/engshare/haskell/setup-env.sh ]; then
      source /home/engshare/haskell/setup-env.sh
  fi
fi

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

if [ -f  /opt/facebook/hg/share/scm-prompt ]; then
    . /opt/facebook/hg/share/scm-prompt
elif [ -f /opt/facebook/share/scm-prompt ]; then
    source /opt/facebook/share/scm-prompt
elif [ -d /usr/local/git/contrib/completion ]; then
    . /usr/local/git/contrib/completion/git-prompt.sh
    . /usr/local/git/contrib/completion/git-completion.bash
elif [ -d  /usr/share/git-core/contrib/completion ];then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -d /opt/facebook/libexec/git-core/contrib/completion ]; then
    . /opt/facebook/libexec/git-core/contrib/completion/git-prompt.sh
elif [ -d /opt/facebook/libexec/git-core/contrib/completion/git-prompt.sh ]; then
    . /opt/facebook/libexec/git-core/contrib/completion/git-prompt.sh
elif [ -f $sinit/bin/scm-prompt ];then
        . $sinit/bin/scm-prompt
fi


# Get prompt time
function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

#PS1='[last: ${timer_show}s][\w]$ '

# Show current git branch or hg bookmark

# set variable identifying the chroot you work in (used in the prompt
# below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export PS1='\u@\h:\W {$(_dotfiles_scm_info [%s])}\$ '

case `hostname -f` in
    *.facebook.com)
        export PS1='\n\[\e[1;37m\]|-- ${debian_chroot:+($debian_chroot)}
        \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;35m\]\w\[\e[0;39m\]\[\e[1;35m\]{$(__git_ps1)}\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        export PERL5LIB="/home/akushner/etc/perl/lib/perl5/site_perl/5.8.8/"
        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(_dotfiles_scm_info " (%s)")\[\e[0;39m\] \[\e[1;37m\] (last: ${timer_show}s) --|\[\e[0;39m\]\n\$ '

        ;;
    *|*mbp*)
#        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(_dotfiles_scm_info " (%s)")\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n\$ '
        #export PS1='\h:\w\$ '
        ;;
esac

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#export GIT_PS1_SHOWDIRTYSTATE=1
#export GIT_PS1_SHOWCOLORHINTS=1
#export GIT_PS1_SHOWUNTRACKEDFILES=1
#export GIT_PS1_SHOWUPSTREAM="verbose name git"

export PATH=$PATH:$GOBIN
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Added 08AUG2012
# https://our.intern.facebook.com/intern/wiki/index.php/DevInternetProxy
if [ 0 = 1 ];then
    export http_proxy='http://172.31.255.99:8080'
    export https_proxy="$http_proxy"
    export no_proxy='*.fb.com,*.facebook.com,*.tfbnw.net'
fi

ldi() {
  lds "(|(uid=$1)(cn=$1))" dn uid cn homeDirectory loginShell
  automountInformation
}


ulimit -s 8192

export VISUAL=vim
export EDITOR=vim


prep_cz() {
  PATH_TO_ITCHEF="/Users/akushner/build/it-chef"
  cd $PATH_TO_ITCHEF/cookbooks
  sudo sed -i '' '/rest_timeout/d' /etc/chef/client.rb
  sudo sed -i '' '/http_retry_count/d' /etc/chef/client.rb
}

cz() {
  prep_cz
  sudo chef-client -z -c /etc/chef/client.rb -j $PATH_TO_ITCHEF/tests/cpe_base_test.json
  rm -rf ../nodes/
}
cz_debug() {
  prep_cz
  sudo chef-client -z -l debug -c /etc/chef/client.rb -j $PATH_TO_ITCHEF/tests/cpe_base_test.json
  rm -rf ../nodes/
}

PATH="/Users/akushner/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/akushner/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/akushner/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/akushner/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/akushner/perl5"; export PERL_MM_OPT;

source $HOME/.cargo/env
export HGPROF=stat

# vim:tw=70 ft=sh sw=4
