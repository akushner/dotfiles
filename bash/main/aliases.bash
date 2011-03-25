# Changed these after doing the rh7.1 install
#alias vncstart='/usr/local/bin/vncserver -geometry 1280x1024 -depth 24'
#alias vncstop='/usr/local/bin/vncserver -kill vermin:1'
alias vncstart='vncserver -geometry 1280x1024 -depth 24'
alias vncstop='vncserver -kill vermin:1'
alias fetch='fetchmail -N -v'
alias pine='pkill -9 pine; pine'

alias bf='cd ~/work/bugfixes_2.0/src'
alias br='cd ~/work/bk.repotool/src'
alias bs='cd ~/work/bk.sfiles_norecurse/src'
alias oo='exit'
alias xdaliclock=' xdaliclock -transparent -oink-oink -noseconds -builtin0 -borderwidth 0'
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

alias bbin='cd /home/akushner/work/Deploy/cash/build/bin'
alias setroot='xloadimage -onroot  etc/bg.gif'

alias sf-cqa-app01="ssh -t -x -C slot \"ssh sf-cqa-app01\""
alias sf-cqa-app02="ssh -t -x -C slot \"ssh sf-cqa-app01\""
alias sf-cqa-web01="ssh -t -x -C slot \"ssh sf-cqa-web01\""
alias sf-cqa-web02="ssh -t -x -C slot \"ssh sf-cqa-web01\""
alias sf-cdev-web01="ssh -t -x -C slot \"ssh sf-cdev-web01\""
alias s="ssh -i ~/.ssh/wagerworks_dsa -t -x -C slot \"ssh $1\""
alias gk="nohup gkrellm -g +1208+470 &"

alias rpms="cd /u01/kickstart/RedHat/RPMS"

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
