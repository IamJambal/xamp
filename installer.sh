#!/bin/bash

function echo_title() {     echo -ne "\033[1;44;37m${*}\033[0m\n"; }
function echo_caption() {   echo -ne "\033[0;1;44m${*}\033[0m\n"; }
function echo_bold() {      echo -ne "\033[0;1;34m${*}\033[0m\n"; }
function echo_danger() {    echo -ne "\033[0;31m${*}\033[0m\n"; }
function echo_success() {   echo -ne "\033[0;32m${*}\033[0m\n"; }
function echo_warning() {   echo -ne "\033[0;33m${*}\033[0m\n"; }
function echo_secondary() { echo -ne "\033[0;34m${*}\033[0m\n"; }
function echo_info() {      echo -ne "\033[0;35m${*}\033[0m\n"; }
function echo_primary() {   echo -ne "\033[0;36m${*}\033[0m\n"; }
function echo_error() {     echo -ne "\033[0;1;31merror:\033[0;31m\t${*}\033[0m\n"; }
function echo_label() {     echo -ne "\033[0;1;32m${*}:\033[0m\t"; }
function echo_prompt() {    echo -ne "\033[0;36m${*}\033[0m "; }

function splash() {
    local hr
    hr=" **$(printf "%${#1}s" | tr ' ' '*')** "
    echo_title "${hr}"
    echo_title " * $1 * "
    echo_title "${hr}"
    echo
}

function check_root() {
    # Checking for root access and proceed if it is present
    ROOT_UID=0
    if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
        # Error message
        echo_error 'Run me as root.'
        echo_info 'try sudo ./install.sh'
        exit 1
    fi
}
function downloads() {
    echo_primary 'Download Xampp'
    mkdir res && cd res && wget -O xampp.run https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.0.25/xampp-linux-x64-8.0.25-0-installer.run
}
function installer() {
    echo_primary 'Menginstall Xampp'
    chmod +x xampp.run
    echo_primary 'Close Xampp Kalau Sudah Selesai Install'
    sudo ./xampp.run
    exec bash
}
function modif() {
    echo_primary 'Memodifikasi Beberapa Konfigurasi'
    echo alias xamp="sudo /opt/lampp/lampp" >> ~/.bash_aliases
    sudo chmod -R 755 /opt/lampp/htdocs/
    ln -s /opt/lampp/htdocs/ ~/Desktop/xampp
}
function main() {
    splash 'Xampp Installer'
    echo_success 'Powered by github.com/iamjambal'

    check_root
    downloads
    installer

    modif
   
    echo_success 'All done !'
    echo_warning 'Untuk Start stop restart xampp sudah saya konfigurasi untuk mempermudah'
    echo_warning 'tinggal ketik'
    echo_warning 'xamp {command : start, stop, restart}'
}

main
