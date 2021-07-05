#!/bin/sh

PACMAN_PROGS=(

    # graphics

    'xorg' # display server
    'xorg-xinit' # starts X from the command line
    'xwallpaper' # sets the wallpaper
    
    # media
    
    'arandr' # monitor layouts
    'flameshot' # screenshotter
    'inkscape' # useful for editing pdfs and other vector stuff
    'gimp' # quintessential image editor
    'vlc' # media player
    'mpv' # minimal media player
    'cmus' # terminal music player
    'pdftk' # really handy pdf tool
    
    # network
    
    'firefox' # web browser
    'chromium' # web browser
    'networkmanager' # convenient network tool
    'dhclient' # dhcp client
    'ntp' # software clocksync

    # disk
    
    'udiskie' # automounting tool

    # audio

    'alsa-utils' # alsa utilities
    'alsa-plugins' # alsa plugins
    'pulseaudio' # audio system
    'pavucontrol' # audio controls

    # dev

    'emacs' # operating system with builtin text editor
    'git' # vcs
    'python' # programming language
    'ruby' # programming language
    'clang' # cool c compiler

    # utils

    'curl' # url tool
    'feh' # image viewer
    'htop' # top with steroids
    'openssh' # openBSD's ssh
    'unrar' # rar utility
    'unzip' # zip utility
    'udiskie' # automount utility
    'tmux' # terminal mux

    # fonts (no description provided)

    'ttf-dejavu'
    'gnu-free-fonts'
    'ttf-ibm-plex'
    'adobe-source-han-sans-otc-fonts'
    'adobe-source-han-serif-otc-fonts'

    # extras

    'neofetch' # cool system info viewer
    'cmatrix' # matrix terminal
    'fcitx5-im' # cjk input support
    'fcitx5-mozc' # japanese input support
    
)
