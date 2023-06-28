#!/usr/bin/bash
#colorization of Error messages

REDBLOND="\e[31;5;220m"
YelBLOND="\e[38;5;220m"

# Adding all files
git add .
add_output=$? # Adding output for condition
if [ $add_output -ne 0 ]; then
    echo -e "${REDBLOND}asm7 lya rak mchi fel github chof fin kdour
    "
    exit
else
    git add .
fi
#commiting the changes
echo what is your commit name?

read Cname
if [ -z "$Cname" ]; then
    git commit -m "new upload!"
else
    git commit -m "$Cname"
fi

#push the changes

git push
save_output=$? #storing the ouput for the condition
if [ $save_output != 0 ]; then
    echo ach hd lkhra tsna n7lha lik!
elif [ $save_output == 0 ]; then
    clear
else
    git push
fi

#checking the changes

git status 
if [ $? -ne 0 ]; then
    echo Hmmmm? chl3ba machi tal tma ewa hda jhdi elik
else
    echo sfe mzyn db?
fi

#leaving the whole shit

echo clearing after 3s
sleep 3
clear
echo -e ${YelBLOND}Happy coding King/Queen! 
