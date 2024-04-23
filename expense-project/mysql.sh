source ./common.sh

check_root

echo "Please enter DB password:"
# enter abc123 as password
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "My sql server installing"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enableing mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Start mysql server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $LOGFILE

mysql -h db.hkas.cloud -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE

    if [ $? -ne 0 ]
    then
       mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
        exit 1
    else
        echo -e "Mysql root passsword already setup....... SKIPPING $N"
    fi

#netstat -lntp to check server starts or not