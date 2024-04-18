#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    echo "Exist Status : $? "
}

dnf install mysql -y
VALIDATE $? "mysql install"