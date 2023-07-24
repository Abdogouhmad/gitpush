#!/bin/env bash

#  Copyright (C) 2023 littleblack111 <https://github.com/littleblack111/>

# colors variables
#red="\033[0;31m"
green="\033[0;32m"
red="\033[0;33m"
blue="\033[0;34m"
#cyan="\033[0;36m"
#white="\033[0;37m"
NC="\033[0m"
Maginta="\033[0;35m"
tempdir="/tmp/src.tmp"
installbinpath="$installbinpath"

printf "${green}[*] Checking if system have required packages and commands\n${NC}"
if command -v gh > /dev/null; then
    ghc=true
fi
# since it's dangours, so removed.
#if command -v rsync > /dev/null; then
#    rsyncc=true
#fi
if ! command -v make > /dev/null; then
    printf "${red}[!] ${Maginta}make${red}: command not found\nthis program need to compile with Makefile please install make\n ${NC}"
    exit 127
fi
if ! command -v cc && ! command -v gcc > /dev/null; then
    printf "${red}[!] ${Maginta}c compiler(gcc)${red}: command not found\nthis program need to compile c program, please install gcc compiler\n${NC}"
    exit 127
fi

if [ $ghc != true ]; then
    if ! command -v git > /dev/null; then
        printf "${red}[!] ${Maginta}git${red}: command not found\n${NC}"
        if command -v pacman > /dev/null; then
            printf "${red}[!] ${Maginta}pacman${red}: installing dependencys\n ${NC}"
            sudo pacman -S git --noconfirm
        elif command -v apt-get > /dev/null; then
            printf "${red}[!] ${Maginta}apt-get${red}: installing dependencys\n ${NC}"
            sudo apt-get -y git
        elif command -v yum > /dev/null; then
            printf "${red}[!] ${Maginta}yum${red}: installing dependencys\n ${NC}"
            sudo yum install -y git
        elif command -v zypper > /dev/null; then
            printf "${red}[!] ${Maginta}zypper${red}: installing dependencys\n ${NC}"
            sudo zypper install -y git
        elif command -v emerge > /dev/null; then
            printf "${red}[!] ${Maginta}emerge${red}: installing dependencys\n ${NC}"
            emerge git
        elif command -v nix > /dev/null; then
            printf "${red}[!] ${Maginta}nix${red}: installing dependencys\n ${NC}"
            nix-env -iA nixpkgs.git
        else
            printf "${red}[!] Please install ${Maginta}git${red} with your package manager(git-scm.com/book/en/v2/getting-started-installing-git)\n ${NC}"
            exit 127
        fi
    elif command -v install > /dev/null; then
        installc=true
    elif ! command -v cp > /dev/null; then
        printf "${red}[!] ${Maginta}cp${red}: command not found\n ${NC}"
        exit 127
    elif ! command -v rm > /dev/null; then
        exit 127
    fi
fi

if [ -e $tempdir ]; then
    printf "${red}[!] ${Maginta}$tempdir${red} exist, deleting\n ${NC}"
    rm -rf $tempdir
fi


if [ $ghc = true ]; then
    printf "${green}[*] Cloning div-styl/gitpush.git with gh repo clone into ${Maginta}$tempdir\n ${NC}"
    gh repo clone div-styl/gitpush $tempdir #|| ec=$?; printf "An error had occured during gh repo clone dotfiles\n"; exit $ec
    if [ ! -e /tmp/dots.tmp ]; then
        printf "${red}[!] ${Maginta}src.tmp${red} did not clone Successfully from gh\n ${NC}"
        exit 1
    fi
else
    printf "${green}[*] Cloning div-styl/gitpush.git with git clone into ${Maginta}$tempdir\n ${NC}"
    git clone https://github.com/div-styl/gitpush.git $tempdir #|| ec=$?; printf "An error had occured during git clone\n"; exit $ec
    if [ ! -e $tempdir ]; then
        printf "${red}[!] ${Maginta}src.tmp${red} did not clone Successfully from git\n ${NC}"
        exit 1
    fi
fi

if [ -e $tempdir ]; then
    cd $tempdir
    printf "${green}[*] Building ${Maginta}files${green} with ${Maginta}make${green}... ${NC}"
    make || ec=$?; printf "${red}[!] An error had occured during make\ncheckout in ${Maginta}$tempdir${red}... ${NC}"; cd -; exit $ec
    cd -
elif [ ! -e $tempdir ]; then
    printf "{red}[!] src.tmp directory not found..."
    exit 1
fi

while [ ! $ipath ] || [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; do
    if [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; then
        printf "${yellow}[!] Invalid choice, please select between 1 or 2\n"
    fi
    printf "${blue}[?] Install into 1. ${Maginta}/usr/bin${red} 2. ${Maginta}/usr/local/bin${blue}?(1/2):  ${NC}"
    read ipath;
done

if [ $ipath ]; then
    echo
    if [ $ipath -eq 1 ] || [ $ipath -eq 2 ]; then
        if [ $ipath -eq 1 ]; then
            ipath="/usr/bin"
        elif [ $ipath -eq 2 ]; then
            ipath="/usr/local/bin"
        fi
        if [ $installc ]; then
            printf "${green}[*] Installing ${Maginta}$installbinpath${green} into ${Maginta}$ipath ${green}with \`install\` ${NC}"
            pkexec install $installbinpath $ipath
        elif [ ! $installc ]; then
            printf "${green}[*] Installing ${Maginta}$installbinpath${green} into ${Maginta}$ipath ${green}with \`cp\` ${NC}"
            pkexec cp $installbinpath $ipath
        fi
    fi
fi

printf "${green}[*] Cleaning up... ${NC}"
rm -rf $tempdir || printf "${red}[!] Faild to clean cache, please remove manully"

printf "${green}[!] All done. Exiting...\n ${NC}"
exit 0
