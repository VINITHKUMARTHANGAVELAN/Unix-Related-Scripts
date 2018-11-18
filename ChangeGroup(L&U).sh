#!/bin/sh
#******************************************************************************************************************
#The below script does the following functions:
#1.Change the Group Owner of the file.
#2.Gets file name with path from user.
#3.Checks for its existence.
#4.If True gets Group name and change the group owner.
#5.Else notifies user,file doesnt exist.
#6.Execution : ChangeGroup(L&U).sh "groupname" "directory"
#******************************************************************************************************************
if test "$1" = ""
then
echo "pass parameter while executing:" && exit
elif  grep -q $1 /etc/group       #Checks group exists
then
echo "group exists"
      if test "$2" = ""      #Checks for blank file path
      then
      echo "File/Directory path cannot be blank" && exit
 else
     if [[ -d "$2" ]];then   #If given path is directory 
         echo "$2 is a directory"
         printf "Recursive(Press 1) \nNon-Recursive(Press 2)"    #Asks for recursive or non-recursive permission
         read op
             case "$op" in

             "1")chgrp -R "$1" "$2"
  #cmd execution for recursive permission
                 echo "Recursive permission applied"
                 exit
              ;;
             "2")
                 chgrp "$1" "$2"  #cmd execution for non-recursive permission
                 echo "non-recursive permission applied"
                 exit
              ;;
              *)echo "invalid"
             esac
         elif [[ -e "$2" ]];then        #If given path is file
         echo "$2 is a file"
         chgrp "$1" "$2"
  #cmd execution
         exit
         else
         echo "Path doesnt exist"  #invalid path
         exit
     
fi
fi
fi