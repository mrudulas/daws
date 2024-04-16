echo "All variables from command line argumants ::: $@"
echo "Number of variables from command line argumants ::: $#"

echo "Current script file name  ::: $0"

echo "Current working directory ::: $PWD"
echo "Home directory of current user: $HOME"


echo "CUrrent loggedin user ::: $USER"

echo "Current process id ::: $$"

echo "Previous process id ::: $!"

echo "Hostname ::: $HOSTNAME"


# above are called enviornment varibles  

# PATH  

# $? is Exit status for the last command , 0 is success, failure otherwise

# [] test expression  || && ! logical and or and not

# ( ) for array declaration persons=(1,2,3)  print whole array ${persons[@]}  length ${#persons[@]}

# echo "Home directory of current user: $HOME"
# echo "Which user is running this script: $USER"
# echo "Hostname: $HOSTNAME"
# echo "Process ID of the current shell script: $$"
# sleep 60 &
# echo "Process ID of last background command: $!"