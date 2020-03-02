echo In BASHRC
# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-4

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

## Attempt to determine in which subsystem this terminal rub
## (Cygwin, WSL, MSYS, or real linux)
get_term_env()
{
	# Is it Cygwin
	[[ $(echo $EXEPATH) ]] && echo msys && return 0
	[[ $(which cygpath.exe) ]] && echo cygwin && return 0
	[[ $(which wslpath) ]] && echo wsl && return 0
	
	echo linuxBash && return 0
	return 1
}

check_var()
{
	var="$1"
	content=$(eval echo "$""$var")
	
	if [[ "$content" == "" ]];then
		echo -e $RED"$var not defined"$ATTR_RESET
	else
		echo -e $var"=$GREEN"$content$ATTR_RESET
	fi
}


check_var_V1()
{
	echo 0 - 
	echo 1 - "$1"
	echo 2 - $(eval echo "$""$1")
##	echo 3 - $(eval "$""$1")
}


unset ROOTDRIVE
	case $(get_term_env) in
		cygwin)
			echo CYGWIN!!!
			ROOTDRIVE="/cygdrive"
			source $HOME/bin/scripts/.bashrc_cygwin.sh
		;;
		wsl)
			echo WSL!!!
			ROOTDRIVE="/mnt"
			source $HOME/bin/scripts/.bashrc_winbash.sh
		;;
		linuxBash)
			echo Linux Bash!!!
			ROOTDRIVE="/"
			source $HOME/bin/scripts/.bashrc_linuxbash.sh
		;;
		msys)
			echo Msys Bash!!!
			ROOTDRIVE="/"
			source $HOME/bin/scripts/.bashrc_linuxbash.sh
		;;
		*)
			echo "ENV is $(get_term_env)"
		;;
		
	esac
	
case $(hostname) in
	WSTMONDT019)
		echo DIASYS machine
		source ~/bin/scripts/.bashrc_diasys.sh
	;;
	user-HP-ENVY-TS-15-Notebook-PC)
		echo Personal machine
		SCRIPTS_PATH="/home/user/bin/scripts"
		source $HOME/bin/scripts/.bashrc_perso.sh
	;;
	*)
		echo "Unknown machine, or no bash specificities"
	;;
esac

source $SCRIPTS_PATH/.bashrc_standard.sh

GIT=$(which git)
if [[ "$GIT" != "" ]]; then
$SCRIPTS_PATH/git-aliases.sh
fi
source $SCRIPTS_PATH/.bashrc_aliases.sh
source $SCRIPTS_PATH/.bashrc_git.sh
source $SCRIPTS_PATH/.bashrc_custom.sh
source $SCRIPTS_PATH/.bash_tools.sh
source $SCRIPTS_PATH/git-completion.bash
def_font_attributes

export PATH=$PATH:$SCRIPTS_PATH
export PATH=$PATH:$ROOTDRIVE/c/Users/fpaut/bin/Debug
export PATH=$PATH:$BIN_PATH

check_var ROOTDRIVE
check_var HOME
check_var HOMEW
check_var BASH
check_var SCRIPTS_PATH
echo Windows home =$HOMEW

gitconfig_restore

echo Out of BASHRC
export LESSCHARSET=utf-8
