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
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ......... $R FIALURE $N"
        exit 1
    else
        echo -e "$2 ......... $G SUCCESS $N"
    fi
}

dnf install nginx -y &>>$LOGFILE
VALIDATE $? "nginx installing"

systemctl enable nginx &>>$LOGFILE

systemctl start nginx &>>$LOGFILE

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading content"

cd /usr/share/nginx/html &>>$LOGFILE

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extracting content"

cp /home/ec2-user/daws/expense-project/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "copy conf file"

systemctl restart nginx &>>$LOGFILE

echo -e "nginx started"