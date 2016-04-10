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
echo -e "\nLast 5 of MAC Address: $macAddress"
echo -e "Last 5 of Serial Number: $serialNumber"

##### Print out each version of the computer name
echo -e "\nComputer Name (MAC Address): $macComputerName"
echo -e "Computer Name (Serial Number): $serialComputerName"

#### Prompt to make changes to LocalHostName, ComputerName, and HostName
echo -e "\nWhich computer name would you like to apply?"
select input in "$macComputerName (Last 5 of MAC Address)" "$serialComputerName (Last 5 of Serial Number)" "Manually enter computer name" "Quit";
do
  case $input in
    "$macComputerName (Last 5 of MAC Address)" )
        ##### Set LocalHostName, ComputerName, and HostName via scutil

        echo -e "\nSetting LocalHostName: $macComputerName"
        # (DISABLED) scutil --set LocalHostName "$macComputerName"
        echo -e "Done...\n"

        echo -e "Setting ComputerName: $macComputerName"
        # (DISABLED) scutil --set ComputerName "$macComputerName"
        echo -e "Done...\n"

        echo -e "Setting HostName: $macComputerName.local"
        # (DISABLED) scutil --set HostName "$macComputerName.local"
        echo -e "Done...\n"

        break;;

    "$serialComputerName (Last 5 of Serial Number)" )
        ##### Set LocalHostName, ComputerName, and HostName via scutil

        echo -e "\nSet LocalHostName: $serialComputerName"
        # (DISABLED) scutil --set LocalHostName "$macComputerName"
        echo -e "Done...\n"

        echo -e "Set ComputerName: $serialComputerName"
        # (DISABLE) scutil --set ComputerName "$macComputerName"
        echo -e "Done...\n"

        echo -e "Set HostName: $serialComputerName.local"
        # (DISABLED) scutil --set HostName "$macComputerName.local"
        echo -e "Done...\n"

        break;;

    "Manually enter in computer name" )
        ##### Prompt user to enter in computer name
        read -p "ComputerName: " customComputerName

        echo -e "\nSetting LocalHostName: $customComputerName"
        # (DISABLED) scutil --set LocalHostName "$customComputerName"
        echo -e "Done...\n"

        echo -e "Setting ComputerName: $customComputerName"
        # (DISABLE) scutil --set ComputerName "$customComputerName"
        echo -e "Done...\n"

        echo -e "Setting HostName: $customComputerName.local"
        # (DISABLED) scutil --set HostName "$customComputerName.local"
        echo -e "Done...\n"

        break;;

    "Quit" ) echo -e "\nExiting... No changes have been changed.\n"
        break;;
  esac
done

##### End of script
