#!/bin/bash

# Setup constants
SourceDir="/src/whitelist_update"
ScriptDir="$SourceDir/whitelist/scripts"
WhitelistScript="$ScriptDir/whitelist.py"
ReferralScript="$ScriptDir/referral.sh"
GitRepo="https://github.com/anudeepND/whitelist.git"

#Start
echo "[$(date)] Updating whitelist for pihole"

mkdir -p $SourceDir

if [ -z "$(ls -A /path/to/dir)" ]; then
   echo "[$(date)] Pulling latest whitelist scripts"
   git clone $GitRepo $SourceDir
else
   echo "[$(date)] Updating to latest whitelist scripts"
   git -C $SourceDir pull origin master
fi


echo "[$(date)] Pulled latest whitelist scripts. Updating now"
python3 $WhitelistScript --docker

if [ ! -z $UPDATE_REFERRAL ]; then
	echo "[$(date)] Updating white using referral list"
	/bin/bash $ReferralScript --docker
fi

echo "[$(date)] Updated whitelist for pihole"