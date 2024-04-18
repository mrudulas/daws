#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/SCRIPTNAME-TIMESTAMP.log

echo "log file :::: $LOGFILE"
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "Exist Status : \e[31m $2 success "
        exit 1
    else
        echo -e "Exist Status : \e[32m $2 failure "
    fi
}

dnf install mysql -y&>>$LOGFILE
VALIDATE $? "mysql install"