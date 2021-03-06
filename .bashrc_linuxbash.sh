echo
echo -e $YELLOW"In BASHRC_LINUXBASH"$ATTR_RESET

export BASH_STR="Ubuntu bash on Windows"
export HOME_IN_WINDOWS="C:\Users\fpaut\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\fpaut"
export ROOTDRIVE="/mnt"
export HOMEW="$ROOTDRIVE/c/Users/fpaut"

unalias rm 1>/dev/null 2>/dev/null 
alias rm="trash -v"
alias trash-restore="restore-trash"
alias pitivi="CMD=\"flatpak run org.pitivi.Pitivi//stable\" && echo $CMD && $CMD"
alias clean_linux="CMD=\"sudo stracer\"; echo \"$CMD\"; \"$CMD\""

conv_path_for_win()
{
    echo $@
}
export -f conv_path_for_win

conv_path_for_bash()
{
	echo $@
}
export -f conv_path_for_bash

function ctrl_c() {
    echo
}

wedit() {
	local path=$(which $1)
	if [[ "$path" == "" ]]; then
            path="$1"
        fi
	if [ "$?" -eq "0" ]; then
		local path=$(conv_path_for_win $path)
	else
		path=$1
	fi
	CMD="kate $path 2>&1 1>/dev/null"
	CMD+="&"
	exec "$CMD"
}


echo -e $YELLOW"Out of BASHRC_LINUXBASH"$ATTR_RESET
