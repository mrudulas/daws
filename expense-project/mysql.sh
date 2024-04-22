#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "Please enter DB password:"
# enter abc123 as password
read -s mysql_root_password

echo "log file :::: $LOGFILE"


if [ $USERID -ne 0 ]
then echo "Please use root access to install"
  exit 1
else echo "user has access"
fi

VALIDATE(){
    if [$1 -ne 0]
    then
        echo -e "$2 ......... $R FIALURE $N"
        exit 1
    else
        echo -e "$2 ......... $G SUCCESS $N"
    fi
}

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "My sql server installing"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enableing mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $LOGFILE

mysql -h db.hkas.cloud -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE

    if [ $1 -ne 0 ]
    then
       mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
        exit 1
    else
        echo -e "Mysql root passsword already setup....... SKIPPING $N"
    fi

#netstat -lntp to check server starts or not