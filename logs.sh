#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/SCRIPTNAME

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "Exist Status :  $2 success "
        exit 1
    else
        echo "Exist Status :  $2 failure "
    fi
}

dnf install mysql -y&>>LOGFILE
VALIDATE $? "mysql install"