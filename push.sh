#!/usr/bin/bash
#colorization of Error messages

REDBLOND="\e[31;5;220m"
YelBLOND="\e[38;5;220m"
GREEN='\e[38;5;186m'
NC='\033[0m' # No Color

# Adding all files
#customed files
echo -e ${YelBLOND}Hello KING/QUEEN, let me show your directory first and tell me what to add!
echo -e ${NC}
ls -la
#condition goes here

echo -e do you wanna add specific file [y/n]? #specail msg for specail codition/situation
read yes
while [ $yes == 'y' ]
        do
            echo -e ${REDBLOND}here are the changes you made:
            git status --short
            echo -e ${GREEN}add the file name or exit to add everything:
            read filename #the file name observed at the beginning!
        if [ $filename == 'exit' ]
            then
                exit
        elif [ $filename != 'exit' ]; then
            git add $filename
            echo give the commit name:
            read cmt
            git commit -m "$cmt"
            git push
        fi
            clear
            echo -e ${YelBLOND}Happy coding KING/QUEEN!
            exit
done

# second choice code
git add .
add_output=$? # Adding output for condition
if [ $add_output -ne 0 ]; then
    echo -e "${REDBLOND}You are not in github repo so of course you going to see this msg"
    exit
else
    git add .
fi
#commiting the changes
echo what is your commit name?
read Cname #git the commit name for user
if [ -z "$Cname" ]; then
    git commit -m "new upload!"
else
    git commit -m "$Cname"
fi

#push the changes

git push
save_output=$? #storing the ouput for the condition
if [ $save_output != 0 ]; then
    echo ${REDBLOND}there is issue with push i will push again hold!
    git push
elif [ $save_output == 0 ]; then
    clear
else
    git push
fi

#checking the changes

git status
if [ $? -ne 0 ]; then
    echo ${REDBLOND}Hmmmm? something odd here try to figure it out!
else
    echo OOOH it works
fi

#leaving the whole shit

echo clearing after 3s
sleep 3
clear
echo -e ${YelBLOND}Happy coding King/Queen!
