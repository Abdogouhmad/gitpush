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

printf "${green}[*] Checking if system have required packages and commands\n${NC}"
if command -v gh > /dev/null; then
    ghc=true
fi
# since it's dangours, so removed.
#if command -v rsync > /dev/null; then
#    rsyncc=true
#fi
if ! command -v make > /dev/null; then
    printf "${red}[!] ${Maginta}make${yellow}: command not found\nthis program need to compile with Makefile please install make\n ${NC}"
    exit 127
fi
if ! command -v cc && ! command -v gcc > /dev/null; then
    printf "${red}[!] ${Maginta}c compiler(gcc)${yellow}: command not found\nthis program need to compile c program, please install gcc compiler\n${NC}"
    exit 127
fi

if [ $ghc != true ]; then
    if ! command -v git > /dev/null; then
        printf "${red}[!] ${Maginta}git${yellow}: command not found\n${NC}"
        if command -v pacman > /dev/null; then
            printf "${red}[!] ${Maginta}pacman${yellow}: installing dependencys\n ${NC}"
            sudo pacman -S git --noconfirm
        elif command -v apt-get > /dev/null; then
            printf "${red}[!] ${Maginta}apt-get${yellow}: installing dependencys\n ${NC}"
            sudo apt-get -y git
        elif command -v yum > /dev/null; then
            printf "${red}[!] ${Maginta}yum${yellow}: installing dependencys\n ${NC}"
            sudo yum install -y git
        elif command -v zypper > /dev/null; then
            printf "${red}[!] ${Maginta}zypper${yellow}: installing dependencys\n ${NC}"
            sudo zypper install -y git
        elif command -v emerge > /dev/null; then
            printf "${red}[!] ${Maginta}emerge${yellow}: installing dependencys\n ${NC}"
            emerge git
        elif command -v nix > /dev/null; then
            printf "${red}[!] ${Maginta}nix${yellow}: installing dependencys\n ${NC}"
            nix-env -iA nixpkgs.git
        else
            printf "${red}[!] Please install ${Maginta}git${yellow} with your package manager(git-scm.com/book/en/v2/getting-started-installing-git)\n ${NC}"
            exit 127
        fi
    elif command -v install > /dev/null; then
        installc=true
    elif ! command -v cp > /dev/null; then
        printf "${red}[!] ${Maginta}cp${yellow}: command not found\n ${NC}"
        exit 127
    elif ! command -v rm > /dev/null; then
        exit 127
    fi
fi

if [ -e /tmp/src ]; then
    printf "${red}[!] ${Maginta}/tmp/src${yellow} exist, deleting\n ${NC}"
    rm -rf /tmp/src
fi


printf "${green}[*] Cloning gh repo into ${Maginta}/tmp/src\n ${NC}"
if [ $ghc = true ]; then
    gh repo clone div-styl/gitpush /tmp/src #|| ec=$?; printf "An error had occured during gh repo clone dotfiles\n"; exit $ec
    if [ ! -e /tmp/dots.tmp ]; then
        printf "${red}[!] ${Maginta}src${yellow} did not clone Successfully"
        exit 1
    fi
else
    git clone https://github.com/div-styl/gitpush.git /tmp/src #|| ec=$?; printf "An error had occured during git clone\n"; exit $ec
    if [ ! -e /tmp/src ]; then
        printf "${red}[!] ${Maginta}src${yellow} did not clone Successfully from git\n ${NC}"
        exit 1
    fi
fi

cd /tmp/src
printf "${green}[*] Building files... ${NC}"
make || ec=$?; printf "${red}[!] An error had occured during make\ncheckout in ${Maginta}/tmp/src${yellow}... ${NC}"; cd -; exit $ec
cd -

    printf "${blue}[?] Install into 1. ${Maginta}/usr/bin${red} 2. ${Maginta}/usr/local/bin${blue}?(1/2):  ${NC}"
read ipath;
while [ ! $ipath ]; do
        printf "${blue}[?] Install into 1. ${Maginta}/usr/bin${red} 2. ${Maginta}/usr/local/bin${blue}?(1/2):  ${NC}"

    read ipath;
done

if [ $ipath ]; then
    echo
    while [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; do
        printf "${blue}[?] Install into 1. ${Maginta}/usr/bin${red} 2. ${Maginta}/usr/local/bin${blue}?(1/2):  ${NC}"
        read ipath;
    done
    elif [ $ipath -eq 1 ] || [ $ipath -eq 2 ]; then
        if [ $ipath -eq 1 ]; then
            ipath="/usr/bin"
        elif [ $ipath -eq 2 ]; then
            ipath="/usr/local/bin"
        if [ $installc ]; then
            printf "${green}[*] Installing ${Maginta}/tmp/src/gitauto${green} into ${Maginta}$ipath ${green}with \`install\` ${NC}"
            pkexec install /tmp/src/gitauto $ipath
        elif [ ! $installc ]; then
            printf "${green}[*] Installing ${Maginta}/tmp/src/gitauto${green} into ${Maginta}$ipath ${green}with \`cp\` ${NC}"
            pkexec cp /tmp/src/gitauto $ipath
        fi
    fi
fi

printf "${green}[*] Cleaning up... ${NC}"
rm -rf /tmp/src || printf "${red}[!] Faild to clean cache, please remove manully"

printf "${green}[!] All done. Exiting...\n ${NC}"
exit 0
