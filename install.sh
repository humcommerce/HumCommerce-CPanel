#!/bin/bash
#Script: install.sh
#PURPOSE: Install HumCommerce plugin into cPanel

INSTALLER="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

# parse arguments

AFFILATE_KEY=""
LOCAL_FILE_PATH=""

# gettings values from command line

while getopts ":a:l" opt; do
	case $opt in
		a)
			AFFILATE_KEY=$OPTARG
			;;
		l)
			LOCAL_FILE_PATH=$OPTARG
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument"
            		exit 1
            		;;
	esac
done

# check for required argument

if [ "$AFFILATE_KEY" == "" ]; then
	echo "ERROR : Missing AFFILATE_KEY"
	exit 1
fi

# checking user is root or not

if [[ $EUID -ne 0 ]]; then
	echo "You must run this script with superuser"
	exit 1
fi

echo "Starting HumCommerce Installation..."

# if not installing from local path we have to download the file

INSTALL_DIR="/usr/local/cpanel"
install -d $INSTALL_DIR/base/frontend/paper_lantern/heatmaps_session_recordings
cd $INSTALL_DIR/base/frontend/paper_lantern/heatmaps_session_recordings

if ["$LOCAL_FILE_PATH" == ""]; then
	DOWNLOAD_URL="https://github.com/humcommerce/HumCommerce-CPanel/raw/master/humcommerce-cpanel.tar.gz"
	wget $DOWNLOAD_URL && tar -xvzf humcommerce-cpanel.tar.gz
else
	echo $LOCAL_FILE_PATH
fi

echo [AFFILATE_KEY] > $INSTALL_DIR/base/frontend/paper_lantern/heatmaps_session_recordings/AffilateID.ini
echo AffilateID = $AFFILATE_KEY >> $INSTALL_DIR/base/frontend/paper_lantern/heatmaps_session_recordings/AffilateID.ini
/usr/local/cpanel/scripts/install_plugin /usr/local/cpanel/base/frontend/paper_lantern/heatmaps_session_recordings/heatmaps_session_recordings.tar.gz

echo "Installation Complete!"
