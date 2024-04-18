#!/bin/bash
USERID=$(id -u)
Y="/e[33m"
R="/e[31m"
B="/e[32m"
if [ $USERID -ne 0 ]
then echo "Please use root access to install"
  exit 1
else echo "user has access"
fi

for i in $@
do  
    echo "package to install ::: $i"
    dnf list instlled $i>>$LOGFILE
    if [ $? -eq 0 ]
    then
        echo -e "Y $i already installed .... SKIPPING"
    else
        echo -e "B $i need to install ... INSTALLING"
    fi
done