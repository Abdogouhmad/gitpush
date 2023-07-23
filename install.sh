#!/bin/env bash

#  Copyright (C) 2023 littleblack111 <https://github.com/littleblack111/>

# colors variables
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
cyan="\033[0;36m"
white="\033[0;37m"
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
    printf "[!] make: command not found\nthis program need to compile with Makefile please install make\n"
    exit 127
fi
if ! command -v cc && ! command -v gcc > /dev/null; then
    printf "[!] c compiler: command not found\nthis program need to compile c program, please install gcc compiler\n"
    exit 127
fi

if [ $ghc != true ]; then
    if ! command -v git > /dev/null; then
        printf "[*] git: command not found\n"
        if command -v pacman > /dev/null; then
            printf "[*] pacman: installing dependencys\n"
            sudo pacman -S git --noconfirm
        elif command -v apt-get > /dev/null; then
            printf "[*] apt-get: installing dependencys\n"
            sudo apt-get -y git
        elif command -v yum > /dev/null; then
            printf "[*] yum: installing dependencys\n"
            sudo yum install -y git
        elif command -v zypper > /dev/null; then
            printf "[*] zypper: installing dependencys\n"
            sudo zypper install -y git
        elif command -v emerge > /dev/null; then
            printf "[*] emerge: installing dependencys\n"
            emerge git
        elif command -v nix > /dev/null; then
            printf "[*] nix: installing dependencys\n"
            nix-env -iA nixpkgs.git
        else
            printf "[!] Please install git with your package manager(git-scm.com/book/en/v2/getting-started-installing-git)\n"
            exit 127
        fi
    elif command -v install > /dev/null; then
        installc=true
    elif ! command -v cp > /dev/null; then
        printf "[*] cp: command not found\n"
        exit 127
    elif ! command -v rm > /dev/null; then
        exit 127
    fi
fi

if [ -e /tmp/gitpush.tmp ]; then
    printf "[!] /tmp/gitpush.tmp exist, deleting\n"
    rm -rf /tmp/gitpush.tmp
fi


printf "[*] Cloning gh repo into /tmp/gitpush.tmp\n"
if [ $ghc = true ]; then
    gh repo clone div-styl/gitpush /tmp/gitpush.tmp #|| ec=$?; printf "An error had occured during gh repo clone dotfiles\n"; exit $ec
    if [ ! -e /tmp/dots.tmp ]; then
        printf "[!] src did not clone Successfully"
        exit 1
    fi
else
    git clone https://github.com/div-styl/gitpush.git /tmp/gitpush.tmp #|| ec=$?; printf "An error had occured during git clone\n"; exit $ec
    if [ ! -e /tmp/gitpush.tmp ]; then
        printf "[!] src did not clone Successfully"
        exit 1
    fi
fi

cd /tmp/gitpush.tmp
printf "[*] Building files..."
make || ec=$?; printf "[!] An error had occured during make\ncheckout in /tmp/gitpush.tmp..."; cd -; exit $ec
cd -

printf "[?] Install into 1. /usr/bin 2. /usr/local/bin?(1/2): "
read ipath;
while [ ! $ipath ]; do
    printf "[?] Install into 1. /usr/bin 2. /usr/local/bin?(1/2): "
    read ipath;
done

if [ $ipath ]; then
    echo
    if [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; then
        printf "Please enter number 1 or 2"
        while [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; do
            printf "[?] Install into 1. /usr/bin 2. /usr/local/bin?(1/2): "
        done
    fi
    elif [ $ipath -eq 1 ] || [ $ipath -eq 2 ]; then
        if [ $ipath -eq 1 ]; then
            ipath="/usr/bin"
        elif [ $ipath -eq 2 ]; then
            ipath="/usr/local/bin"
        if [ $installc ]; then
            pkexec install /tmp/gitpush.tmp/pushc $ipath
        elif [ ! $installc ]; then
            pkexec cp /tmp/gitpush.tmp/pushc $ipath
        fi
    fi
fi

printf "[*] Cleaning up..."
rm -rf /tmp/gitpush.tmp || printf "[!] Faild to clean cache, please remove manully"

printf "[*] Installing configs from /tmp/gitpush.tmp to $HOME/\n"
printf "[!] All done. Exiting...\n"
exit 0
