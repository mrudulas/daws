#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    echo "Exist Status : $1  $2 "
}

dnf install mysql -y
VALIDATE $? "mysql install"