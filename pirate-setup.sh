#!/bin/bash

exec > >(tee -i PirateBox-Log.txt)
 
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "PirateBox Setup Script"

sleep 3

sudo /opt/piratebox/bin/board-autoconf.sh

sudo /opt/piratebox/bin/timesave.sh /opt/piratebox/conf/piratebox.conf install

sudo systemctl enable timesave

sudo cp /etc/minidlna.conf /etc/minidlna.conf.bkp

sudo cp /opt/piratebox/src/linux.example.minidlna.conf /etc/minidlna.conf

echo -e "Would you like to start and enable "minidlna"?: "
read answer
if [[ $answer == yes ]]; then
    sudo systemctl start minidlna
    sudo systemctl enable minidlna
    
    else exit 1
fi    

