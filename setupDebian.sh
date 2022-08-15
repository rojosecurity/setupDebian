#!/bin/bash

# verificar si tenemos privilegios root


if [[ $(id -u) != 0 ]]; then

    echo "EJECUTA EL SCRIPT COMO ROOT"
    exit 1

fi


# Modificación del PATH (no existen algunos directorios)

directoriosFaltantes='/usr/local/sbin:/usr/sbin:/sbin'

if [[ $PATH != $directoriosFaltantes ]];then
    
    export PATH=$PATH:$directoriosFaltantes
    echo -e "# PATH completa  \n export PATH=$PATH:$directoriosFaltantes" >> ~/.bashrc        

fi

# MANTENER UNA INSTALACIÓN LIMPIA (remover juegos y aplicaciones innecesarias)

apt autoremove --purge gnome-games gnome-music gnome-weather termit libreoffice transmission -y

# INSTALACIÓN DE EXTENSIONES

apt install gnome-shell-extension-dashtodock gnome-shell-extension-top-icons-plus


# FUNCIONES PARA INSTALACION DE PAQUETES DE TERCEROS

vscode(){

sudo snap install --classic code
exit 1

}

vmwareworkstation(){
    wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
    chmod +x getplayer-linux
    ./getplayer-linux --required --eulas-agreed
    exit 1
}

anydesk(){
    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
    echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
    apt update && apt install anydesk
    exit 1
}

# INSTALACIÓN DE PAQUETES Y BINARIOS

apt install gcc make net-tools gpg curl build-essential tmux vlc -y
apt install git vim thunderbird keepassxc qbittorrent chromium-common snapd remmina -y 

vscode
vmwareworkstation
anydesk

# ACTUALIZAR HEADERS

apt update linux-headers-$(uname -a)




