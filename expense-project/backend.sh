#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log

echo "Please enter DB password:"
read -s mysql_root_password

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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

dnf module disable nodejs -y &>>$ 
VALIDATE $? "disabling nodejs version................."

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "enabling  nodejs version................."

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "installing  nodejs version................."


id expense &>>$LOGFILE

if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else 
    echo -e "expense user added already ..... $Y SKIPPING $N"
fi


mkdir -p /app &>>$LOGFILE
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
cd /app
rm -rf /app/*

unzip /tmp/backend.zip &>>$LOGFILE

npm install &>>$LOGFILE &>>$LOGFILE

cp /home/ec2-user/daws/expense-project/backend.service /etc/systemd/system/backend.service &>>$LOGFILE

systemctl daemon-reload &>>$LOGFILE
systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install mysql in client"


mysql -h db.hkas.cloud -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading."

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"

