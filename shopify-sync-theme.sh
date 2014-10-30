#!/bin/bash

# define colors for output strings
red='\e[0;31m'
lred='\e[1;31m'
green='\e[0;32m'
nocolor='\e[0m'
cyan='\e[0;36m'

######################################################
# CONFIGURATION CHECK                                #
######################################################
# specifiy home folder for the shopify theme sync app here -
shopifyThemeSyncFolder="/home/leon/projects/shopify/apps/shopify-theme-sync/"
shopifyThemeSyncCommand="npm start"
shopifyThemeSyncExec="$shopifyThemeSyncFolder$shopifyThemeSyncCommand"
shopifyThemeSyncConfig="config.json"
shopifyThemeSyncDev=".dev"
shopifyThemeSyncLive=".live"
# check if specified folder and config file exists
if [ ! -f $shopifyThemeSyncFolder$shopifyThemeSyncConfig  ]
then
	echo ""
	echo -e "${red}SHOPIFY SYNC THEME ERROR!!"
	echo -e "${lred}Error: Configuration file for shopify-theme-sync not found, "
	echo -e "please check shopify-sync-theme.sh for proper configuration."	
	echo -e "${cyan}please install github.com/davidmurdoch/shopify-theme-sync${nocolor}"
	echo ""
	exit 0
fi
# check if dev config exist
if [ ! -f $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncDev  ]
then
	echo ""
	echo -e "${red}SHOPIFY SYNC THEME ERROR!!"
	echo -e "${lred}Error: DEV Configuration file for shopify-theme-sync not found. "
	echo -e "${cyan}This error has occured because $shopifyThemeSyncFolder${red}$shopifyThemeSyncConfig$shopifyThemeSyncDev${cyan}"
	echo -e "was not found in the shopify-theme-sync application folder, please create it.${nocolor}"
	echo ""
	exit 0
fi
# check if live config exist
if [ ! -f $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncLive ]
then
	echo ""
	echo -e "${red}SHOPIFY SYNC THEME ERROR!!"
	echo -e "${lred}Error: LIVE Configuration file for shopify-theme-sync not found. "
	echo -e "${cyan}This error has occured because $shopifyThemeSyncFolder${red}$shopifyThemeSyncConfig$shopifyThemeSyncLive${cyan}"
	echo -e "was not found in the shopify-theme-sync application folder, please create it.${nocolor}"
	echo ""
	exit 0
fi
	#verbose that our configuration check has passed
	echo -e "${green}Configuration check - PASSED${nocolor}"


######################################################
# ARGUMENT FILTERING                                 #
######################################################
# SYNCTYPE ARGUMENT -
# define acceptable commands list for argument passing
declare -a arySyncComs=("dev" "live" "test")
# declare flgSyncType for later use
flgSyncType=""
# check if variable is passed
# retrieve argument passed by users
syncType=$1
# get length of argument passed
argSize=${#syncType}
# check length of passed argument, if zero length exit
if [ $argSize = 0 ]; then
	echo ""
	echo -e "${red}SHOPIFY SYNC THEME ERROR!!"
	echo -e "${lred}Error: No sync type specified, ${cyan}try --dev, --live or --test${nocolor}"
	echo ""
	exit 0
fi
# check passed arguments to see if commands are validloop through array
for i in "${arySyncComs[@]}"; do #loop through each acceptable variant for synctype argument"
	# check if command passed is within acceptable commands array
	if [ "$syncType" = "--$i" ]; then
		syncType="passed" # set a flag to passed so we can check out of this loop
	fi
done
# check flag to see if argument filtering passed, if it didn't exit script
if [ "$syncType" != "passed" ]; then
	echo ""
	echo -e "${red}SHOPIFY SYNC THEME ERROR!!"
	echo -e "${lred}Error: Invalid value for first argument Sync Type. ${cyan}Try --dev, --live or --test${nocolor}"
	echo ""
	exit 0
fi

	#verbose that our configuration check has passed
	echo -e "${green}Command arguments filter - PASSED${nocolor}"


######################################################
# FILE HANDLING                                      #
######################################################
# Define file handling function
setSyncType() 
{
	# cast our vars into something more friendly
	syncType=$1
	syncOff=""

	# check if live mode was specified
	if [ $syncType = "--live" ]; then
		syncType="live"
		syncOff="dev"
	fi
	# check if dev mode was specified
	if [ $syncType = "--dev" ]; then
		syncType="dev"
		syncOff="live"
	fi
	# check if test mode was specified
	if [ $syncType = "--test" ]; then

		syncType="test"
		syncOff="both"


		# move both possible variants of config file to temp files
		echo "cp $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncLive $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncLive.tmp"
		echo "cp $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncDev $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncDev.tmp"
		# remove the old config file
		echo "rm $shopifyThemeSyncFolder$shopifyThemeSyncConfig"	

		# move variant config file to config file location
		echo "mv $shopifyThemeSyncFolder$shopifyThemeSyncConfig.$syncType $shopifyThemeSyncFolder$shopifyThemeSyncConfig"

		# begin shopify-theme-sync application - https://github.com/davidmurdoch/shopify-theme-sync
		echo $shopifyThemeSyncExec
	
		echo "syncType = $syncType"
		echo "syncOff = $syncOff"

	else

		echo -e "${green}activating $syncType theme sync${nocolor}"

		# move both possible variants of config file to temp files
		cp $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncLive $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncLive.tmp
		cp $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncDev $shopifyThemeSyncFolder$shopifyThemeSyncConfig$shopifyThemeSyncDev.tmp
		# remove the old config file
		rm $shopifyThemeSyncFolder$shopifyThemeSyncConfig	

		# move variant config file to config file location
		cp $shopifyThemeSyncFolder$shopifyThemeSyncConfig.$syncType $shopifyThemeSyncFolder$shopifyThemeSyncConfiga

		cd $shopifyThemeSyncFolder

		echo "npm start"

		# begin shopify-theme-sync application - https://github.com/davidmurdoch/shopify-theme-sync
		#echo "$shopifyThemeSyncExec"
	
		#echo -e "${green}$syncType Activated!${nocolor}"
		

	fi

}
# call file handling function
setSyncType $1


