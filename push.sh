#!/usr/bin/bash
#coloring
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No
#end coloring

#PRINTING WITH COLORS

print_color(){
  local color=$1
  local text=$2
  local NOC=$NC
  printf "$color""$text""$NOC"
}
# end func
git status --short
#condition goes here

print_color "$YELLOW" "[?] Do you wanna add special file [y/n]: "
read -r -n1 yes  #specail msg for specail codition/situation
echo
while [ "$yes" == 'y' ]
        do
            print_color "$RED" "[!]here are the changes you made: \n"
            git status --short
            print_color "$GREEN""[*]add the file name or exit to add everything: \n"
            read -r filename #the file name observed at the beginning!
        if [ "$filename" == 'exit' ]
            then
                exit
        elif [ "$filename" != 'exit' ]; then
            git add "$filename"
            print_color "$PURPLE" "[?]give the commit name: \n"
            read -r cmt
            git commit -m "$cmt"
            git push
        fi
            clear
            print_color "$CYAN" "[<3]Happy coding KING\n"
            exit
done

# second choice code
git add .
add_output=$? # Adding output for condition
if [ $add_output -ne 0 ]; then
    print_color "$RED" "[!]repo not detected use git init to create a repo \n"
    exit 1
else
    git add .
fi
#commiting the changes
print_color "$CYAN" "[?]what is your commit name in case you gave empty input your cmit is: new upload: \n"
read -r -e  Cname #git the commit name for user
if [ -z "$Cname" ]; then
    git commit -m "new upload!"
else
    git commit -m "$Cname"
fi

#push the changes

git push
save_output=$? #storing the ouput for the condition
if [ $save_output != 0 ]; then
    print_color "$RED""[!]there is issue with push i will push again hold!\n"
    git push
elif [ $save_output == 0 ]; then
    clear
else
    git push
fi

#checking the changes

git status
if [ "$?" -ne 0 ] ; then
     print_color "$RED""[!]Hmmmm? something odd here try to figure it out!\n"
    exit 1
else
  print_color "$CYAN" "pushed successfully \n"
fi

#leaving the whole shit

echo clearing after 3s
sleep 3
clear
print_color "$BLUE" "Happy coding KING\n"
