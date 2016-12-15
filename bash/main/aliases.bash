# aliases.bash --- define standard aliases
# Author: Noah Friedman <friedman@splode.com>
# Created: 1992-01-15
# Public domain

# $Id: aliases.bash,v 1.6 2004/02/14 21:28:31 friedman Exp $

# Commentary:
# Code:

alias am='tmux attach -d -t mobile'
alias afb='tmux attach -d -t fb'
alias ldm='sudo /usr/facebook/ops/scripts/auth/ldap/fb_ldap_mgr.pl'
alias lds='ldapsearch -x -b dc=thefacebook,dc=com'
alias ldsa='ldapsearch -x -b dc=thefacebook,dc=com -W -D uid=phild,ou=People,dc=thefacebook,dc=com'
alias ops='cd ~/opsfiles'
alias chef='cd ~/opsfiles/chef'
alias gh='cd /data/users/akushner/opsfiles-hg/chef/cookbooks/other/fb_git/files/default/githooks/hooks/'
alias mh='cd /data/users/akushner/opsfiles-hg/chef/cookbooks/other/fb_mercurial/files/default/scripts/hooks'
alias svnh='cd /data/users/akushner/opsfiles-hg/chef/cookbooks/other/fb_svn/files/default/hooks'

alias tbgs='tbgs --stripdir'
alias p='/usr/local/bin/python2.7'
alias fixntp='sudo /etc/init.d/ntp stop ; sleep 2; sudo ntpdate ntp.ubuntu.com'
alias cont='kill -CONT'
alias stop='kill -STOP'
alias ZZ='suspend'

alias j='jobs -l'
alias rehash='hash -r'
alias unexport='export -n'


if [[ $SINIT_MACHTYPE != x86-apple-darwin* ]];then
    alias ls='ls --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias l='ls -CF'
    alias la='ls -A'
    alias ll='ls -alF'
fi


alias fight='mpg123-alsa ~akushner/mp3/punk/One-inch-punch_fight.mp3'

alias p=python
alias porn='cd /u02/video/torrent_porn'
alias ec='cd ~akushner/projects/work/EC'
alias sd='ssh dev1903.prn2.facebook.com'

alias cal='cal -3' #show 3 months by default
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'

alias xc='xclock -analog -update 1 -geometry 400x400'
alias xclock='xclock -geometry 700x700+200+100 -update 1'
alias telco='whois -h whois.telcodata.us'
alias vncstart='vncserver -geometry 1280x1024 -depth 24'
alias vncstop='vncserver -kill vermin:1'
alias fetch='fetchmail -N -v'
alias pine='pkill -9 pine; pine'
alias timet="perl -e 'print scalar(localtime(\$ARGV[0])),\"\\n\"'";

alias www='cd ~/www'

alias oo='exit'

alias xdaliclock=' xdaliclock -transparent -oink-oink -seconds -builtin0 -borderwidth 0'
alias xcutsel='xcutsel -selection vnc'
alias xe1='xearth -stars -bigstars 20 -gamma 2.6 -day 100 -grid -pos "fixed 0 -122.08" -proj merc &'
alias xe2='xearth -stars -bigstars 20 -gamma 2.6 -day 100 -grid -pos "fixed 37 -122.08" -proj merc &'

alias ll='ls -l'
alias dir='ls -ba'
alias ss="ps -aux"
alias dot='ls .[a-zA-Z0-9_]*'
alias news="xterm -g 80x45 -e trn -e -S1 -N &"

alias c="clear"
alias m="more"
alias j="jobs"
alias more=less
alias mroe=more
alias vi=vim
alias iv=vi
alias bkbuild='make clean; make build; ./build p'

# common misspellings
alias mroe=more
alias pdw=pwd
alias xe3='xearth -stars -bigstars 20 -gamma 2.6 -day 100 -grid -pos "fixed 37 -122.08" &'

alias fixbg='xloadimage -onroot ~/Personal/bg.gif'
alias setroot='xloadimage -onroot  etc/bg.gif'

alias sf-cqa-app01="ssh -t -x -C slot \"ssh sf-cqa-app01\""
#alias s="ssh -i ~/.ssh/wagerworks_dsa -t -x -C slot \"ssh $1\""
alias s="ssh -t -x dev2069.snc6.facebook.com \"ssh $1\""
alias gk="nohup gkrellm -g +1208+470 &"

backup() {
	echo Backing up $HOSTNAME
	if [ $HOSTNAME != "io.suzannekushner.com" ];then
		echo "Only do this on IO"
		return
	fi
	(
	backup=0
	valid=0
	while [ $valid -eq 0 ]; do
	 echo -n "Are you sure you want to do this (Y/N)? "
	 read Y_OR_N
	 if [ -z $Y_OR_N ]; then
	   valid=0
	 elif [ "$Y_OR_N" = "y" ] || [ "$Y_OR_N" = "Y" ] ; then
	   backup=1
	   valid=1
	 elif [ "$Y_OR_N" = "n" ] || [ "$Y_OR_N" = "N" ] ; then
	   backup=0
	   valid=1
	 fi
	done
	echo "v=($backup)"
	if [ $backup -eq 0 ];then
		exit
	fi
	cd /u02/home_nfs/
	rsync -e ssh -uavx -P akushner vermin:/u01/backups/home
	echo `pwd`
	)
}

pw() {
	getent passwd | grep -i $1
}

#source_local_bash_init_file aliases

# aliases.bash ends here
