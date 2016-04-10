#!/bin/bash

#   Script that determines the type of Mac it is and creates
#   the appropriate computer name using the following naming scheme:
#   PREFIX-MACTYPE-????? (Last 5 of MAC or Serial Number)
#   Tim Barth - April 10, 2016

# ********** User variables ********** #

##### Computer name prefix
  compPrefix="TBRTH"

# ********** End of user variables ********** #


##### Last 5 of MAC Address
macAddress=`ifconfig en0 | grep ether | awk '{print toupper ($2)}' | sed s'/://g' | tail -c 6`

##### Last 5 of Serial Number
serialNumber=`system_profiler SPHardwareDataType | grep "Serial Number (system): " | awk '{print $4}' | tail -c 6`

#### Get product family of Mac: MacBook, MacBook Air, MacBook Pro, iMac, Mac Pro

productFamily=`system_profiler SPHardwareDataType | grep "Model Name: " | awk '{print $3 " " $4}'`

case $productFamily in
  "MacBook Pro" ) macType="MBP"
    ;;
  "MacBook Air" ) macType="MBA"
    ;;
  "MacBook" ) macType="MB"
    ;;
  "iMac" ) macType="IMAC"
    ;;
  "Mac Pro" ) macType="MP"
    ;;
  "Mac mini" ) macType="MINI"
    ;;
esac

##### Computer Naming Scheme: PREFIX-MACTYPE-##### (Last 5 Digits of MAC Address)
macComputerName="$compPrefix-$macType-$macAddress"
serialComputerName="$compPrefix-$macType-$serialNumber"


##### Print out last 5 of MAC address and Serial Number of computer
echo " "
echo "Last 5 of MAC Address: $macAddress"
echo "Last 5 of Serial Number: $serialNumber"
echo " "

##### Print out each version of the computer name
echo " "
echo MAC Address Computer Name: $macComputerName
echo Serial Number Computer Name: $serialComputerName
echo " "

#### Prompt to make changes to LocalHostName, ComputerName, and HostName
echo "Which computer name would you like to apply?"
select input in "$macComputerName (Last 5 of MAC Address)" "$serialComputerName (Last 5 of Serial Number)" "Do not apply any changes";
do
  case $input in
    "$macComputerName (Last 5 of MAC Address)" )
        ##### Set LocalHostName, ComputerName, and HostName via scutil

        #scutil --set LocalHostName "$macComputerName"
        echo "Set LocalHostName: $macComputerName"
        echo " "

        #scutil --set ComputerName "$macComputerName"
        echo "Set ComputerName: $macComputerName"
        echo " "

        #scutil --set HostName "$macComputerName.local"
        echo "Set HostName: $macComputerName.local"
        echo " "
        break;;

    "$serialComputerName (Last 5 of Serial Number)" )
        ##### Set LocalHostName, ComputerName, and HostName via scutil

        # (DISABLED) scutil --set LocalHostName "$macComputerName"
        echo "Set LocalHostName: $serialComputerName"
        echo " "

        # (DISABLE) scutil --set ComputerName "$macComputerName"
        echo "Set ComputerName: $serialComputerName"
        echo " "

        # (DISABLED) scutil --set HostName "$macComputerName.local"
        echo "Set HostName: $serialComputerName.local"
        echo " "
        break;;

    "Do not apply any changes" ) echo "Exiting... Computer name has not been changed."
        break;;
  esac
done

##### EOF
