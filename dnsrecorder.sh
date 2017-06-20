#!/bin/bash +x
#
#Script to read a text file of domainnames and run them through the dig command outputtingi
# a 'manifest file and a 'domainrecords' file tagged with a an identifier based on epoch time 
#
# @RobThatcher 2017
# 

#Generate a 'run identifier' from epoch time
OS=`uname -s`
case $OS in
                 SunOS)
                        DATE=/usr/bin/date ;;
                 Darwin)
                        DATE=/bin/date ;;
                 Linux)
                        DATE=/bin/date ;;
                 *)  
                        echo -e "\nUnable to determine *nix variant, so we bailed out.\n"
                        exit 1
esac
                EPOCHID=`$DATE +%s`

#Set some variables
NAMEFILE="names.txt"
MF_FILE="$EPOCHID.Manifest.txt"
DR_FILE="$EPOCHID.DomainRecord.txt"

#Send a status message to console and create manifest
echo -e "\nWill check the following Domains on $EPOCHID : \n"
cat $NAMEFILE
cat $NAMEFILE > $MF_FILE 

#Pause for user break
echo -e "\nSleeping for 2 seconds so you can abort with ctrl-c...\n"
sleep 2

#Dig out the DNS records and write them to record file
dig -f names.txt any +noall +nocmd +answer > $DR_FILE

