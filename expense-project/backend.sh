#!/bin/bash

source ./common.sh

check_root
echo "Please enter DB password:"
read -s mysql_root_password



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
VALIDATE $? "daemon reloadt"
systemctl start backend &>>$LOGFILE
VALIDATE $? "start backend"
systemctl enable backend &>>$LOGFILE
VALIDATE $? "enale backend"


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install mysql in client"


mysql -h db.hkas.cloud -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading."

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"

