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
bold="\033[1m"
tmpdir="/tmp/src.tmp"
installbinpath="$tmpdir/gitauto"
installshpath="$tmpdir/push.sh"


function installexec() {
    ipath=0
    while [ ! $ipath ] || [ ! $ipath -eq 1 ] || [ ! $ipath -eq 2 ]; do
		printf "${blue}[+] Where would you like to install it? (1. ${Maginta}/usr/bin${green} 2. ${Maginta}/usr/local/bin${green}): "
        read ipath;
    done
    if [ $ipath -eq 1 ] || [ $ipath -eq 2 ]; then
        if [ $ipath -eq 1 ]; then
				    ipath="/usr/bin"
				elif [ $ipath -eq 2 ]; then
				    ipath="/usr/local/bin"
				fi
		fi
    if [ $installc ]; then
				if [ $1 -eq 1 ]; then
				    printf "${green}[*] Installing ${Maginta}$installbinpath${green} into ${Maginta}$ipath ${green}with \`install\` ${NC}"
					$elevate "install $installbinpath $ipath" || sudo install $installbinpath $ipath || printf "${red}${bold}Faild to install into path with elevated(with ${Maginta}$elevate${green}) privilege\n"; exit 1
				elif [ $1 -eq 2 ]; then
				    printf "${green}[*] Installing ${Maginta}$installshpath${green} into ${Maginta}$ipath ${green}with \`install\` ${NC}"
				    $elevate "install $installshpath $ipath" || sudo install $installshpath $ipath || printf "${red}${bold}Faild to install into path with elevated(with ${Maginta}$elevate${green}) privilege\n"; exit 1
				fi
    elif [ ! $installc ]; then
				if [ $1 -eq 1 ]; then
				    printf "${green}[*] Installing ${Maginta}$installbinpath${green} into ${Maginta}$ipath ${green}with \`cp\` ${NC}"
				    $elevate "cp $installbinpath $ipath" || sudo cp $installbinpath $ipath || printf "${red}${bold}Faild to install into path with elevated(with ${Maginta}$elevate${green}) privilege\n"; exit 1
				fi
				if [ $1 -eq 2 ]; then
				    printf "${green}[*] Installing ${Maginta}$installshpath${green} into ${Maginta}$ipath ${green}with \`cp\` ${NC}"
				    $elevate "cp $installshpath $ipath" || sudo cp $installshpath $ipath || printf "${red}${bold}Faild to install into path with elevated(with ${Maginta}$elevate${green}) privilege\n"; exit 1
				fi
		fi
}

printf "${green}[*] Checking if system have required packages and commands\n${NC}"
if command -v gh > /dev/null; then
    ghc=true
fi

if ! command -v make > /dev/null; then
    printf "${red}${bold}[!] ${Maginta}make${red}${bold}: command not found\nthis program need to compile with Makefile please install make\n ${NC}"
    exit 127
fi
if ! command -v cc && ! command -v gcc > /dev/null; then
    printf "${red}${bold}[!] ${Maginta}c compiler(gcc)${red}${bold}: command not found\nthis program need to compile c program, please install gcc compiler\n${NC}"
    exit 127
fi
if command -v install > /dev/null; then
    installc=true
fi
if ! command -v cp > /dev/null; then
    printf "${red}${bold}[!] ${Maginta}cp${red}${bold}: command not found\n ${NC}"
    exit 127
fi
if ! command -v rm > /dev/null; then
    exit 127
fi
if ! command -v pkexec > /dev/null; then
    if ! command -v gksudo > /dev/null; then
		if ! command -v sudo > /dev/unll; then
		    if ! command -v su > /dev/null; then
				printf "${red}${bold}[!] Could not find any command to elevate which is required..."
		    else
				elevate="su -c"
			fi
	    else
		    elevate="sudo"
    else
		elevate="gksudo"
else
    elevate="pkexec"
fi

if [ $ghc != true ]; then
    if ! command -v git > /dev/null; then
        printf "${red}${bold}[!] ${Maginta}git${red}${bold}: command not found\n${NC}"
        if command -v pacman > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}pacman${red}${bold}: installing dependencys\n ${NC}"
            sudo pacman -S git --noconfirm
        elif command -v apt-get > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}apt-get${red}${bold}: installing dependencys\n ${NC}"
            sudo apt-get -y git
        elif command -v yum > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}yum${red}${bold}: installing dependencys\n ${NC}"
            sudo yum install -y git
        elif command -v zypper > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}zypper${red}${bold}: installing dependencys\n ${NC}"
            sudo zypper install -y git
        elif command -v emerge > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}emerge${red}${bold}: installing dependencys\n ${NC}"
            emerge git
        elif command -v nix > /dev/null; then
            printf "${red}${bold}[!] ${Maginta}nix${red}${bold}: installing dependencys\n ${NC}"
            nix-env -iA nixpkgs.git
        else
            printf "${red}${bold}[!] Please install ${Maginta}git${red}${bold} with your package manager(git-scm.com/book/en/v2/getting-started-installing-git)\n ${NC}"
            exit 127
        fi
    fi
fi

vertype=0
while [ ! $vertype ] || [ ! $vertype -eq 1 ] || [ $vertype -eq 2 ]; do
	printf "${blue}[+] Would you like to install 1. ${Maginta}C(recommanded)${green} 2. ${Maginta}bash${green}, version(1/2): ${NC}"
	read vertype
done

if [ $vertype ]; then
    if [ $vertype -eq 1]; then
		cv=true
    elif [ $vertype -eq 2]; then
		bv=true
	fi
fi


if [ -d $tmpdir ]; then
    printf "${red}${bold}[!] ${Maginta}$tmpdir${red}${bold} exist, deleting\n ${NC}"
    rm -rf $tmpdir
fi


if [ $ghc = true ]; then
    printf "${green}[*] Cloning div-styl/gitpush.git with gh repo clone into ${Maginta}$tmpdir\n ${NC}"
    gh repo clone div-styl/gitpush $tmpdir #|| ec=$?; printf "An error had occured during gh repo clone dotfiles\n"; exit $ec
    if [ ! -d /tmp/dots.tmp ]; then
        printf "${red}${bold}[!] ${Maginta}$tmpdir${red}${bold} did not clone Successfully from gh\n ${NC}"
        exit 1
    fi
else
    printf "${green}[*] Cloning div-styl/gitpush.git with git clone into ${Maginta}$tmpdir\n ${NC}"
    git clone https://github.com/div-styl/gitpush.git $tmpdir #|| ec=$?; printf "An error had occured during git clone\n"; exit $ec
    if [ ! -d $tmpdir ]; then
        printf "${red}${bold}[!] ${Maginta}$tmpdir${red}${bold} did not clone Successfully from git\n ${NC}"
        exit 1
    fi
fi


if [ $cv ]; then
	if [ -d $tmpdir ]; then
		printf "${green}[*] Building ${Maginta}files${green} with ${Maginta}make${green}... ${NC}"
		make -C $tmpdir || ec=$?; printf "${red}${bold}[!] An error had occured during make\ncheckout in ${Maginta}$tmpdir${red}${bold}... ${NC}"; cd -; exit $ec
	elif [ ! -d $tmpdir ]; then
		printf "${red}${bold}[!] $tmpdir directory not found..."
		exit 1
	fi
	installexec 1
elif [ $bv ]; then
    if [ -d $tmpdir ]; then
		installexec 2
    elif [ ! -d $tmpdir ]; then
	printf "${red}${bold}[!] $tmpdir directory not found..."
	exit 1
    fi
else
    printf "${red}${bold}[!] An unexpected error had occured about what version of installation would you like..."
    exit -255
fi

if [ -d $tmpdir ]; then
    printf "${green}[*] Cleaning up... ${NC}"
    rm -rf $tmpdir || printf "${red}${bold}[!] Faild to clean cache, please remove manully"
elif [ ! -d $tmpdir ]; then
    printf "${yellow}[!] '$tmpdir' not found, might have problem with you'r install"
fi

printf "${green}${bold}[*!*] All done. Exiting...\n ${NC}"
exit 0
