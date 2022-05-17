#!/bin/sh
# v0.1 - first version
# v0.2 - replace read command with option to not reboot the system
# Script to download and run the SDRplay RSP API installer
# Then reboot afterwards to make sure the service has started

# clear the terminal
clear
# say what we are doing
echo "SDRplay script to download and run the RSP API Installer - v0.2"
# copy restart script
current_path=`dirname $0`
sudo cp ${current_path}/restartService.sh /usr/local/bin/restartSDRplay
sudo chmod 755 /usr/local/bin/restartSDRplay
# download the API from the SDRplay website
wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run
# change permission so the run file is executable
chmod 755 ./SDRplay_RSP_API-Linux-3.07.1.run
# execute the API installer (follow the prompts)
./SDRplay_RSP_API-Linux-3.07.1.run
# the system should be rebooted before the API is used
# ask the user if they want to reboot now or later
