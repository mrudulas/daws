#!/bin/bash
USERID=$(id -u)

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
        echo -e "/e[33m $i already installed .... SKIPPING"
    else
        echo -e "/e[31m $i need to install"
    fi