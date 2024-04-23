#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"



echo "log file :::: $LOGFILE"


check_root(){
if [ $USERID -ne 0 ]
then echo "Please use root access to install"
  exit 1
else echo "user has access"
fi
}

VALIDATE(){
    if [$1 -ne 0]
    then
        echo -e "$2 ......... $R FIALURE $N"
        exit 1
    else
        echo -e "$2 ......... $G SUCCESS $N"
    fi
}