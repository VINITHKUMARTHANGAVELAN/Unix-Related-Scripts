#!/bin/sh
#******************************************************************************************************************
#OS Type - HP-UX
#The below script does the following functions:
#Check file system status based on type of OS :
#1.HP-UX
#2.LINUX
#3.SOLARIS 
#Date of Creation: 14th Dec 2016 Vinith Kumar T 
#Modified By : XXXXX (Team Automation-Module X)
#******************************************************************************************************************
#******************************************************************************************************************
#Function Name : func_GetOSInfo
#Description : To find type of OS.
#Input parameters : 
#     No Input parameters.
#Return parameters : 
#     Returns "OS name"
#Date of Creation: 14th Dec 2016 Vinith Kumar T 
#Modified By : XXXXX (Team Automation-Module X)
#******************************************************************************************************************
func_GetOSInfo()
{
typeset -u var_OS 
var_OS=`uname` 
printf "$var_OS"
}
var_FileSystem="$1"
echo "OS Type : $(func_GetOSInfo)"
if [ -n "$var_FileSystem" ];then  #Checks for valid input
case $(func_GetOSInfo) in  
                         "HP-UX") 
                                  a=$(bdf "$var_FileSystem")                          #If OS Type is HP_UX  
                                  if [ -n "$a"  ];then                      #FileSystem found 
                                  printf "File System Found"
                                  bdf "$var_FileSystem"
                                  exit 
                                  else 
                                  echo "File system not found"  #FileSystem not found
                                  mailx -s "$var_FileSystem not found " ml.it.hcl.unixteam@clorox.com   #mail to unix team
                                  fi
                         ;; 
                         "LINUX")                            #If OS Type is LINUX 
                                  if [ `df –h "$var_FileSystem"` ];then            #FileSystem found
                                  printf "File System Found"
                                  df -h "$var_FileSystem"
                                  exit 
                                  else 
                                  echo "File system not found"
                                  mail -s "$var_FileSystem not found " ml.it.hcl.unixteam@clorox.com    #mail to unix team
                                  fi
                          exit 1
                          ;;
                         "SOLARIS") df –k "$var_FileSystem"   #If OS Type is SOLARIS 
                         ;;  
                         "*")echo "Unsupported Operating System...EXITING"   #Invalid OS type 
                         exit 1
;; 
esac
else
    printf "Value Cannot be blank \nGive eg: /var"
    exit 1
fi
