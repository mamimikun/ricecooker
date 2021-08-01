#!/bin/sh

# rices a fresh arch linux install. Should be run on a brand new system as root

git_install () { # args: <url> [ pkg ]
    cd /home/$RC_USERNAME/build
    sudo -u $RC_USERNAME git clone $1
    # get the newest dir
    DIR=$(ls --sort=time | head -n 1)
    cd $DIR
    if [ $2 == "pkg" ]
    then
	sudo -u $RC_USERNAME makepkg -si --noconfirm 
    else	
 	make clean install
    fi
    cd /home/$RC_USERNAME
}

pacman_install () { # args: <prog_name>
    # runs as root
    pacman -S $1 --noconfirm --needed
}

yay_install () { # args: <prog_name>
    sudo -u $RC_USERNAME yay -S $1 --noconfirm --needed
}

prog_installer () {

    pacman -Syu --noconfirm --needed
    
    sudo -u $RC_USERNAME mkdir /home/$RC_USERNAME/build
    
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
    
    # install the git programs. ran as root
    for PROG_NAME in ${GIT_PROGS[*]}
    do
	git_install $PROG_NAME
    done
}

dot_grabber () {
    cd /home/$RC_USERNAME
    sudo -u $RC_USERNAME mkdir .dot
    sudo -u $RC_USERNAME \
	 git clone --bare https://github.com/mamimikun/dot.git \
	 /home/$RC_USERNAME/.dot
    sudo -u $RC_USERNAME git --git-dir=/home/$RC_USERNAME/.dot/ \
	 --work-tree=/home/$RC_USERNAME checkout
}

user_create () {

    echo 'adding timezone...'
    ln -sf /usr/share/zoneinfo/$RC_TIMEZONE_REGION/$RC_TIMEZONE_CITY \
       /etc/localtime
    
    hwclock --systohc

    # etc stuff
    echo 'generating locale...'
    sed -i 's/#'"$RC_LOCALE"'/'"$RC_LOCALE"'/g' /etc/locale.gen

    echo 'LANG='"$RC_LOCALE" > /etc/locale.conf
    locale-gen

    echo 'setting hostname...'
    echo '$RC_HOSTNAME' > /etc/hostname
    
    echo '127.0.0.1 localhost 
          ::1       localhost 
          127.0.1.1 '"$RC_HOSTNAME" > /etc/hosts

    echo 'running mkinitcpio'
    mkinitcpio -P
    
    echo '======= set new root password ======='
    passwd

    # user creation
    echo 'adding user...'
    useradd -m $RC_USERNAME
    echo '======= set new user password ======='
    passwd $RC_USERNAME
}

priv_setter () {
    # user privileges
    echo "$RC_USERNAME"' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
}

rc_check () {
    [ -z "$RC_USERNAME" ] && echo 'RC_USERNAME not filled out' && exit
    [ -z "$RC_TIMEZONE_REGION" ] && echo 'RC_TIMEZONE_REGION not filled out' \
	&& exit
    [ -z "$RC_TIMEZONE_CITY" ] && echo 'RC_TIMEZONE_CITY not filled out' && exit
    [ -z "$RC_HOSTNAME" ] && echo 'RC_HOSTNAME not filled out' && exit
    [ -z "$RC_LOCALE" ] && echo 'RC_LOCALE not filled out' && exit
}

main () {
    source ./rc_vars.sh
    rc_check
    source progs/pacman_progs.sh
    source progs/aur_progs.sh
    source progs/git_progs.sh
    
    user_create
    priv_setter
    
    prog_installer
    dot_grabber
}

main
