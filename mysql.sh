#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%f-%h-%m-%s)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
Y="/e[33m"
R="/e[31m"
B="/e[32m"
N="/e[0m"

echo "log file :::: $LOGFILE"


if [ $USERID -ne 0 ]
then echo "Please use root access to install"
  exit 1
else echo "user has access"
fi

VALIDATE(){
    echo "Exist Status : $1  $2 "
}


#&>>$LOGFILE  for both success and failure
#1>>$LOGFILE  for success
#2>>$LOGFILE  for failure
dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "My sql server installing"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enableing mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start mysql server"

#netstat -lntp to check server starts or not