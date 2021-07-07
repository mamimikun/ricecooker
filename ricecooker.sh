#!/bin/sh

# rices a fresh arch linux install. meant to be run with root privileges

git_install () { # args: <url> [ pkg ]
    cd /etc/git_progs
    git clone $1
    # get the newest dir
    DIR=$(ls --sort=time | head -n 1)
    cd $DIR
    if [ $2 == "pkg" ]
    then
	makepkg -si --noconfirm
    else	
	make clean install
    fi
}

pacman_install () { # args: <prog_name>
    pacman -S $1 --noconfirm --needed
}

yay_install () { # args: <prog_name>
    yay -S $1 --noconfirm --needed
}

prog_installer () {

    # update the stuff first
    pacman -Syu 
    mkdir /etc/git_progs
    
    # install the pacman programs
    for PROG_NAME in ${PACMAN_PROGS[*]}
    do
	pacman_install $PROG_NAME
    done
    # install yay
    git_install https://aur.archlinux.org/yay.git pkg
    # install the aur programs
    for PROG_NAME in ${AUR_PROGS[*]}
    do
	yay_install $PROG_NAME
    done
    # install the git programs
    for PROG_NAME in ${GIT_PROGS[*]}
    do
	git_install $PROG_NAME
    done
}

dot_grabber () {
    cd
    mkdir .dot
    git clone --bare https://github.com/mamimikun/dot.git $HOME/.dot
    git --git-dir=$HOME/.dot/ --work-tree=$HOME checkout
    
}

source progs/pacman_progs.sh
source progs/aur_progs.sh
source progs/git_progs.sh
prog_installer
