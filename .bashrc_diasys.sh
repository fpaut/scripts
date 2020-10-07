echo
echo In BASHRC_DIASYS

DEV_PATH="$ROOTDRIVE/e/dev/"
BIN_PATH="$ROOTDRIVE/e/Tools/bin"
SCRIPTS_PATH="$BIN_PATH/scripts"
FIRMWARE_PATH="$DEV_PATH/STM32_Toolchain/dt-arm-firmware"
TOOLS_PATH="$DEV_PATH/STM32_Toolchain/dt-fwtools"
FSM_CYCLE="$FIRMWARE_PATH/ODS/FSM/Cycles/"


export DISPLAY=localhost:0.0
export LIBGL_ALWAYS_INDIRECT=1



alias cdd="cd $DEV_PATH"
alias cdf="cd $FIRMWARE_PATH"
alias cdfo="cd $FIRMWARE_PATH-other-branch"
alias cdfsm="cdf && cd ODS/FSM/Cycles"
alias cdsch="cdf && cd Scheduling"
alias cdsimul="cdf && cd Combo/Simul/Files"
alias cds="cd $SCRIPTS_PATH"
alias cdt="cd $TOOLS_PATH"
alias cmd="/mnt/c/WINDOWS/system32/cmd.exe /c"
alias jenkins_CLI="java -jar jenkins-cli.jar -auth pautf:QtxS1204+ -s http://FRSOFTWARE02:8080/"



cmlog()
{
	cdlog 
	file=$1
	if [[ "$PATTERN" == "" ]]; 
	then 
		echo "Please, define PATTERN like PATTERN=\"MEAS_CYCLE|PROBE\""
		echo "You can define EXPATTERN to exlude some traces like EXPATTERN=\"\<MISC\>\""
		echo "A filename can be provided as first parameter"
		return
	else 
		# Get last file created in current folder
		set -- $(ls -t *) 
		# Update filename if not provided
		[[ "$file" == "" ]] &&  file=$1
##		rm ./filtered_$file
		if [[ "$EXPATTERN" == "" ]]; 
		then
			CMD="cat $file | egrep \"$PATTERN\" > ./filtered_$file"
		else
			CMD="cat $file | egrep \"$PATTERN\" | egrep -v \"$EXPATTERN\" > ./filtered_$file"
		fi
		echo $CMD && eval $CMD
		CMD="npp ./filtered_$file; "
		echo $CMD && eval $CMD
	fi
	cd -
}

deg_to_step()
{
	deg=$1
	echo $(( $(($((600 * $deg)) / 360)) )) steps
	echo $(( $(($((600 * $deg)) / 360)) * 4)) 1/4 steps
}

cdlog()
{
	year=$(date +%Y)
	month=$(date +%m)
	day=$(date +%d)
	cdf
	cd $(get_combo_log_folder)
}


copy_bin_to_medios_hp()
{
	p1=$@
	ROOT_FOLDER=$(is_git_folder)/..
	export ROOT_FOLDER
	
	if [[ "$p1" == "" ]]; then
		echo "First parameter could contains ledappli, incubator, separator, measmeca, hydro1, hydro2, pmt, vcpF4, vcpGB (non HAL), vcpGB_HAL, vcppmt"
		echo "For many target, use '\"' like"
		echo "${FUNCNAME[0]} \"ledappli incubator separator measmeca hydro1 hydro2\""
		return 1
	fi
		
	
	cd $DEV_PATH/STM32_Toolchain/dt-arm-firmware
	
	if [[ "$(contains ledappli "$p1")" == "1" ]]; then
		echo -e $GREEN"LEDappli for Red Board"$ATTR_RESET
		CMD="cp $ROOT_FOLDER/ODS/LEDappli/build/bin/LEDappli.bin $ROOTDRIVE/m/dev/binFirmware/binF4/"; echo $CMD; $CMD
		CMD="cp $ROOT_FOLDER/ODS/LEDappli/build/bin/LEDappli.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/IA.bin"; echo $CMD; $CMD
	fi
	
	if [[ "$(contains incubator "$p1")" == "1" ]]; then
		echo -e $GREEN"INCUBATOR.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/INCUBATOR.bin $ROOTDRIVE/m/dev/binFirmware/binGB/"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/INCUBATOR.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/INCUB.bin"; echo $CMD; $CMD
		
	fi
	if [[ "$(contains separator "$p1")" == "1" ]]; then
		echo -e $GREEN"SEPAR.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/SEPARATOR.bin $ROOTDRIVE/m/dev/binFirmware/binGB/"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/SEPARATOR.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/SEPAR.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains measmeca "$p1")" == "1" ]]; then
		echo -e $GREEN"MEASMECA.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/MEASMECA.bin $ROOTDRIVE/m/dev/binFirmware/binGB/"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/MEASMECA.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/MEASM.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains hydro1 "$p1")" == "1" ]]; then
		echo -e $GREEN"HYDRO1.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/HYDRO1.bin $ROOTDRIVE/m/dev/binFirmware/binGB/"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/HYDRO1.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/HYDRO1.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains hydro2 "$p1")" == "1" ]]; then
		echo -e $GREEN"HYDRO2.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/HYDRO2.bin $ROOTDRIVE/m/dev/binFirmware/binGB/"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/StepMotor/build/bin/HYDRO2.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/HYDRO2.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains pmt "$p1")" == "1" ]]; then
		echo -e $GREEN"PMT.bin for Generic Board"$ATTR_RESET
		CMD="cp  $ROOT_FOLDER/ODS/PMTboardAppli/bin/PMTboardAppli.bin $ROOTDRIVE/m/dev/binFirmware/binGB/PMT.bin"; echo $CMD; $CMD
		CMD="cp  $ROOT_FOLDER/ODS/PMTboardAppli/bin/PMTboardAppli.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/PMT.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains vcpF4 "$p1")" == "1" ]]; then
		echo -e $GREEN"vcp for Red Board"$ATTR_RESET
		CMD="cp $ROOT_FOLDER/ODS/vcp/build/binred-hal-f4/vcp.bin $ROOTDRIVE/m/dev/binFirmware/binF4/"; echo $CMD; $CMD
	fi
	
	if [[ "$(contains vcpGB "$p1")" == "1" ]]; then
		echo -e $GREEN"vcp for Generic Board"$ATTR_RESET
		CMD="cp $ROOT_FOLDER/ODS/vcp/bin/vcp.bin $ROOTDRIVE/m/dev/binFirmware/binGB/VCPGENERIC.bin"; echo $CMD; $CMD
		CMD="cp $ROOT_FOLDER/ODS/vcp/bin/vcp.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/VCPGENERIC.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains vcpGB_HAL "$p1")" == "1" ]]; then
		echo -e $GREEN"vcp-HAL for Generic Board"$ATTR_RESET
		CMD="cp $ROOT_FOLDER/ODS/vcp/build/bingen-hal-f4/vcp.bin $ROOTDRIVE/m/dev/binFirmware/binGB/VCPGENERIC-HAL.bin"; echo $CMD; $CMD
		CMD="cp $ROOT_FOLDER/ODS/vcp/build/bingen-hal-f4/vcp.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/VCPGENERIC-HAL.bin"; echo $CMD; $CMD
	fi
	if [[ "$(contains vcppmt "$p1")" == "1" ]]; then
		echo -e $GREEN"vcp for PMT Board"$ATTR_RESET
		CMD="cp $ROOT_FOLDER/ODS/vcp/build/binpmt/vcp.bin $ROOTDRIVE/m/dev/binFirmware/binGB/vcppmt.bin"; echo $CMD; $CMD
		CMD="cp $ROOT_FOLDER/ODS/vcp/build/binpmt/vcp.bin $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/0/firmware/VCPPMT.BIN"; echo $CMD; $CMD
	fi
	
	cd -
}

copy_rawIpClient_to_medios_hp()
{
	cd $DEV_PATH/STM32_Toolchain/
	CMD="cp -f dt-fwtools/RuntimeFolderRelease/RawIpClient.exe $ROOTDRIVE/m/dev/rawIpClientScripts/"; echo $CMD; $CMD
	cd - 1>/dev/null
}

copy_rawIpClientScript_to_medios_hp()
{
	cd $DEV_PATH/STM32_Toolchain/
	CMD="rm -rf $ROOTDRIVE/m/dev/rawIpClientScripts/*"; echo $CMD; $CMD
	CMD="cp -rf ./rawIpClientScripts/* $ROOTDRIVE/m/dev/rawIpClientScripts"; echo $CMD; $CMD
	CMD="cp -f dt-fwtools/RuntimeFolderRelease/RawIpClient.exe $ROOTDRIVE/m/dev/rawIpClientScripts/"; echo $CMD; $CMD
	CMD="rm -f $ROOTDRIVE/m/dev/rawIpClientScripts/Update_RawIpClient.ps1"; echo $CMD; $CMD
	cd - 1>/dev/null
}

copy_web_pages_to_medios_hp()
{
	CMD="cp -vr $DEV_PATH/STM32_Toolchain/dt-arm-firmware/Combo/Simul/Files/1/www/* $ROOTDRIVE/m/ComboMaster/emulated-disk/Files/1/www/"
	echo $CMD; $CMD
}

get_company()
{
	echo diasys
}

get_combo_last_log_name()
{
	DIR=($(ls $(get_combo_log_folder ) | grep "\.LOG") )
	nbLog=${#DIR[@]}
	lastArrayIndex=$(echo $(( $nbLog - 1)))
	lastLog=$(echo ${DIR[$lastArrayIndex]})
	echo $lastLog
}

get_combo_last_log_path()
{
	echo $(get_combo_log_folder)/$(get_combo_last_log_name)
}

get_combo_log_folder()
{
	logPath="$FIRMWARE_PATH/Combo/Simul/Files/0/logs/"
	DIR=($(ls $logPath) )
	nbLog=${#DIR[@]}
	lastArrayIndex=$(echo $(( $nbLog - 1)))
	lastDir=$(echo ${DIR[$lastArrayIndex]})
	echo $logPath$lastDir
}

npp() {
## exec /mnt/e/Tools/Notepad++/notepad++.exe "$@"
    CMD="/mnt/e/Tools/Notepad++/notepad++.exe \"$(conv_path_for_win $@)\""
    echo $CMD
	eval "$CMD" 2>/dev/null&
}

get_version()
{
	version=$(cat $FIRMWARE_PATH/ODS/LEDappli/version.c | grep FIRMWARE_VERSION)
	version=${version#*\"}
	version=${version%\"*}
	echo $version
}

step_to_deg()
{
	step=$1
	echo $(( $(($step * 360)) / 600 ))° if steps is 1/1 steps
	echo $(($(($step * 360)) / $((600 * 4)) ))° if steps is 1/4 steps
}

update_repo()
{
	
	MasterBranch="master"
	UpstreamBranch="Fred"
	wip_branch=$1
	if [[ "$wip_branch" == "" ]]; then
		echo "First parameter is the 'Work In Progress' branch name"
		read -e -i 'Y' -p "Using '$GREEN$BRANCH$ATTR_RESET' as 'Work In Progress' branch name? (Y/n): "
		if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
			wip_branch=$BRANCH
		else
			return
		fi
	fi
	
	uncommited=$(git status -s | grep --color=always " M " | grep -v "version")
	if [[ "$uncommited" != "" ]]; then
		echo "Theses files are modified but not commited."
		echo -e "$uncommited"
		read -e -i 'Y' -p "Do you want to commit before? (Y/n): "
		if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
			return 1
		fi
	fi

	SVG_NAME="_WIP_"
	SVG_NAME+="$FUNCNAME"
	SVG_NAME+="_$wip_branch"

	
	CMD="git co $wip_branch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="yes | git_st_rm $SVG_NAME"; echo -e $CYAN$CMD$ATTR_RESET; eval "$CMD"
	CMD="yes n | git_st_save $SVG_NAME"; echo -e $CYAN$CMD$ATTR_RESET; eval "$CMD"
	CMD="git co $MasterBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git pull -X theirs origin/$MasterBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git co $UpstreamBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git rebase --strategy-option theirs $MasterBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git co $wip_branch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git rebase --strategy-option theirs $MasterBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	read -e -i 'C' -p "Restore saved files, or Compare ? (R/C): "
	if [[ "$REPLY" == "R" || "$REPLY" == "R" ]]; then
		CMD="git_st_restore $SVG_NAME"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	else
		CMD="git_st_cmp $SVG_NAME"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	fi
	
	if [[ "$(pwd | grep \"dt-arm-firmware\")" != "" ]]; then
		echo -e $CYAN"TO DO:"$ATTR_RESET
		CMD="make BOARD=STM32P405 SHOW_GCC=0 clean"; echo -e $CYAN$CMD$ATTR_RESET
		CMD="make BOARD=STM32P405 SHOW_GCC=0"; echo -e $CYAN$CMD$ATTR_RESET
		CMD="make BOARD=GENERIC_BOARD_NEW  GB=MEASMECA SHOW_GCC=0 clean"; echo -e $CYAN$CMD$ATTR_RESET
		CMD="make BOARD=GENERIC_BOARD_NEW  GB=MEASMECA SHOW_GCC=0"; echo -e $CYAN$CMD$ATTR_RESET
		echo -e $CYAN$CMD$ATTR_RESET
	fi
}

upstream_repo()
{
	UpstreamBranch="Fred"
	wip_branch=$1
	if [[ "$wip_branch" == "" ]]; then
		echo "First parameter is the 'Work In Progress' branch name"
		read -e -i 'Y' -p "Using '$GREEN$BRANCH$ATTR_RESET' as 'Work In Progress' branch name? (Y/n): "
		if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
			wip_branch=$BRANCH
		else
			return
		fi
	fi
	CMD="git co $wip_branch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git ss"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git co $UpstreamBranch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git pull"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git merge $wip_branch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git push"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git co $wip_branch"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
	CMD="git sp"; echo -e $CYAN$CMD$ATTR_RESET; $CMD
}

wedit() {
	local path=$(which $1 2>/dev/null)
	CMD="npp '$path'"; echo $CMD; eval "$CMD"
}


cd $SCRIPTS_PATH
git config core.fileMode false
FILEMODE=$(cat .git/config | grep -i filemode)
echo -e "my scripts\t: $FILEMODE"
cd - 1>/dev/null
cd $DEV_PATH/STM32_Toolchain/dt-arm-firmware
git config core.fileMode false
FILEMODE=$(cat .git/config | grep -i filemode)
echo -e "dt-arm-firmware\t: $FILEMODE"
cd - 1>/dev/null
cd $DEV_PATH/STM32_Toolchain/dt-fwtools
git config core.fileMode false
FILEMODE=$(cat .git/config | grep -i filemode)
echo -e "dt-fwtools\t: $FILEMODE"
cd - 1>/dev/null

MOUNTED=$(wslpath M:\\ 2>&1 | grep mnt)
if [[ "$MOUNTED" == "" ]]; then
	echo -e "Mounting MEDIOS-HP in /mnt/m"
	CMD="sudo mount -t drvfs M: /mnt/m"
	$CMD
fi

MOUNTED=$(wslpath Z:\\ 2>&1 | grep mnt)
if [[ "$MOUNTED" == "" ]]; then
	echo -e "Mounting /mnt/z = \\manihi\diasystech"
	CMD="sudo mount -t drvfs Z: /mnt/z"
	$CMD
fi

echo Out of BASHRC_DIASYS
